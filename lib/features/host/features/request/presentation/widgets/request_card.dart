import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:minapp/core/common/custom_button.dart';
import 'package:minapp/core/common/enum/reservation_status_enum.dart';
import 'package:minapp/core/utils/date_converter.dart';
import 'package:minapp/core/utils/show_snack_bar.dart';
import 'package:minapp/features/host/features/request/data/models/reservation_model.dart';
import 'package:minapp/features/host/features/request/presentation/bloc/request_bloc.dart';
import '../../../../../../config/color/color.dart';
import '../../../../../../core/common/loading_indicator_widget.dart';

class RequestCard extends StatelessWidget {
   const RequestCard(
      {super.key, required this.reservationEntity, required this.isEditing});
  final Result reservationEntity;
  final bool isEditing;

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
      BlocConsumer<RequestBloc,RequestState>(
        listener: (context, state) {
          if (state is AcceptedReservationState) {
            context.read<RequestBloc>().add(GetReservationEvent());
            context.pop();
            showSuccessSnackBar(context, "reservation accepted");
          } else if (state is RejectedReservationState) {
            context.read<RequestBloc>().add(GetReservationEvent());
            context.pop();
            showSuccessSnackBar(context, "reservation accepted");
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
                        reservationEntity.user!.userAccount!.firstName!
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
                          "${reservationEntity.user!.userAccount!.firstName!} ${reservationEntity.user!.userAccount!.lastName??""}",
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(
                              fontSize: 14,
                              fontWeight: FontWeight.w700),
                        ),
                        Text(reservationEntity.user!.phoneNumber??"",
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
                        titleText(context, tr('Reservation id'),),
                        valueText(context, reservationEntity.id.toString()),
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
                                reservationEntity.checkIn.toString())),
                        valueText(
                            context,
                            DateConverter().formatDateMonth(
                                reservationEntity.checkIn.toString())),
                        valueText(
                            context,
                            DateConverter().formatDateTime(
                                reservationEntity.checkIn.toString())),
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
                            titleText(context, tr('Check Out')),
                          ],
                        ),
                        valueText(
                            context,
                            DateConverter().formatDate(
                                reservationEntity.checkOut.toString())),
                        valueText(
                            context,
                            DateConverter().formatDateMonth(
                                reservationEntity.checkOut.toString())),
                        valueText(
                            context,
                            DateConverter().formatDateTime(
                                reservationEntity.checkOut.toString())),
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
                            context, tr(reservationEntity.house!.typeofHouse!))
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        titleText(context, tr('Property id')),
                        valueText(
                            context, reservationEntity.house!.id.toString())
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        titleText(context, tr('Unit type')),
                        valueText(context,
                            "${reservationEntity.house!.price.toString()}${reservationEntity.house!.unit}")
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                SizedBox(
                      child: Row(
                        spacing: 20,
                        children: [
                          Text(tr('Booking Status'),
                              textAlign: TextAlign.start,
                              overflow: TextOverflow.ellipsis,
                              style:
                              Theme.of(context).textTheme.bodyLarge!.copyWith(
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                              )),
                          Expanded(
                              child: StatusButton(
                                status: getStatus(reservationEntity.status!),
                              )),
                        ],
                      )),
              ]),
        ),
      )

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
}

class StatusButton extends StatelessWidget {
  const StatusButton({super.key, required this.status});

  final BookingStatus status;

  @override
  Widget build(BuildContext context) {
    return CustomButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        backgroundColor: status.backgroundColor,
        padding: EdgeInsets.all(13),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      ),
      child: Text(
        tr(status.name),
        style: Theme.of(context)
            .textTheme
            .bodyLarge!
            .copyWith(color: Colors.white, fontWeight: FontWeight.w700),
      ),
    );
  }
}
