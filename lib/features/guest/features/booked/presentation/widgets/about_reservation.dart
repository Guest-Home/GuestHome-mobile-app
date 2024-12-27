import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class AboutReservationsCard extends StatelessWidget {
  const AboutReservationsCard({
    super.key,
  });

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
            Text(tr('Reservation ID')),
            Text(tr('Requested Reservation Price')),
            Text(tr('Unit of Price')),
            Text(tr('Reservation Check in')),
            Text(tr('Reservation Check out')),
            Text(tr('Reservation Decision time')),
            Text(tr('Reservation Decision')),
          ],
        ),
      ),
    );
  }
}
