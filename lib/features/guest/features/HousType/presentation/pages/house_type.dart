import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:minapp/core/common/constants/house_type_icons.dart';
import 'package:minapp/core/common/loading_indicator_widget.dart';
import 'package:minapp/features/guest/features/HousType/presentation/widgets/section_header_text.dart';

import '../../../../../../core/common/house_type_card.dart';
import '../../../../../../core/utils/show_snack_bar.dart';
import '../../../../../host/features/properties/presentation/bloc/property_type/property_type_bloc.dart';

class HouseType extends StatelessWidget {
  const HouseType({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Guest Home",
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
                          enableInfiniteScroll: true,
                          reverse: false,
                          autoPlay: true,
                          autoPlayInterval: Duration(seconds: 3),
                          autoPlayAnimationDuration: Duration(milliseconds: 800),
                          autoPlayCurve: Curves.fastOutSlowIn,
                          enlargeCenterPage: true,
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
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.black12,
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      Positioned(
                        bottom:10,
                          left: 10,right: 10,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("Discover the ultimate solution for all your property needs with our app.",
                            textAlign: TextAlign.start,
                            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 16

                            ),
                            ),
                          ))
        ]
                  ),
                )),
            SecctionHeader(
              title: "What are you looking for?",
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
                    return Center(
                      child: Text(state.failure.message)
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
