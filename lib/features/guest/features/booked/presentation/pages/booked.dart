import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:minapp/config/color/color.dart';
import 'package:minapp/core/common/custom_button.dart';
import 'package:minapp/core/common/loading_indicator_widget.dart';
import 'package:minapp/core/utils/show_snack_bar.dart';
import 'package:minapp/features/guest/features/HousType/presentation/widgets/section_header_text.dart';
import 'package:minapp/features/guest/features/booked/presentation/bloc/booked_bloc.dart';
import 'package:minapp/features/guest/features/booked/presentation/widgets/booked_card.dart';

import '../../../../../../core/common/enum/reservation_status_enum.dart';
import '../../../../../../core/common/spin_kit_loading.dart';

class Booked extends StatelessWidget {
  const Booked({super.key});

  BookingStatus getStatus(String status) {
    switch (status) {
      case 'Waiting for Approval':
        return BookingStatus.pending;
      case 'Approved':
        return BookingStatus.approved;
      case 'Rejected':
        return BookingStatus.rejected;
      default:
        return BookingStatus.pending;
    }
  }
  @override
  Widget build(BuildContext context) {
    return
      SafeArea(
        child: Scaffold(
        body: RefreshIndicator(
            backgroundColor: ColorConstant.primaryColor,
            color: Colors.white,
            onRefresh: () async {
              context.read<BookedBloc>().add(GetMyBookingEvent());
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 10,
                children: [
                  Padding(
                      padding: EdgeInsets.all(1),
                      child: ListTile(
                        title:
                            SecctionHeader(title: tr("Booked"), isSeeMore: false),
                        subtitle: Text(tr(
                          "Here is the list of your requested booking"),
                          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            fontSize: 14,fontWeight: FontWeight.w400
                          ),
                        ),
                      )),
                  Expanded(
                    child: BlocConsumer<BookedBloc, BookedState>(
                        listener:(context, state) {
                          if(state is NoInternetSate){
                            noInternetDialog(context);
                          }
                        },
                      builder: (context, state) {
                        if (state is MyBookingLoadingState) {
                          return Center(
                            child: loadingIndicator(),
                          );
                        }
                        else if (state.booking.results==null) {
                          return Center(
                            child: loadingIndicator(),
                          );
                        }
                         else if (state.booking.count==0) {
                            return ListView(children:[ EmptyBooked()]);
                          }
                         else if(state.booking.results!.isNotEmpty){
                          return NotificationListener<ScrollNotification>(
                              onNotification: (scrollInfo) {
                                if (scrollInfo.metrics.pixels ==
                                    scrollInfo.metrics.maxScrollExtent) {
                                  context.read<BookedBloc>().add(LoadMoreBookedEvent());
                                }
                                return false;
                              },
                              child: ListView.builder(
                              padding: EdgeInsets.all(10),
                              itemCount: state.booking.results!.length+
                                  (state is MyBookingLoadingMoreState
                                      ? 1
                                      : 0),
                              itemBuilder: (context, index){
                                if (index >= state.booking.results!.length) {
                                  return Center(
                                      child: loadingWithPrimary);
                                }
                                return   BookedCard(
                                    width: MediaQuery.of(context).size.width,
                                    height: 400,
                                    property: state.booking.results![index],

                                );
                              }
                              ),
                            );
                        }
                         else if(state is MyBookingErrorState){
                          return SizedBox(
                              height: MediaQuery.of(context).size.height/2,
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

                          );
                        }
                        return SizedBox.shrink();
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),

            ),
      );
  }
}

class EmptyBooked extends StatelessWidget {
  const EmptyBooked({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child:
      SingleChildScrollView(
        child:
          Column(
            spacing: 15,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                "assets/icons/Inboxe.png",
                width: 100,
                height: 100,
              ),
              Text(
                tr("You did’t booked any Properties.search and book properties"),
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .copyWith(fontWeight: FontWeight.w600,fontSize: 14),
              ),
              SizedBox(height: 10,),
              SizedBox(
                width:MediaQuery.of(context).size.width*0.6,
                child: CustomButton(
                    onPressed: () {
                      context.pushNamed("search");
                    },
                    style: ElevatedButton.styleFrom(
                        elevation: 0,
                        backgroundColor: Colors.white,
                        overlayColor: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                            side: BorderSide(color: ColorConstant.secondBtnColor))),
                    child: Text(tr("Search properties"),
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(fontWeight: FontWeight.w700,fontSize: 14),
                    )),
              )
            ],
          ),
        ),

    );
  }
}
