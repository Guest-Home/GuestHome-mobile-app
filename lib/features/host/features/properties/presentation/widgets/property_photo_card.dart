import 'package:flutter/material.dart';

import '../../../../../../config/color/color.dart';

class PropertyPhotoCard extends StatelessWidget {
  const PropertyPhotoCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Placeholder(
          fallbackHeight: 80,
          fallbackWidth: 80,
        ),
        Expanded(
          child: ListTile(
            title: Text('photo name.png'),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 10,
              children: [
                Text("23 MB"),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  spacing: 10,
                  children: [
                    Expanded(
                      child: LinearProgressIndicator(
                        backgroundColor: ColorConstant.primaryColor,
                        value: 1,
                        valueColor: AlwaysStoppedAnimation<Color>(
                            ColorConstant.primaryColor),
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    Text("100%"),
                    Icon(
                      Icons.delete_forever,
                      size: 20,
                      color:
                          ColorConstant.secondBtnColor.withValues(alpha: 0.6),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
