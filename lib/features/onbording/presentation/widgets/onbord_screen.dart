import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:minapp/config/color/color.dart';

class OnbordScreen extends StatelessWidget {
  const OnbordScreen(
      {super.key,
      required this.title,
      required this.subtitle,
      required this.image});

  final String title;
  final String subtitle;
  final String image;

  @override
  Widget build(BuildContext context) {
    return  Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
              width: MediaQuery.of(context).size.width,
              child: ListTile(
                  title: Text(tr(title),
                      textAlign:TextAlign.start,
                      maxLines:2,
                      style: TextTheme.of(context)
                          .headlineLarge
                          ?.copyWith(color: ColorConstant.primaryColor,fontSize:32,fontWeight: FontWeight.w700)
          
                      ),
              )),
          Expanded(
            child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child:  Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child:Image.asset(image,fit: BoxFit.contain,),),),
          ),
        ].animate().fade(),

    );
  }
}
