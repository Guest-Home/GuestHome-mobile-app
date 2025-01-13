import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:minapp/core/common/back_button.dart';
import 'package:minapp/core/common/custom_button.dart';
import 'package:minapp/core/utils/show_snack_bar.dart';
import 'package:minapp/features/guest/features/booked/domain/entities/my_booking_entity.dart';
import 'package:minapp/features/guest/features/booked/presentation/bloc/booked_bloc.dart';
import '../../../../../../config/color/color.dart';
import '../../../../../../core/common/spin_kit_loading.dart';
import '../../../../../../service_locator.dart';
import '../../../HousType/presentation/pages/house_detail.dart';
import '../../../HousType/presentation/widgets/section_header_text.dart';
import '../widgets/about_host.dart';
import '../widgets/about_reservation.dart';
import '../widgets/available_facilities.dart';
import '../widgets/location_map.dart';

class BookedDetail extends StatelessWidget {
  const BookedDetail({super.key, required this.property});

  final ResultBookingEntity property;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: AppBarBackButton(),
      ),
      body: BlocProvider.value(
        value: sl<BookedBloc>(),
        child: SingleChildScrollView(
          padding: EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 10,
            children: [
              ListTile(
                title: SecctionHeader(title: "Approved Book", isSeeMore: false),
                subtitle: Text(
                  "Detail of your reservation",
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(fontSize: 14, fontWeight: FontWeight.w400),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.width * 0.8,
                width: MediaQuery.of(context).size.width,
                child: Stack(
                  children: [
                    CarouselView(
                        elevation: 0,
                        reverse: false,
                        backgroundColor: ColorConstant.cardGrey,
                        itemExtent: MediaQuery.of(context).size.width,
                        children: List.generate(
                          property.house!.houseImage!.length,
                          (index) => ClipRRect(
                            child: CachedNetworkImage(
                              imageUrl:
                                  property.house!.houseImage![index].image!,
                              placeholder: (context, url) => Icon(
                                Icons.photo,
                                color: ColorConstant.inActiveColor,
                              ),
                              errorWidget: (context, url, error) =>
                                  Icon(Icons.error),
                              fit: BoxFit.cover,
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height * 0.8,
                            ),
                          ),
                        )),
                    Positioned(
                        bottom: 8,
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
                                    borderRadius: BorderRadius.circular(100),
                                    color: Colors.black.withValues(alpha: 0.4),
                                  ),
                                  child: Row(
                                    children: List.generate(
                                        property.house!.houseImage!.length,
                                        (index) => Container(
                                              width: 7,
                                              height: 7,
                                              margin: EdgeInsets.only(right: 5),
                                              decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: Colors.white),
                                            )),
                                  ))
                            ]))
                  ],
                ),
              ),
              ListTile(
                  title: SecctionHeader(
                      title: property.house!.title!, isSeeMore: false),
                  subtitle: SeeMoreText(
                    text: property.house!.subDescription!,
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
                      property.house!.specificAddress!,
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          fontWeight: FontWeight.bold,
                          color: ColorConstant.secondBtnColor),
                    )
                  ],
                ),
              ),
              Divider(
                color: ColorConstant.cardGrey.withValues(alpha: 0.9),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 11),
                child:
                    SecctionHeader(title: tr("About Host"), isSeeMore: false),
              ),
              AboutHostCard(
                userEntity: property.user!,
              ),
              Divider(
                thickness: 0.6,
                color: ColorConstant.cardGrey.withValues(alpha: 0.9),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 11),
                child: SecctionHeader(
                    title: tr("About Reservations"), isSeeMore: false),
              ),
              AboutReservationsCard(
                id: property.id.toString(),
                checkIn: property.checkIn.toString(),
                checkOut: property.checkOut.toString(),
                decision: property.status ?? "",
                decisionTime: property.decisionTime ?? "",
                price: property.house!.price.toString(),
                unit: property.house!.unit!,
              ),
              Divider(
                thickness: 0.6,
                color: ColorConstant.cardGrey,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 11),
                child: SecctionHeader(title: tr("Location"), isSeeMore: false),
              ),
              LocationMap(
                loc: property.house!.specificAddress!,
              ),
              Divider(
                thickness: 0.7,
                color: ColorConstant.cardGrey,
              ),
              AvailableFacilities(
                subDesc: property.house!.subDescription!,
              ),
              ListTile(
                title: SecctionHeader(
                    title: tr("Booking Cancellation"), isSeeMore: false),
                subtitle: Column(
                  spacing: 10,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      tr("Any cancellation policy details (e.g., “No refund for cancellations made less than 24 hours before check-in”)"),
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(fontSize: 12, fontWeight: FontWeight.w400),
                    ),
                    SizedBox(
                      height: 3,
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
                        child: Text(
                          tr("Cancel the booking"),
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(fontWeight: FontWeight.bold),
                        ))
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<dynamic> showBookCancelDialog(BuildContext context) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
          backgroundColor: Colors.white,
          title: Text(
            tr("Your Booking Has Been Canceled"),
            textAlign: TextAlign.center,
            style: Theme.of(context)
                .textTheme
                .headlineSmall!
                .copyWith(fontWeight: FontWeight.w700, fontSize: 23),
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
                BlocProvider.value(
                  value: sl<BookedBloc>(),
                  child: BlocBuilder<BookedBloc, BookedState>(
                    builder: (context, state) {
                      return Container(
                        width: MediaQuery.of(context).size.width,
                        margin: EdgeInsets.symmetric(horizontal: 20),
                        child: CustomButton(
                            onPressed: () {
                              context.pop();
                              context
                                  .read<BookedBloc>()
                                  .add(GetMyBookingEvent());
                              context.goNamed('houseType');
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor: ColorConstant.primaryColor,
                                padding: EdgeInsets.all(15)),
                            child: Text(
                              tr("Back to home"),
                              style: TextStyle(color: Colors.white),
                            )),
                      );
                    },
                  ),
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
      isDismissible: false,
      useSafeArea: true,
      isScrollControlled: true,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.28,
        color: Colors.white,
        child: ListTile(
            title: Text(
              "Booking Cancellation",
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .copyWith(fontWeight: FontWeight.w700, fontSize: 18),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${tr('Are you sure you want to cancel your booking')}?",
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(fontSize: 12, fontWeight: FontWeight.w400),
                ),
                Text(
                  tr('This action cannot be undone'),
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(fontSize: 12, fontWeight: FontWeight.w400),
                ),
                SizedBox(
                  height: 50,
                ),
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
                            child: Text(
                              tr("NO"),
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(
                                      color: ColorConstant.secondBtnColor),
                            ))),
                    Expanded(
                        child: BlocProvider.value(
                      value: sl<BookedBloc>(),
                      child: BlocListener<BookedBloc, BookedState>(
                        listener: (context, state) {
                          if (state is CancelBookingSuccessState) {
                            context.pop();
                            showBookCancelDialog(context);
                          } else if (state is CancelBookingErrorState) {
                            context.pop();
                            showErrorSnackBar(context, state.failure.message);
                          }
                        },
                        child: BlocBuilder<BookedBloc, BookedState>(
                          builder: (context, state) {
                            return CustomButton(
                                onPressed: () {
                                  context.read<BookedBloc>().add(
                                      CancelBookingEvent(id: property.id!));
                                },
                                style: ElevatedButton.styleFrom(
                                    elevation: 0,
                                    backgroundColor:
                                        ColorConstant.secondBtnColor,
                                    shape: RoundedRectangleBorder(
                                      side: BorderSide(
                                          color: ColorConstant.secondBtnColor),
                                      borderRadius: BorderRadius.circular(8),
                                    )),
                                child: state is CancelBookingLoadingState
                                    ? loading
                                    : Text(
                                        tr('YES'),
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium!
                                            .copyWith(color: Colors.white),
                                      ));
                          },
                        ),
                      ),
                    )),
                  ],
                ),
              ],
            )),
      ),
    );
  }
}
