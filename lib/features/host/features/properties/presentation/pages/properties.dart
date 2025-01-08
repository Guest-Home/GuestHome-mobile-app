import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:minapp/features/host/features/properties/presentation/bloc/properties_bloc.dart';
import '../../../../../../config/color/color.dart';
import '../../../../../../core/common/custom_button.dart';
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
        body: CustomScrollView(
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
          pinned: true,
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
                child: SearchField(
                  prifixIcon: Icon(Icons.search),
                  onTextChnage: (value) {},
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
    ));
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
