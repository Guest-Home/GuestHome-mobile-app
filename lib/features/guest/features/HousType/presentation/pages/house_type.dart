import 'package:carousel_slider/carousel_slider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:minapp/config/color/color.dart';
import 'package:minapp/core/common/constants/house_type_icons.dart';
import 'package:minapp/core/common/custom_button.dart';
import 'package:minapp/core/common/loading_indicator_widget.dart';
import 'package:minapp/features/guest/features/HousType/presentation/widgets/section_header_text.dart';

import '../../../../../../core/common/house_type_card.dart';
import '../../../../../../core/utils/show_snack_bar.dart';
import '../../../../../host/features/properties/presentation/bloc/property_type/property_type_bloc.dart';

class HouseType extends StatefulWidget {
  const HouseType({super.key});

  @override
  State<HouseType> createState() => _HouseTypeState();
}

class _HouseTypeState extends State<HouseType> {
  int photoIndex=0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "GuestHome",
          style: Theme.of(context)
              .textTheme
              .bodyLarge!
              .copyWith(fontWeight: FontWeight.w700, fontSize: 18),
        ),
        actions: [
          Icon(Icons.notifications_none),
          SizedBox(
            width: 10,
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(15),
        child: Column(
          spacing: 15,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //carousel
            SizedBox(
                height: MediaQuery.of(context).size.height * 0.30,
                width: MediaQuery.of(context).size.width,
                child: RepaintBoundary(
                  child: Stack(
                    children:[
                      CarouselSlider.builder(
                        options:CarouselOptions(
                          height: MediaQuery.of(context).size.height * 0.36,
                          aspectRatio: 16/9,
                          viewportFraction:1,
                          initialPage: 0,
                          enableInfiniteScroll: false,
                          reverse: false,
                          autoPlay: true,
                          autoPlayInterval: Duration(seconds: 3),
                          autoPlayAnimationDuration: Duration(milliseconds: 800),
                          autoPlayCurve: Curves.fastOutSlowIn,
                          enlargeCenterPage: true,
                          onPageChanged: (index, reason) {
                            setState(() {
                              photoIndex=index;
                            });
                          },
                          enlargeFactor: 0.3,
                          scrollDirection: Axis.horizontal,
                        ),
                        itemCount:3,
                        itemBuilder: (BuildContext context, int itemIndex, int pageViewIndex) =>
                            ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: Image.asset("assets/icons/img${itemIndex+1}.png",
                                  fit: BoxFit.fill,
                                  width: MediaQuery.of(context).size.width,
                                  height:
                                  MediaQuery.of(context).size.height * 0.27,
                                ),
                            ),
                      ),
                      Positioned(
                          bottom: 10,
                          left: 0,
                          right: 0,
                          child:
                          Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                    height: 18,
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 5),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(100),
                                      color:
                                      Colors.black.withValues(alpha: 0.2),
                                    ),
                                    child: Row(
                                      children: List.generate(
                                          3,
                                              (index) => AnimatedContainer(
                                            duration:
                                            Duration(milliseconds: 800),
                                            width: 7,
                                            height: 7,
                                            margin:
                                            EdgeInsets.only(right: 5),
                                            decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: index == photoIndex
                                                    ? Colors.white
                                                    : ColorConstant.cardGrey
                                                    .withValues(
                                                    alpha: 0.4)),
                                          )),
                                    ))
                              ]))

                      // Positioned(
                      //   bottom:10,
                      //     left: 10,right: 10,
                      //     child: Padding(
                      //       padding: const EdgeInsets.all(8.0),
                      //       child: Text("Discover the ultimate solution for all your property needs with our app.",
                      //       textAlign: TextAlign.start,
                      //       style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      //         color: Colors.white,
                      //         fontWeight: FontWeight.w600,
                      //         fontSize: 16
                      //
                      //       ),
                      //       ),
                      //     ))
        ]
                  ),
                )),
            SecctionHeader(
              title:tr("what are you looking for?"),
              isSeeMore: false,
            ),
            // house type
            BlocListener<PropertyTypeBloc, PropertyTypeState>(
              listener: (context, state) {
                if (state is NoInternetSate) {
                  noInternetDialog(context);
                }
                // else if(state is PropertyTypeError){
                //   showDialog(context: context, builder: (context) => AlertDialog(
                //     content: Text(state.failure.message),
                //   ),);
                // }
              },
              child: BlocBuilder<PropertyTypeBloc, PropertyTypeState>(
                builder: (context, state) {
                  if (state is PropertyTypeLoadingState
                      ) {
                    return Center(
                      child: loadingIndicator(),
                    );
                  }
                  else  if (state is PropertyTypeError) {
                    return  Center(
                        child: Column(
                          spacing: 10,
                          children: [
                            Icon(Icons.error_outline,color: ColorConstant.red,),
                             Text(state.failure.message),
                            CustomButton(
                                onPressed: () {
                                  context.read<PropertyTypeBloc>().add(GetPropertyTypesEvent());
                                },
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: ColorConstant.primaryColor,
                                    padding: EdgeInsets.all(0),
                                    elevation: 0
                                ),
                                child:Text("retry",style: TextStyle(color: Colors.white),))
                          ],
                        )
                    );
                  }

                  return GridView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 12,
                        mainAxisSpacing: 12,
                        mainAxisExtent: 110),
                    itemCount: state.propertyTypes.length,
                    itemBuilder: (context, index) => GestureDetector(
                      onTap: () {
                        context.goNamed("houseTypeDetail",
                            extra: state.propertyTypes[index].propertyType);
                      },
                      child: RepaintBoundary(
                        child: AnimatedContainer(
                          duration: Duration(milliseconds: 100),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(
                                color: Colors.white,
                              )),
                          child: HouseTypeCard(
                            image: houseTypeIcons[
                                state.propertyTypes[index].propertyType]!,
                            title: state.propertyTypes[index].propertyType,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
