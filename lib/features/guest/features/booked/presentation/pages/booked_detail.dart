import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:minapp/core/common/back_button.dart';
import 'package:minapp/core/common/custom_button.dart';
import 'package:minapp/core/common/loading_indicator_widget.dart';
import 'package:minapp/core/utils/show_snack_bar.dart';
import 'package:minapp/features/guest/features/booked/presentation/bloc/booked_bloc.dart';
import 'package:minapp/features/guest/features/booked/presentation/bloc/booked_detail/booked_detail_bloc.dart';
import '../../../../../../config/color/color.dart';
import '../../../../../../core/common/spin_kit_loading.dart';
import '../../../../../../service_locator.dart';
import '../../../HousType/presentation/pages/house_detail.dart';
import '../../../HousType/presentation/widgets/section_header_text.dart';
import '../widgets/about_host.dart';
import '../widgets/about_reservation.dart';
import '../widgets/available_facilities.dart';
import '../widgets/location_map.dart';

class BookedDetail extends StatefulWidget {
  const BookedDetail({super.key, required this.token,required this.id});
  
  final String token;
  final int id;

  @override
  State<BookedDetail> createState() => _BookedDetailState();
}

class _BookedDetailState extends State<BookedDetail> {
  int photoIndex=0;
  @override
  void initState() {
    super.initState();
    context.read<BookedDetailBloc>().add(GetBookedDetail(id:widget.id));
  }


  Future<dynamic> showFullScreen(BuildContext context, String itemIndex) {
    return showDialog(context: context, builder:(context) {
      return GestureDetector(
        onTap: () => context.pop(),
        child: Container(
          padding: EdgeInsets.all(15),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: InteractiveViewer(
              panEnabled: true, // Enable panning
              boundaryMargin: EdgeInsets.all(20), // Allow panning outside bounds
              minScale: 3.0,
              maxScale: 8.0, // Enable zooming
              child:ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: CachedNetworkImage(
                  imageUrl:itemIndex,
                  placeholder: (context, url) => RepaintBoundary(child: CupertinoActivityIndicator()),
                  errorWidget: (context, url, error) =>
                      Icon(Icons.error),
                  fit: BoxFit.cover,
                  width: MediaQuery.of(context).size.width,
                ),
              ),
            ),
          ),
        ),
      );
    },);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: AppBarBackButton(),
      ),
      body: BlocProvider.value(
        value: sl<BookedBloc>(),
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 10,vertical: 2),
          child:
          Column(
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
              BlocBuilder<BookedDetailBloc, BookedDetailState>(
                builder: (context, state) {
                  if(state is BookedDetailLoading){
                    return SizedBox(
                      height: MediaQuery.of(context).size.height/2,
              child: Center(child:loadingIndicator()));
                  }
                  else if(state is BookedDetailLoaded){
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: 10,
                      children: [
              SizedBox(
                height: MediaQuery.of(context).size.width * 0.8,
                width: MediaQuery.of(context).size.width,
                child: Stack(
                  children: [
                    CarouselSlider.builder(
                      options:CarouselOptions(
                        height: MediaQuery.of(context).size.height * 0.8,
                        aspectRatio: 16/9,
                        viewportFraction:0.96,
                        initialPage: 0,
                        enableInfiniteScroll: true,
                        reverse: false,
                        autoPlay: false,
                        autoPlayInterval: Duration(seconds: 3),
                        autoPlayAnimationDuration: Duration(milliseconds: 800),
                        autoPlayCurve: Curves.fastOutSlowIn,
                        enlargeCenterPage: true,
                        enlargeFactor: 0.3,
                        onPageChanged:(index, reason) {
                          setState(() {
                            photoIndex=index;
                          });
                        },
                        scrollDirection: Axis.horizontal,
                      ),
                      itemCount:  state.booked.house!.houseImage!.length,
                      itemBuilder: (BuildContext context, int itemIndex, int pageViewIndex) =>
                          GestureDetector(
                            onTap: () {
                              showFullScreen(context,   state.booked.house!.houseImage![itemIndex].image!);
                            },
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: CachedNetworkImage(
                                imageUrl:
                                state.booked.house!.houseImage![itemIndex].image!,
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
                                  height: 18,
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 5),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    color:
                                    Colors.black.withValues(alpha: 0.4),
                                  ),
                                  child: Row(
                                    children: List.generate(
                                        state.booked.house!.houseImage!.length,
                                            (index) => AnimatedContainer(
                                          duration:Duration(milliseconds: 800),
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
                    
                  ],
                ),
              ),
              ListTile(
                  title: SecctionHeader(
                      title: state.booked.house!.title!, isSeeMore: false),
                  subtitle: SeeMoreText(
                    text: state.booked.house!.description!,
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
                    Expanded(
                      child: Text("${state.booked.house!.city!}, ${state.booked.house!.specificAddress!}",
                        textAlign: TextAlign.start,
                        maxLines: 2,
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            fontWeight: FontWeight.bold,
                            color: ColorConstant.secondBtnColor),
                      ),
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
                postedByDetailEntity: state.booked.house!.postedBy!,
                token: widget.token,
                image: state.booked.house!.postedBy!.profilePicture??"",
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
                id: state.booked.id.toString(),
                checkIn: state.booked.checkIn.toString(),
                checkOut: state.booked.checkOut.toString(),
                decision: state.booked.status ?? "",
                decisionTime: state.booked.decisionTime!,
                price: state.booked.house!.price.toString(),
                unit: state.booked.house!.unit!,
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
                loc: state.booked.house!.specificAddress!,
                latitude: state.booked.house!.latitude!,
                longtiude: state.booked.house!.longitude!,
              ),
              Divider(
                thickness: 0.7,
                color: ColorConstant.cardGrey,
              ),
              AvailableFacilities(
                subDesc: state.booked.house!.subDescription!,
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
                    );
                  }
                  return SizedBox.shrink();
                },
              ),
            ],
          )

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
                 BlocBuilder<BookedBloc, BookedState>(
                    builder: (context, state) {
                      return Container(
                        width: MediaQuery.of(context).size.width,
                        margin: EdgeInsets.symmetric(horizontal: 20),
                        child: CustomButton(
                            onPressed: () {
                              context.pop();
                              context.read<BookedBloc>()
                                  .add(GetMyBookingEvent());
                              context.goNamed('booked');
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
        height: MediaQuery.of(context).size.height * 0.30,
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
                                      CancelBookingEvent(id:widget.id));
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
