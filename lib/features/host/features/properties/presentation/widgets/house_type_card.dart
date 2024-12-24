import 'package:flutter/material.dart';

import '../../../../../../config/color/color.dart';

class HouseTypeCard extends StatelessWidget {
  const HouseTypeCard({
    super.key,
    required this.iconData,
    required this.title,
    required this.isSelected,
  });

  final IconData iconData;
  final String title;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: BorderSide(
            color: isSelected ? ColorConstant.primaryColor : Colors.transparent,
            width: 1),
      ),
      elevation: 0,
      color: isSelected
          ? ColorConstant.primaryColor.withValues(alpha: 0.1)
          : ColorConstant.cardGrey.withValues(alpha: 0.8),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          spacing: 3,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(iconData,
                color: ColorConstant.primaryColor.withValues(alpha: 0.7)),
            Expanded(
              child: Text(title,
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        fontWeight: FontWeight.bold,
                        color: ColorConstant.secondBtnColor.withValues(),
                      )),
            ),
          ],
        ),
      ),
    );
  }
}
