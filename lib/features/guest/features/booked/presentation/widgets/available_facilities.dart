import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../../config/color/color.dart';
import '../../../../../../core/common/constants/house_type_icons.dart';

class AvailableFacilities extends StatelessWidget {
  const AvailableFacilities({
    super.key, required this.subDesc,
  });

  final String subDesc;

  @override
  Widget build(BuildContext context) {
    final filteredAmenities =  subDesc.split(',').where((item) => item.trim().isNotEmpty).toList();
    return
      Card(
        elevation: 0,
        color: ColorConstant.cardGrey.withValues(alpha: 0.2),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side:
            BorderSide(color: ColorConstant.cardGrey.withValues(alpha:0))),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 10,
            children: [
              Text(tr("Facilities"),style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  fontWeight: FontWeight.w600),),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Wrap(
                  spacing: 20,
                  runSpacing: 20,
                  children: List.generate(
                      filteredAmenities.length,
                          (index){
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          spacing: 1,
                          children: [
                            Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,),
                                child:SvgPicture.asset(
                                  camenitiesIcon[filteredAmenities[index]]!,
                                  fit: BoxFit.cover,
                                  width:33,
                                  height:33,
                                )
                            ),
                            Text(tr(filteredAmenities[index]),style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                fontWeight: FontWeight.w600,
                                fontSize: 10
                            ),)
                          ],
                        );
                      }
                  ),
                ),
              ),
            ],
          ),
        ),
      );
  }
}
