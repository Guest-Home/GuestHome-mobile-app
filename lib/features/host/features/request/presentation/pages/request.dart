import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:minapp/config/color/color.dart';
import 'package:minapp/core/common/loading_indicator_widget.dart';
import 'package:minapp/features/host/features/request/presentation/bloc/request_bloc.dart';
import '../../../../../../core/common/custom_button.dart';
import '../../../../../../core/common/custom_text_field.dart';
import '../../../../../../core/common/enum/reservation_status_enum.dart';
import '../../../../../../core/common/spin_kit_loading.dart';
import '../../../../../../core/utils/date_converter.dart';
import '../../../../../../core/utils/show_snack_bar.dart';
import '../../../properties/presentation/widgets/search_filed.dart';
import '../widgets/request_card.dart';

class Request extends StatefulWidget {
  const Request({super.key});

  @override
  State<Request> createState() => _RequestState();
}

class _RequestState extends State<Request> {
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
    return SafeArea(
      child: Scaffold(
         appBar: AppBar(
          title: Text(
            tr('Request'),
            style: Theme.of(context)
                .textTheme
                .bodyLarge!
                .copyWith(fontWeight: FontWeight.bold),
          ),
          elevation: 0,
          shadowColor: Colors.transparent,
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
        ),
          body: RefreshIndicator(
        backgroundColor: ColorConstant.primaryColor,
        color: Colors.white,
        onRefresh: () async {
          context.read<RequestBloc>().add(GetReservationEvent());
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 15),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              spacing: 10,
              children: [
                GestureDetector(
                  onTap: () {
                    context.goNamed("hostSearch");
                  },
                  child:
                    SearchField(
                      isActive: false,
                      prifixIcon: Icon(Icons.search),
                      onTextChnage: (value) {},
                    ),
                ),
                BlocConsumer<RequestBloc, RequestState>(
                  listener: (context, state) {
                    if(state is NoInternetRequest){
                      showNoInternetSnackBar(context, () {
                        context.read<RequestBloc>().add(GetReservationEvent());
                      },);
                    }
                  },
                  builder: (context, state) {
                    if (state is ReservationLoadingState || state is NoInternetRequest) {
                      return Center(
                        child:loadingIndicator()
                      );
                    }
                    else if (state.reservation.results==null || state.reservation.results!.isEmpty) {
                        return  Expanded(
                          child: ListView(
                            children:[
                              SizedBox(
                                height: MediaQuery.of(context).size.height/2,
                                child: Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    spacing: 15,
                                    children: [
                                      Image.asset("assets/icons/Inboxe.png",
                                        width: 80,
                                        height: 80,
                                      ),
                                      Text(
                                       tr("No reservation found"),
                                        textAlign: TextAlign.center,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium!.copyWith(
                                            fontWeight: FontWeight.w400,
                                            fontSize: 16
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                            ),]
                          ),
                        );
                      }
                    else if(state.reservation.results!=null || state.reservation.results!.isNotEmpty){
                      return Expanded(
                        child: NotificationListener<ScrollNotification>(
                          onNotification: (scrollInfo) {
                            if (scrollInfo.metrics.pixels ==
                                scrollInfo.metrics.maxScrollExtent) {
                              context.read<RequestBloc>().add(LoadMoreReservationEvent());
                            }
                            return false;
                          },
                          child: ListView.builder(
                            itemCount: state.reservation.results!.length+
                                (state is ReservationLoadingMoreState
                                    ? 1 : 0),
                            itemBuilder: (context, index){
                              if (index >=
                                  state.reservation.results!.length) {
                                return Center(child: loadingWithPrimary);
                              }
                              return  GestureDetector(
                                onTap: () {
                                  if(getStatus(state.reservation.results![index].status!)==BookingStatus.pending){
                                    reservationBottomSheet(context, state, index);
                                  }

                                },
                                child: RequestCard(
                                    isEditing: false,
                                    reservationEntity:
                                    state.reservation.results![index],
                                  )
                              );
                            }
                            ),
                        ),
                      );
                    }
                    return SizedBox.shrink();
                  },
                )
              ],
            ),
        ),
      )),
    );
  }

