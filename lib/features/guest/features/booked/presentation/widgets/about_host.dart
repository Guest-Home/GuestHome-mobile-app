import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:minapp/core/utils/call_and_sms.dart';
import 'package:minapp/features/guest/features/booked/domain/entities/my_booking_detail.dart';
import '../../../../../../config/color/color.dart';
import '../../../../../../core/apiConstants/api_url.dart';
import '../../../../../../core/common/custom_button.dart';

class AboutHostCard extends StatelessWidget {
  const AboutHostCard({
    super.key,
    required this.userEntity, required this.image, required this.token
  });

  final UserDetailEntity userEntity;
  final String image;
  final String token;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: Colors.white,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: BorderSide(color: Colors.white)),
      child: Column(
        spacing: 10,
        children: [
          ListTile(
            leading:  CircleAvatar(
              radius: 20,
              backgroundColor: ColorConstant.cardGrey,
              backgroundImage: CachedNetworkImageProvider(
                ApiUrl.baseUrl + image,
                headers: {'Authorization': 'Bearer $token'},
              ),
            ),
            title: Text("${userEntity.userAccount!.firstName!} ${userEntity.userAccount!.lastName!}",style: Theme.of(context).textTheme
              .bodyMedium!.copyWith(
              fontWeight: FontWeight.w600,
              fontSize: 12
            ),),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              spacing: 10,
              children: [
                Text(tr("Phone number"),style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  fontSize: 12,
                  fontWeight: FontWeight.w400
                ),),
                Text(
                  userEntity.phoneNumber!,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(fontWeight: FontWeight.w600,fontSize: 12),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              spacing: 10,
              children: [
                Text(tr("Telegram Username"),style:Theme.of(context).textTheme.bodyMedium!.copyWith(
    fontSize: 12,
    fontWeight: FontWeight.w400
    ),),
                Text(
                  userEntity.userAccount!.username!,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(fontWeight: FontWeight.w600,fontSize: 12),
                )
              ],
            ),
          ),
          Row(
            spacing: 10,
            children: [
              Expanded(
                  child: CustomButton(
                      onPressed: ()async{
                       makePhoneCall(userEntity.phoneNumber!);
                      },
                      style: ElevatedButton.styleFrom(
                          elevation: 0,
                          padding: EdgeInsets.all(4),
                          backgroundColor: ColorConstant.green,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(100),
                          )),
                      child: Text(tr(
                        "Call"),
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(color: Colors.white,fontSize: 12,fontWeight: FontWeight.w400),
                      ))),
              Expanded(
                  child: CustomButton(
                      onPressed: () {
                      sendSMS(userEntity.phoneNumber!, "");
                      },
                      style: ElevatedButton.styleFrom(
                          elevation: 0,
                          padding: EdgeInsets.all(4),
                          backgroundColor: ColorConstant.primaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(100),
                          )),
                      child: Text(tr(
                        "Message"),
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(color: Colors.white,fontSize: 12,fontWeight: FontWeight.w400),
                      ))),
            ],
          ),
        ],
      ),
    );
  }
}
