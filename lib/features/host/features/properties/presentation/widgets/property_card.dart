import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../../../../config/color/color.dart';

class PropertyCard extends StatelessWidget {
  const PropertyCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      color: ColorConstant.cardGrey.withValues(alpha: 1.6),
      elevation: 0,
      child:  Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            spacing: 5,
            children: [
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child:CachedNetworkImage(
                      imageUrl:"https://media.architecturaldigest.com/photos/57e42deafe422b3e29b7e790/master/pass/JW_LosCabos_2015_MainExterior.jpg",
                      placeholder: (context, url) =>CupertinoActivityIndicator(),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                      fit: BoxFit.cover,
                      width: MediaQuery.of(context).size.width,
                      height:200,
                    ),
                  ),
                  Positioned(
                    bottom: 10,
                      left: 0,
                      right: 0,
                      child:Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: List.generate(3,(index) => Container(width: 10,
                              height:10,
                              margin: EdgeInsets.only(right: 5),
                              decoration: BoxDecoration(color:ColorConstant.cardGrey,borderRadius: BorderRadius.circular(40)),),),))
                ],
              ),
              ListTile(
                title: Text(
                  'Property Name',
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .copyWith(fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                    'House Description goes here.Lorem ipsum dolor sit amet consectetur. Posuere vulputate gravida diam id feugiat. Suscipit et nunc tortor vivamus mattis sed est.'),
              ),
              Row(
                spacing: 10,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(
                    Icons.location_on_outlined,
                    color: ColorConstant.primaryColor,
                  ),
                  Text(
                    'Addis Ababa, Ethiopia',
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: ColorConstant.inActiveColor,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              Divider(
                color: ColorConstant.inActiveColor.withValues(alpha: 0.2),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    spacing: 7,
                    children: [
                      Icon(
                        Icons.house_outlined,
                        color: ColorConstant.primaryColor,
                      ),
                      Text(
                        '10',
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(color: ColorConstant.primaryColor),
                      ),
                    ],
                  ),
                  RichText(
                      text: TextSpan(
                    text: 'Price: ',
                    children: [
                      TextSpan(
                        text: 'ETB 1000',
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: ColorConstant.primaryColor,
                            fontWeight: FontWeight.bold),
                      ),
                      TextSpan(
                        text: '/night',
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(color: ColorConstant.inActiveColor),
                      ),
                    ],
                  )),
                ],
              ),
            ],
        ),
      ),
    );
  }
}