  Text valueText(BuildContext context, String value) {
    return Text(value,
        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
            fontWeight: FontWeight.w600,
            fontSize: 12
        ));
  }
  Text titleText(BuildContext context, String title) => Text(
    title,
    textAlign: TextAlign.start,
    maxLines: 3,
    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
      color: ColorConstant.secondBtnColor.withValues(alpha: 0.6),
      fontSize: 12,
      fontWeight: FontWeight.w400,
    ),
  );

  Future reservationBottomSheet(
      BuildContext context, RequestState state, int index) {
    final TextEditingController roomNumberController=TextEditingController();
    final formKey=GlobalKey<FormState>();

    return showModalBottomSheet(context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (context) => Container(
      height: MediaQuery.of(context).size.height,
      margin: EdgeInsets.only(top: 50),
      padding: EdgeInsets.symmetric(horizontal: 15),
      child:  SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
          BlocConsumer<RequestBloc,RequestState>(
        listener: (context, state) {
          if (state is AcceptedReservationState) {
            context.pop();
            context.read<RequestBloc>().add(GetReservationEvent());
            showSuccessSnackBar(context, "reservation accepted");
          } else if (state is RejectedReservationState) {
            context.read<RequestBloc>().add(GetReservationEvent());
            context.pop();
            showSuccessSnackBar(context, "reservation Rejected");
          } else if(state is AcceptingReservationState){
            context.pop();
            lodingDialog(context);
          }
          else if (state is ReservationErrorState) {
            context.pop();
            showErrorSnackBar(context, state.failure.message);
          }
        },
        builder: (context, state) =>  Card(
          margin: EdgeInsets.symmetric(vertical: 5),
          color: ColorConstant.cardGrey.withValues(alpha: 0.5),
          elevation: 0,
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 10,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    spacing: 10,
                    children: [
                      CircleAvatar(
                        radius: 30,
                        backgroundColor:
                        ColorConstant.primaryColor.withValues(alpha: 0.1),
                        child: Text(
                          state.reservation.results![index].user!.userAccount!.firstName!
                              .substring(0, 1)
                              .toUpperCase() ,
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(
                              color: ColorConstant.primaryColor,
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                      Expanded(child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${ state.reservation.results![index].user!.userAccount!.firstName!} ${ state.reservation.results![index].user!.userAccount!.lastName??""}",
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                fontSize: 14,
                                fontWeight: FontWeight.w700),
                          ),
                          Text( state.reservation.results![index].user!.phoneNumber??"",
                            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                                color: ColorConstant.secondBtnColor
                                    .withValues(alpha: 0.7)),
                          )

                        ],))

                    ],),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 5,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          titleText(context, tr('Reservation id')),
                          valueText(context, state.reservation.results![index].id.toString()),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Row(
                            spacing: 3,
                            children: [
                              Icon(Icons.arrow_circle_down,
                                  color: ColorConstant.primaryColor),
                              titleText(context, tr('Check in')),
                            ],
                          ),
                          valueText(
                              context,
                              DateConverter().formatDate(
                                  state.reservation.results![index].checkIn.toString())),
                          valueText(
                              context,
                              DateConverter().formatDateMonth(
                                  state.reservation.results![index].checkIn.toString())),
                          valueText(
                              context,
                              DateConverter().formatDateTime(
                                  state.reservation.results![index].checkIn.toString())),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Row(
                            spacing: 3,
                            children: [
                              Icon(Icons.arrow_circle_up,
                                  color: ColorConstant.primaryColor),
                              titleText(context, tr('Check out')),
                            ],
                          ),
                          valueText(
                              context,
                              DateConverter().formatDate(
                                  state.reservation.results![index].checkOut.toString())),
                          valueText(
                              context,
                              DateConverter().formatDateMonth(
                                  state.reservation.results![index].checkOut.toString())),
                          valueText(
                              context,
                              DateConverter().formatDateTime(
                                  state.reservation.results![index].checkOut.toString())),
                        ],
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          titleText(context, tr('Property type')),
                          valueText(
                              context, state.reservation.results![index].house!.typeofHouse!)
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          titleText(context, tr('Property id')),
                          valueText(
                              context,state.reservation.results![index].house!.id.toString())
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          titleText(context, tr('Unit type')),
                          valueText(context,
                              "${state.reservation.results![index].house!.price.toString()}${tr(state.reservation.results![index].house!.unit!)}")
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  if(state.reservation.results![index].assignedRoom!=null)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      spacing: 10,
                      children: [
                        Text("${tr("Assigned room number")}:", style:
                        Theme.of(context).textTheme.bodyLarge!.copyWith(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                        )),
                        Text(state.reservation.results![index].assignedRoom!,style:
                        Theme.of(context).textTheme.bodyLarge!.copyWith(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: ColorConstant.primaryColor
                        )),
                      ],
                    ),
                 SizedBox(
                        child: Row(
                          spacing: 20,
                          children: [
                            Expanded(child: BlocBuilder<RequestBloc, RequestState>(
                              builder: (context, state) {
                                return CustomButton(
                                  onPressed: () {
                                    showDialog(context: context,
                                        barrierDismissible: false,
                                        builder: (context) =>AlertDialog(
                                          title: Text(tr("Room number"),style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600
                                          ),),
                                          content: SizedBox(
                                            height: MediaQuery.of(context).size.height*0.2,
                                            child: Form(
                                              key: formKey,
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text(tr("Please enter the room number"),style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                                                      fontSize: 13,
                                                      fontWeight: FontWeight.w400
                                                  ),),
                                                  SizedBox(height: 17,),
                                                  RichText(text: TextSpan(children: [
                                                    TextSpan(text: tr("Room Number"),style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                                                        fontSize: 13,
                                                        fontWeight: FontWeight.w500
                                                    )),
                                                    TextSpan(text: "*",style: TextStyle(color: ColorConstant.red)),
                                                  ])),
                                                  SizedBox(height: 3,),
                                                  CustomTextField(hintText: "room number",
                                                      textEditingController: roomNumberController,
                                                      surfixIcon: null,
                                                      onTextChnage:(value){},
                                                      validator: (value) {
                                                        if(value!.isEmpty){
                                                          return "please add room number";
                                                        }

                                                        return null;
                                                      },
                                                      isMultiLine: false,
                                                      textInputType: TextInputType.text),

                                                ],
                                              ),
                                            ),
                                          ),
                                          actions: [
                                            Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                spacing: 10,
                                                children: [
                                                  Expanded(
                                                    child: CustomButton(
                                                      onPressed:
                                                          () {
                                                        formKey.currentState!.save();
                                                        if(formKey.currentState!.validate()){
                                                          context.read<RequestBloc>().add(
                                                              AcceptReservationEvent(id: state.reservation.results![index].id!,
                                                                  roomNumber: roomNumberController.text));
                                                        }
                                                      },
                                                      style: ElevatedButton.styleFrom(
                                                        backgroundColor: ColorConstant.primaryColor,
                                                        padding: EdgeInsets.all(13),
                                                        shape: RoundedRectangleBorder(
                                                            borderRadius: BorderRadius.circular(10)),
                                                      ),
                                                      child: Text(
                                                        tr("Submit"),
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .bodyLarge!
                                                            .copyWith(
                                                            color: Colors.white,
                                                            fontSize: 12,
                                                            fontWeight: FontWeight.w700),
                                                      ),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: CustomButton(
                                                      onPressed: () {
                                                        context.pop();
                                                      },
                                                      style: ElevatedButton.styleFrom(
                                                        backgroundColor: ColorConstant.red,
                                                        padding: EdgeInsets.all(13),
                                                        shape: RoundedRectangleBorder(
                                                            borderRadius: BorderRadius.circular(10)),
                                                      ),
                                                      child:Text(
                                                        tr("Cancel"),
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .bodyLarge!
                                                            .copyWith(
                                                            color: Colors.white,
                                                            fontSize: 12,
                                                            fontWeight: FontWeight.w700),
                                                      ),
                                                    ),
                                                  )
                                                ],

                                            )
                                          ],
                                        ));
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: ColorConstant.green,
                                    padding: EdgeInsets.all(13),
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(15)),
                                  ),
                                  child:  Text(
                                    tr("Accept"),
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyLarge!
                                        .copyWith(
                                        color: Colors.white,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w700),
                                  ),
                                );
                              },
                            )),
                            Expanded(child: BlocBuilder<RequestBloc, RequestState>(
                              builder: (context, state) {
                                return
                                  CustomButton(
                                    onPressed: () {
                                      context.read<RequestBloc>().add(
                                          RejectReservationEvent(
                                              id:state.reservation.results![index].id!));
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: ColorConstant.red,
                                      padding: EdgeInsets.all(13),
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(15)),
                                    ),
                                    child: state is RejectingReservationState
                                        ? loading
                                        : Text(
                                      tr("Reject"),
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyLarge!
                                          .copyWith(
                                          color: Colors.white,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w700),
                                    ),
                                  );
                              },
                            )),
                          ],
                        )),
                ]),
          ),
        )

        )
          ],
        ),
      ),

    ),);
  }
}
