import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:minapp/features/host/features/properties/presentation/bloc/properties_bloc.dart';
import '../../../../../../config/color/color.dart';
import '../../../../../../core/common/custom_button.dart';
import '../../../../../../service_locator.dart';
import '../bloc/search_property/search_property_bloc.dart';
import '../widgets/property_card.dart';
import '../widgets/search_filed.dart';

class Properties extends StatefulWidget {
  const Properties({super.key});

  @override
  State<Properties> createState() => _PropertiesState();
}

class _PropertiesState extends State<Properties> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: RefreshIndicator(
      backgroundColor: ColorConstant.primaryColor,
      color: Colors.white,
      onRefresh: () async {
        context.read<PropertiesBloc>().add(GetPropertiesEvent());
      },
      child: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: Colors.white,
            title: Text(
              'Properties',
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .copyWith(fontWeight: FontWeight.bold),
            ),
            floating: true,
            snap: true,
            pinned: false,
            expandedHeight: 150,
            collapsedHeight: 150,
            elevation: 0,
            shadowColor: Colors.transparent,
            scrolledUnderElevation: 0,
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              collapseMode: CollapseMode.pin,
              title: Container(
                  padding: EdgeInsets.all(16),
                  child: BlocProvider(
                    create: (context) => sl<SearchPropertyBloc>(),
                    child: BlocBuilder<SearchPropertyBloc, SearchPropertyState>(
                      buildWhen: (previous, current) => previous!=current,
                      builder: (context, state) {
                        return CustomSearchAnchor(state: state,);
                      },
                    ),
                  )),
            ),
          ),
          BlocBuilder<PropertiesBloc, PropertiesState>(
            builder: (context, state) {
              if (state is PropertiesLoading) {
                return SliverToBoxAdapter(
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height / 2,
                    child: Center(
                      child: CupertinoActivityIndicator(),
                    ),
                  ),
                );
              } else if (state is PropertyLoaded) {
                if (state.properties.isEmpty) {
                  return SliverToBoxAdapter(
                      child: SizedBox(
                          height: MediaQuery.of(context).size.height / 2,
                          child: NoPropertyFound()));
                } else {
                  return SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) => GestureDetector(
                          onTap: () => context.pushNamed('propertyDetail',
                              extra: state.properties[index]),
                          child: PropertyCard(
                            propertyEntity: state.properties[index],
                          )),
                      childCount: state.properties.length,
                    ),
                  );
                }
              } else if (state is PropertiesError) {
                return SliverToBoxAdapter(
                  child: SizedBox(
                    child: Text(state.message),
                  ),
                );
              }
              return SliverToBoxAdapter(child: SizedBox.shrink());
            },
          ),
        ],
      ),
    ));
  }
}

class CustomSearchAnchor extends StatefulWidget {
  const CustomSearchAnchor({
    super.key,
    required this.state
  });

  final SearchPropertyState state;
  @override
  State<CustomSearchAnchor> createState() => _CustomSearchAnchorState();
}

class _CustomSearchAnchorState extends State<CustomSearchAnchor> {
  @override
  Widget build(BuildContext context) {
    return SearchAnchor(
      dividerColor: ColorConstant.cardGrey,
      isFullScreen: true,
      viewHintText: 'search',
      viewLeading: IconButton(
          onPressed: () {
            context.read<SearchPropertyBloc>().add(ResetEvent());
            context.pop();
          },
          icon: const Icon(Icons.arrow_back_ios)),
      viewOnChanged: (value) {
        if (value.isNotEmpty) {
          context.read<SearchPropertyBloc>().add(SearchEvent(name: value));
        }
      },
      builder: (context, controller) => SearchField(
        prifixIcon: Icon(Icons.search),
        onTextChnage: (value) {},
      ),
      suggestionsBuilder: (context, controller) =>[],
      viewBuilder: (suggestions) {
        final state = widget.state;
        // React to the current state
        if (state is SearchPropertyLoading) {
          return Center(
            child: CupertinoActivityIndicator(),
          );
        } else if (state is SearchPropertyLoaded) {

          return state.properties.isNotEmpty? GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
            ),
            itemCount:state.properties.length,
            itemBuilder: (context, index) {
              return Text(state.properties[index].title); // Replace with your UI
            },
          ): Center(child: Text("no property found"));
        }
        return Center(child: Text("search property"));
      },
    );
  }
}

class NoPropertyFound extends StatelessWidget {
  const NoPropertyFound({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Text(
          'Lorem ipsum dolor sit amet consectetur. Est netus commodo mattis lectus nam lacinia hac sapien.',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontSize: 16),
        ),
        Padding(
            padding: const EdgeInsets.all(20),
            child: CustomButton(
              style: ElevatedButton.styleFrom(
                  elevation: 0,
                  shadowColor: ColorConstant.primaryColor,
                  backgroundColor: ColorConstant.primaryColor,
                  padding: EdgeInsets.all(20),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10))),
              onPressed: () => context.goNamed('addProperty'),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.add, color: Colors.white),
                  Text(
                    'Add Property',
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: Colors.white, fontWeight: FontWeight.w700),
                  )
                ],
              ),
            ))
      ]),
    );
  }
}
