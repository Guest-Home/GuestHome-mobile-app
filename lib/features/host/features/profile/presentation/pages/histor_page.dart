
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minapp/features/host/features/profile/presentation/bloc/booking_history_bloc/booking_history_bloc.dart';
import '../../../../../../config/color/color.dart';
import '../../../../../../core/common/back_button.dart';
import '../../../../../../core/common/custom_button.dart';
import '../../../../../../core/common/loading_indicator_widget.dart';
import '../../../../../../core/common/spin_kit_loading.dart';
import '../../../../../guest/features/booked/presentation/pages/booked.dart';
import '../widgets/BookingHistoryCard.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: AppBarBackButton(),
        title: Text(
          tr('Booking history'),
          style: Theme.of(context)
              .textTheme
              .bodyLarge!
              .copyWith(fontWeight: FontWeight.bold),
        ),
      ),
      body: SafeArea(
          child: Scaffold(
            body: RefreshIndicator(
              backgroundColor: ColorConstant.primaryColor,
              color: Colors.white,
              onRefresh: () async {
                context.read<BookingHistoryBloc>().add(GetBookingHistoryEvent());
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child:
                  BlocConsumer<BookingHistoryBloc, BookingHistoryState>(
                        listener:(context, state) {
                        },
                        builder: (context, state) {
                          if (state is BookingHistoryLoadingState) {
                            return Center(
                              child: loadingIndicator(),
                            );
                          }
                          else if (state.booking.count==0) {
                            return ListView(children:[EmptyBooked()]);
                          }
                          else if(state.booking.results!=null && state.booking.results!.isNotEmpty){
                            return NotificationListener<ScrollNotification>(
                              onNotification: (scrollInfo) {
                                if (scrollInfo.metrics.pixels ==
                                    scrollInfo.metrics.maxScrollExtent) {
                                  context.read<BookingHistoryBloc>().add(LoadMoreBookedEvent());
                                }
                                return false;
                              },
                              child: ListView.builder(
                                  padding: EdgeInsets.all(10),
                                  itemCount: state.booking.results!.length+
                                      (state is BookingHistoryLoadingMoreState
                                          ? 1
                                          : 0),
                                  itemBuilder: (context, index){
                                    if (index >= state.booking.results!.length) {
                                      return Center(
                                          child: loadingWithPrimary);
                                    }
                                    return  BookingHistoryCard(
                                      width: MediaQuery.of(context).size.width,
                                      height: 400,
                                      property: state.booking.results![index],
                                    );
                                  }
                              ),
                            );
                          }
                          else if(state is BookingHistoryError){
                            return SingleChildScrollView(
                              child: SizedBox(
                                height: MediaQuery.of(context).size.height/2,
                                child: Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    spacing: 10,
                                    children: [
                                      Icon(Icons.error_outline,size: 25,color: ColorConstant.red,),
                                      Text(
                                        state.failure.message,
                                        style: Theme.of(context).textTheme.bodySmall,
                                      ),
                                      CustomButton(
                                          onPressed: () {
                                            context.read<BookingHistoryBloc>().add(GetBookingHistoryEvent());
                                          },
                                          style: ElevatedButton.styleFrom(
                                              padding: EdgeInsets.symmetric(horizontal:40,vertical: 10),
                                              backgroundColor: ColorConstant.primaryColor
                                          ), child: Text("Retry",style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                          color: Colors.white
                                      ),))
                                    ],
                                  ),
                                ),

                              ),
                            );
                          }
                          return SizedBox.shrink();
                        },
                      ),

              ),
            ),)
      ),
    );
  }
}
