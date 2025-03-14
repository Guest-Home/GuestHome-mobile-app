import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:minapp/core/common/loading_indicator_widget.dart';
import 'package:minapp/core/utils/show_snack_bar.dart';
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
              tr('Properties'),
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
              title: GestureDetector(
                onTap: () {
                  context.goNamed("hostSearch");
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: SearchField(
                    isActive: false,
                    prifixIcon: Icon(Icons.search),
                    onTextChnage: (value) {},
                  ),
                ),
              ),
            ),
          ),
          BlocConsumer<PropertiesBloc, PropertiesState>(
            listener: (context, state) {
              if (state is NoInternetSate) {
                showNoInternetSnackBar(context, () {
                  context.read<PropertiesBloc>().add(GetPropertiesEvent());
                },);
              }

            },
            builder: (context, state) {
              if (state is PropertiesLoading || state is NoInternetSate) {
                return SliverToBoxAdapter(
                  child: SizedBox(
                      height: MediaQuery.of(context).size.height / 2,
                      child: loadingIndicator()),
                );
              }
              else if(state is PropertiesError){
                return SliverToBoxAdapter(
                  child: SizedBox(
                    child: Center(
                      child: Column(
                        children: [
                          Icon(Icons.error_outline,size: 25,color: ColorConstant.red,),
                          Text(
                            state.failure.message,
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }

               else if (state.properties.isEmpty) {
                  return SliverToBoxAdapter(
                      child: SizedBox(
                          height: MediaQuery.of(context).size.height / 2,
                          child: NoPropertyFound()));
                }

               return SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) => GestureDetector(
                          onTap: () => context.pushNamed('propertyDetail',
                              extra: state.properties[index]),
                          child: PropertyCard(
                            propertyEntity: state.properties[index],
                          )).animate().fade(),
                      childCount: state.properties.length,
                    ),
                  );
                }



          ),
        ],
      ),
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
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 20,
          children: [
            Text(
              tr("No property is listed"),
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(fontSize: 16, fontWeight: FontWeight.w400),
            ),
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 26),
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
                    spacing: 10,
                    children: [
                      Icon(Icons.add, color: Colors.white),
                      Text(
                        tr('Add properties'),
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.w700),
                      )
                    ],
                  ),
                ))
          ].animate().fade()),
    );
  }
}
