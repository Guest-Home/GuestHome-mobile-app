import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:minapp/config/color/color.dart';
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
                height: MediaQuery.of(context).size.height * 0.27,
                width: MediaQuery.of(context).size.width,
                child: RepaintBoundary(
                  child: Stack(
                    children:[
                      CarouselView(
                        itemExtent: MediaQuery.of(context).size.width,
                        backgroundColor:
                            ColorConstant.cardGrey.withValues(alpha: 0.6),
                        children: List.generate(
                          3,
                          (index) =>
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.asset("assets/icons/img${index+1}.png",
                                  fit: BoxFit.fill,
                                  width: MediaQuery.of(context).size.width,
                                  height:
                                  MediaQuery.of(context).size.height * 0.27,
                                ),),

                        )),
                      Positioned(
                          bottom: 8,
                          left: 0,
                          right: 0,
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                    height: 17,
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 5),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(100),
                                      color: Colors.black.withValues(alpha: 0.2),
                                    ),
                                    child: Row(
                                      children: List.generate(
                                          3,
                                              (index) => Container(
                                            width: 5,
                                            height: 5,
                                            margin: EdgeInsets.only(right: 5),
                                            decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: Colors.white),
                                          )),
                                    ))
                              ]))
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
              },
              child: BlocBuilder<PropertyTypeBloc, PropertyTypeState>(
                builder: (context, state) {
                  if (state is PropertyTypeLoadingState ||
                      state.propertyTypes.isEmpty) {
                    return Center(
                      child: loadingIndicator(),
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
