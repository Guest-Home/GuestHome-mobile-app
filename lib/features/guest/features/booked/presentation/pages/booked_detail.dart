import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:minapp/core/common/back_button.dart';
import 'package:minapp/core/common/custom_button.dart';
import '../../../../../../config/color/color.dart';
import '../../../HousType/presentation/pages/house_detail.dart';
import '../../../HousType/presentation/widgets/section_header_text.dart';
import '../widgets/about_host.dart';
import '../widgets/about_reservation.dart';
import '../widgets/available_facilities.dart';
import '../widgets/location_map.dart';

class BookedDetail extends StatelessWidget {
  const BookedDetail({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: AppBarBackButton(),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 10,
          children: [
            ListTile(
              title: SecctionHeader(title: "Approved Book", isSeeMore: false),
              subtitle: Text(
                "Detail of your reservation",
                style: Theme.of(context).textTheme.bodyMedium!,
              ),
            ),
            SizedBox(
                height: 250,
                width: MediaQuery.of(context).size.width,
                child: CarouselView(
                    itemExtent: MediaQuery.of(context).size.width,
                    children: [
                      Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(1),
                            child: Image.network(
                              "https://media.architecturaldigest.com/photos/57e42deafe422b3e29b7e790/master/pass/JW_LosCabos_2015_MainExterior.jpg",
                              fit: BoxFit.fill,
                              width: MediaQuery.of(context).size.width,
                            ),
                          ),
                          Positioned(
                              bottom: 10,
                              left: 0,
                              right: 0,
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                        height: 25,
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 20, vertical: 5),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(100),
                                          color: Colors.black
                                              .withValues(alpha: 0.4),
                                        ),
                                        child: Row(
                                          children: List.generate(
                                              3,
                                              (index) => Container(
                                                    width: 7,
                                                    height: 7,
                                                    margin: EdgeInsets.only(
                                                        right: 5),
                                                    decoration: BoxDecoration(
                                                        shape: BoxShape.circle,
                                                        color: Colors.white),
                                                  )),
                                        ))
                                  ]))
                        ],
                      )
                    ])),
            ListTile(
                title: SecctionHeader(
                    title: 'Stylish Guest House', isSeeMore: false),
                subtitle: SeeMoreText(
                  text:
                      'Lorem ipsum dolor sit amet consectetur. Purus elit susp endisse massa turpis et amet. Dignissim diam vel odio risus .Lorem ipsum dolor sit amet consectetur. Purus elit suspe ndisse massa turpis et amet. Dignissim   Readmore.',
                  maxLines: 4,
                )),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 11),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                spacing: 5,
                children: [
                  Icon(
                    Icons.location_pin,
                    size: 19,
                    color: ColorConstant.secondBtnColor,
                  ),
                  Text(
                    "Addis Ababa,Ethiopia",
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        fontWeight: FontWeight.bold,
                        color: ColorConstant.secondBtnColor),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 11),
              child: SecctionHeader(title:tr("About Host"), isSeeMore: false),
            ),
            AboutHostCard(),
            Divider(
              thickness: 0.6,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 11),
              child:
                  SecctionHeader(title:tr("About Reservations"), isSeeMore: false),
            ),
            AboutReservationsCard(),
            Divider(
              thickness: 0.6,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 11),
              child: SecctionHeader(title:tr("Location"), isSeeMore: false),
            ),
            LocationMap(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 11),
              child: SecctionHeader(
                  title:tr('Facilities'), isSeeMore: false),
            ),
            AvailableFacilities(),
            ListTile(
              title: SecctionHeader(
                  title: tr("Booking Cancellation"), isSeeMore: false),
              subtitle: Column(
                spacing: 10,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(tr(
                    "Any cancellation policy details (e.g., “No refund for cancellations made less than 24 hours before check-in”)"),
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  CustomButton(
                      onPressed: () {
                        showCancelBookBotomSheet(context);
                      },
                      style: ElevatedButton.styleFrom(
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                              side: BorderSide(
                                  color: ColorConstant.secondBtnColor)),
                          backgroundColor: Colors.white),
                      child: Text(tr(
                        "Cancel the booking"),
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(fontWeight: FontWeight.bold),
                      ))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<dynamic> showBookCanceDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
          backgroundColor: Colors.white,
          title: Text(tr(
            "Your Booking Has Been Canceled"),
            textAlign: TextAlign.center,
            style: Theme.of(context)
                .textTheme
                .headlineSmall!
                .copyWith(fontWeight: FontWeight.bold),
          ),
          icon: SvgPicture.asset(
            'assets/icons/congrates.svg',
            semanticsLabel: 'language',
            fit: BoxFit.cover,
          ),
          content: SizedBox(
            height: 150,
            child: Column(
              spacing: 10,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  child: CustomButton(
                      onPressed: () {
                        context.pop();
                        context.goNamed('houseType');
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: ColorConstant.primaryColor,
                          padding: EdgeInsets.all(15)),
                      child: Text(tr(
                        "Back to home"),
                        style: TextStyle(color: Colors.white),
                      )),
                )
              ],
            ),
          )),
    );
  }

  Future<dynamic> showCancelBookBotomSheet(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      showDragHandle: true,
      backgroundColor: Colors.white,
      useSafeArea: true,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height / 4,
        color: Colors.white,
        child: ListTile(
            title:
                SecctionHeader(title:tr("Booking Cancellation"), isSeeMore: false),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(tr(
                    'Are you sure you want to cancel your booking') ),
                Text(tr(
                    'This action cannot be undone') ),
                SizedBox(height: 50,),
                Row(
                  spacing: 10,
                  children: [
                    Expanded(
                        child: CustomButton(
                            onPressed: () {
                              context.pop();
                            },
                            style: ElevatedButton.styleFrom(
                                elevation: 0,
                                backgroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  side: BorderSide(
                                      color: ColorConstant.secondBtnColor),
                                  borderRadius: BorderRadius.circular(8),
                                )),
                            child: Text(tr("NO")
                              ,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(
                                      color: ColorConstant.secondBtnColor),
                            ))),
                    Expanded(
                        child: CustomButton(
                            onPressed: () {
                              showBookCanceDialog(context);
                            },
                            style: ElevatedButton.styleFrom(
                                elevation: 0,
                                backgroundColor: ColorConstant.secondBtnColor,
                                shape: RoundedRectangleBorder(
                                  side: BorderSide(
                                      color: ColorConstant.secondBtnColor),
                                  borderRadius: BorderRadius.circular(8),
                                )),
                            child: Text(tr('YES'),
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(color: Colors.white),
                            ))),
                  ],
                ),
              ],
            )),
      ),
    );
  }
}
