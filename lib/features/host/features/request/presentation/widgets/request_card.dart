import 'package:flutter/material.dart';
import 'package:minapp/core/common/custom_button.dart';

import '../../../../../../config/color/color.dart';
import 'request_status_widget.dart';

class RequestCard extends StatelessWidget {
  const RequestCard({
    super.key,
    required this.userName,
    required this.phoneNumber,
    required this.reservationId,
    required this.checkIn,
    required this.checkOut,
    required this.propertyType,
    required this.propertyId,
    required this.unitType,
    required this.bookingStatus,
    this.updateStatus,
  });

  final bool? updateStatus;

  final String userName;
  final String phoneNumber;
  final String reservationId;
  final String checkIn;
  final String checkOut;
  final String propertyType;
  final String propertyId;
  final String unitType;
  final String bookingStatus;

  @override
  Widget build(BuildContext context) {
    return Card(
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        color: ColorConstant.cardGrey.withValues(alpha: 0.5),
        elevation: 0,
        child: Padding(
          padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 10,
              children: [
                ListTile(
                    leading: CircleAvatar(
                      radius: 30,
                      child: Text(userName.substring(0, 2).toUpperCase()),
                    ),
                    title: Text(
                      userName,
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(phoneNumber)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Reservation Id'),
                        Text(reservationId,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                  fontWeight: FontWeight.bold,
                                )),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          spacing: 3,
                          children: [
                            Icon(Icons.arrow_circle_down,
                                color: ColorConstant.primaryColor),
                            Text('Check In'),
                          ],
                        ),
                        Text(checkIn,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                  fontWeight: FontWeight.bold,
                                )),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          spacing: 3,
                          children: [
                            Icon(Icons.arrow_circle_up,
                                color: ColorConstant.primaryColor),
                            Text('Check Out'),
                          ],
                        ),
                        Text(checkOut,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                  fontWeight: FontWeight.bold,
                                )),
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
                        Text('Property Type'),
                        Text(propertyType,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                  fontWeight: FontWeight.bold,
                                )),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Property Id'),
                        Text(propertyId,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                  fontWeight: FontWeight.bold,
                                )),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Unit Type'),
                        Text('$unitType Birr',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                  fontWeight: FontWeight.bold,
                                )),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                    child: updateStatus!
                        ? Row(
                            spacing: 20,
                            children: [
                              Expanded(
                                  child: CustomButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: ColorConstant.green,
                                  padding: EdgeInsets.all(10),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                ),
                                child: Text(
                                  "Approve",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .copyWith(color: Colors.white),
                                ),
                              )),
                              Expanded(
                                  child: CustomButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: ColorConstant.red,
                                  padding: EdgeInsets.all(10),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                ),
                                child: Text(
                                  "Reject",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .copyWith(color: Colors.white),
                                ),
                              )),
                            ],
                          )
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            spacing: 15,
                            children: [
                              Text('Booking Status-',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .copyWith(
                                        fontWeight: FontWeight.bold,
                                      )),
                              StatusCard(
                                status: bookingStatus,
                              ),
                            ],
                          ))
              ]),
        ));
  }
}
