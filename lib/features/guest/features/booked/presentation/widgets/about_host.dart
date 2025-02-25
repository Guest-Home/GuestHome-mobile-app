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
    required this.postedByDetailEntity, required this.image, required this.token
  });

  final PostedByDetailEntity postedByDetailEntity;
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
              backgroundImage:image.isNotEmpty?CachedNetworkImageProvider(
                ApiUrl.baseUrl + image,
                headers: {'Authorization': 'Bearer $token'},
              ):null,
              child:image.isEmpty
                  ? Icon(
                Icons.person,
                color: Colors.white,
                size: 20,
              )
                  : null,
            ),
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if(postedByDetailEntity.userAccount!=null)
                Text("${postedByDetailEntity.userAccount!.firstName!} ${postedByDetailEntity.userAccount!.lastName!}",
                  style: Theme.of(context).textTheme
                  .bodyMedium!.copyWith(
                  fontWeight: FontWeight.w600,
                  fontSize: 12
                ),),
                Text("${postedByDetailEntity.typeOfCustomer}",
                  style: Theme.of(context).textTheme
                      .bodyMedium!.copyWith(
                      fontWeight: FontWeight.w400,
                      fontSize: 10
                  ),),
              ],
            ),
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
                  postedByDetailEntity.phoneNumber!,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(fontWeight: FontWeight.w700,fontSize: 12),
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
                if(postedByDetailEntity.userAccount!=null)
                Text(
                  postedByDetailEntity.userAccount!.username==postedByDetailEntity.phoneNumber?"": postedByDetailEntity.userAccount!.username!,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(fontWeight: FontWeight.w700,fontSize: 12),
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
                       makePhoneCall(postedByDetailEntity.phoneNumber!);
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
                      sendSMS(postedByDetailEntity.phoneNumber!, "");
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
