import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../../config/color/color.dart';

class HouseTypeCard extends StatelessWidget {
  const HouseTypeCard({
    super.key,
    required this.iconData,
    required this.title,
    required this.isSelected,
  });

  final String iconData;
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
          ? ColorConstant.primaryColor.withValues(alpha: 0.0)
          : ColorConstant.cardGrey.withValues(alpha: 0.8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: SizedBox(
          child: Row(
            spacing: 5,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                iconData,
                semanticsLabel: title,
                fit: BoxFit.cover,
                width: 22,
                height: 22,
              ),

              Expanded(
                child: Text(title,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                          color: ColorConstant.secondBtnColor.withValues(),
                        )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
