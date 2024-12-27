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
            Text("Reservation ID: 5"),
            Text("Requested Reservation Price: 500.00"),
            Text("Unit of Price: Birr"),
            Text("Reservation Check in : 2024-09-27"),
          ],
        ),
      ),
    );
  }
}
