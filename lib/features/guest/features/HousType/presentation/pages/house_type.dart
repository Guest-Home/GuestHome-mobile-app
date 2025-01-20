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
              .copyWith(fontWeight: FontWeight.w700,fontSize: 18),
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
                height: MediaQuery.of(context).size.height * 0.31,
                width: MediaQuery.of(context).size.width,
                child: CarouselView(
                    itemExtent: MediaQuery.of(context).size.width,
                    backgroundColor: ColorConstant.cardGrey.withValues(alpha: 0.6),
                    children: List.generate(
                      1,
                      (index) => Stack(
                        children: [
                          ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: CachedNetworkImage(
                                imageUrl:
                                    "https://media.architecturaldigest.com/photos/57e42deafe422b3e29b7e790/master/pass/JW_LosCabos_2015_MainExterior.jpg",
                                placeholder: (context, url) =>
                                    CupertinoActivityIndicator(),
                                errorWidget: (context, url, error) =>
                                    Icon(Icons.error),
                                fit: BoxFit.cover,
                                width: MediaQuery.of(context).size.width,
                                height: MediaQuery.of(context).size.height * 0.31,

                              ),
                            ),
                          Positioned(
                            bottom: 5,
                            left: 13,
                            right: 20,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "Discover the ultimate solution for all your property needs with our app.",
                                textAlign: TextAlign.start,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white),
                              ),
                            ),
                          )
                        ],
                      ),
                    ))),
            SecctionHeader(
              title: "What are you looking for?",
              isSeeMore: false,
            ),
            // house type
            BlocBuilder<PropertyTypeBloc, PropertyTypeState>(
              builder: (context, state) {
                if(state is PropertyTypeLoadingState || state.propertyTypes.isEmpty){
                  return Center(child:loadingIndicator(),);
                }
                return GridView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                      mainAxisExtent: 100),
                  itemCount: state.propertyTypes.length,
                  itemBuilder: (context, index) => GestureDetector(
                    onTap: () {
                      context.goNamed("houseTypeDetail",
                          extra: state.propertyTypes[index].propertyType);
                    },
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
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
