import 'package:flutter/material.dart';

import '../../config/color/color.dart';

class UploadPhoto extends StatelessWidget {
  const UploadPhoto({
    super.key,
    required this.ontTap,
  });
  final VoidCallback ontTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => ontTap,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: ColorConstant.cardGrey)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.upload,
              color: ColorConstant.primaryColor.withValues(alpha: 0.9),
            ),
            RichText(
                text: TextSpan(children: [
              TextSpan(
                  text: "Click to upload",
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall!
                      .copyWith(color: ColorConstant.primaryColor)),
              TextSpan(
                  text: "or drag and drop",
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(color: ColorConstant.secondBtnColor))
            ])),
            Text(
              "PNG,JPG or PDF (max 3MB)",
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  color: ColorConstant.secondBtnColor.withValues(alpha: 0.6)),
            )
          ],
        ),
      ),
    );
  }
}
