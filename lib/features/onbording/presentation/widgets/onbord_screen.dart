import 'package:flutter/material.dart';
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
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
              width: MediaQuery.of(context).size.width,
              child: ListTile(
                  title: Text(title,
                      style: TextTheme.of(context)
                          .headlineMedium
                          ?.copyWith(color: ColorConstant.primaryColor,fontSize: 24,fontWeight: FontWeight.w700)
          
                      ),
                  subtitle: Column(
                    spacing: 10,
                    children: [
                       Text(
                        subtitle,
                        style:Theme.of(context).textTheme.bodyLarge!.copyWith(
                            fontSize: 18,fontWeight: FontWeight.w400,
                            color: ColorConstant.primaryColor.withValues(alpha: 0.6)),
                      ),
                       Padding(
                          padding: const EdgeInsets.only(top: 30),
                          child:Image.asset(image,fit: BoxFit.cover,),),
          
                    ],
                  ))),
        ],
      ),
    );
  }
}
