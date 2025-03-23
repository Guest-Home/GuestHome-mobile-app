import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:minapp/config/color/color.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../../core/common/back_button.dart';

class TermCondition extends StatelessWidget {
  const TermCondition({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: AppBarBackButton(),
        title: Text(
          tr("Term and condition"),
          style: Theme.of(context)
              .textTheme
              .bodyLarge!
              .copyWith(fontWeight: FontWeight.bold),
        ),
      ),
      body:
      Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing:10,
          children: [
            Text("The GuestHome Platform provides a digital marketplace where property owners (Hosts) can list their properties and connect with potential renters (Guests). These Terms and Conditions outline the rights and responsibilities of both parties and the operational framework of the Platform. By Using the Platform, both Hosts and Guests agree to abide by these terms.",
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              fontSize: 14,
              fontWeight: FontWeight.w400
            ),),
            Text("1. Host: A property owner or manager who lists their property on the GuestHome Platform for booking purposes. The Host is responsible for providing accurate information about the property such as Hotel and Resort, Pension, Warehouse, House, Private room, Shared space, Unit of Condominium, Apartment, Hotel room, Guest house, Hall and others ensuring it is clean and safe for Guests, and complying with all relevant laws and Regulations.",
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              fontSize: 14,
              fontWeight: FontWeight.w400
            ),),
            SizedBox(
              width: 170,
              child: ListTile(
                onTap: ()async{
                  final Uri url = Uri.parse("https://etguesthome.com/TermCondition.html");
                  if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
                    throw 'Could not launch $url';
                  }
                },
                trailing: Icon(Icons.link),
                title: Text("READ MORE",style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: ColorConstant.primaryColor
                ),),
              ),
            )

          ],
        ),
      ),
    );
  }
}
