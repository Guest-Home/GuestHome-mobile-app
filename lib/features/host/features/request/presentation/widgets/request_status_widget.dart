import 'package:flutter/material.dart';
import '../../../../../../config/color/color.dart';

class StatusCard extends StatelessWidget {
  const StatusCard({
    super.key,
    required this.status,
  });

  final String status;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 150,
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
            color: status == 'Pending'
                ? ColorConstant.yellow
                : status == 'Reject'
                    ? ColorConstant.red
                    : ColorConstant.green,
            borderRadius: BorderRadius.circular(15)),
        child: Center(
            child: Text(
          status,
          style: Theme.of(context)
              .textTheme
              .bodyLarge!
              .copyWith(color: Colors.white, fontWeight: FontWeight.bold),
        )));
  }
}
