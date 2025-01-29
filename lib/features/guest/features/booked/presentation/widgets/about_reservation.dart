import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:minapp/core/utils/date_converter.dart';

class AboutReservationsCard extends StatelessWidget {
  const AboutReservationsCard({
    super.key, required this.id, required this.price, required this.unit, required this.checkIn, required this.checkOut, required this.decisionTime, required this.decision,
  });
  final String id;
  final String price;
  final String unit;
  final String checkIn;
  final String checkOut;
  final DateTime decisionTime;
  final String? decision;
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: Colors.white,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: BorderSide(color: Colors.white)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 10,
          children: [
            resText(context,"${tr('Reservation ID')}:$id"),
            resText(context, '${tr('Requested Reservation Price')}: $price'),
            resText(context, '${tr('Unit of Price')}: $unit'),
            resText(context, '${tr('Reservation Check in')}:  ${DateConverter().formatDateRange(checkIn)}'),
            resText(context, '${tr('Reservation Check out')}: ${DateConverter().formatDateRange(checkOut)}'),
            resText(context, '${tr('Reservation Decision time')}: ${DateConverter().formatWithTime(decisionTime.toString())}'),
            resText(context, "${tr('Reservation Decision')}: $decision"),
          ],
        ),
      ),
    );
  }

  Text resText(BuildContext context,String title) {
    return Text(title,style: Theme.of(context).textTheme.bodyMedium!.copyWith(
            fontSize: 13,
            fontWeight: FontWeight.w400
          ),);
  }
}
