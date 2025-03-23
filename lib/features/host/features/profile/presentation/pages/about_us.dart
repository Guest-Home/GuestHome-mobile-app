import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:minapp/config/color/color.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../../../../core/common/back_button.dart';

class AboutUs extends StatefulWidget {
   AboutUs({super.key});

  @override
  State<AboutUs> createState() => _AboutUsState();
}



class _AboutUsState extends State<AboutUs> {


  String appName='';
  String packageName='';
  String version='';

  getAppInfo()async{
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    setState(() {
      appName = packageInfo.appName;
      packageName = packageInfo.packageName;
      version = packageInfo.version;
    });

  }

  void _rateApp() async {
    final String appId = Platform.isAndroid
        ? packageName  // Replace with your Android package name
        : "id123456789";          // Replace with your iOS App Store ID

    final String url = Platform.isAndroid
        ? "https://play.google.com/store/apps/details?id=$appId"
        : "https://apps.apple.com/app/id$appId?action=write-review";

    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
    } else {
      debugPrint("Could not launch $url");
    }
  }
  @override
  void initState(){
    getAppInfo();
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: AppBarBackButton(),
        title: Text(
          tr('About us'),
          style: Theme.of(context)
              .textTheme
              .bodyLarge!
              .copyWith(fontWeight: FontWeight.bold),
        ),
      ),
      body:SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
               crossAxisAlignment: CrossAxisAlignment.center,
          spacing: 5,
          children: [
            SizedBox(height: 20,),
            ClipRRect(
                borderRadius:BorderRadius.circular(10),
                child: Image.asset("assets/icons/logo.png",width:50,height:50,)),
            Text(appName,style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  fontWeight: FontWeight.w700,
                  fontSize: 18
                ),),
            Text("Version:$version- ${DateTime.now().year}",style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                   fontSize: 14,
                   fontWeight: FontWeight.w400
                 ),),
            Text("Developed By",style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                fontWeight: FontWeight.w600,
                fontSize: 14
            ),),
            Text("Guest Home Inc.",style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                fontWeight: FontWeight.w400,
                fontSize: 14
            ),),
            TextButton(child: Text("www.etguesthome.com",style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              fontSize: 14,fontWeight: FontWeight.w400,
              color: ColorConstant.primaryColor
            ),),onPressed: ()async {
              final Uri url = Uri.parse("https://etguesthome.com/");
              if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
              throw 'Could not launch $url';
              }
            },),

            Divider(thickness: 0.7,color: ColorConstant.cardGrey,),
            ListTile(
              onTap: () {
                _rateApp();
              },
              leading: Icon(Icons.star_border),
              title: Text("Rate the app",style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                fontSize: 14,fontWeight: FontWeight.w400
              ),),
            )



          ],
        ),
      )

    );
  }
}
