import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../../../config/color/color.dart';
import '../../../HousType/presentation/widgets/section_header_text.dart';

class AvailableFacilities extends StatelessWidget {
  const AvailableFacilities({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return
      Card(
      elevation: 0,
      color: Colors.white,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side:
              BorderSide(color: ColorConstant.cardGrey.withValues(alpha: 0.5))),
      child: Column(

        children: [
          SecctionHeader(title: tr("Facilities"), isSeeMore: false),
          Padding(
            padding: const EdgeInsets.all(15),
            child: Wrap(
              spacing: 30,
              runSpacing: 20,
              children: List.generate(
                10,
                (index) => Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  spacing: 5,
                  children: [
                    Container(
                        padding: EdgeInsets.all(7),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle, color: ColorConstant.yellow),
                        child: Icon(
                          Icons.wifi,
                          color: Colors.white,
                        )),
                    Text("wifi")
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
