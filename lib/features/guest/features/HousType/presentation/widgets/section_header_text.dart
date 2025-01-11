import 'package:flutter/material.dart';

import '../../../../../../config/color/color.dart';

class SecctionHeader extends StatelessWidget {
  const SecctionHeader({
    super.key,
    required this.title,
    required this.isSeeMore,
  });
  final String title;
  final bool isSeeMore;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: Theme.of(context)
              .textTheme
              .bodyLarge!
              .copyWith(fontWeight: FontWeight.w600, fontSize: 16),
        ),
        if (isSeeMore)
          Text(
            "see all",
            style: TextStyle(
                color: ColorConstant.secondBtnColor.withValues(alpha: 0.4)),
          )
      ],
    );
  }
}
