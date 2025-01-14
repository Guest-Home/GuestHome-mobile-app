


 import 'package:flutter/material.dart';

import '../../config/color/color.dart';

showErrorSnackBar(BuildContext context,String message)=> ScaffoldMessenger.of(context).showSnackBar(SnackBar(
 content:ListTile(
   leading: Icon(Icons.error_outline,color: ColorConstant.red,size: 20,),
   title: Text("Error",style: Theme.of(context).textTheme.bodyMedium!.copyWith(
       color: ColorConstant.red,
       fontWeight: FontWeight.w700,fontSize: 14
   )),subtitle:Text(message,style: Theme.of(context).textTheme.bodyMedium!.copyWith(
     fontSize: 12,
     color: ColorConstant.red,
     fontWeight: FontWeight.w500
 )) ,),
 behavior: SnackBarBehavior.floating,
 elevation: 0,
  padding: EdgeInsets.all(0),
 backgroundColor: ColorConstant.snacErrorBg,
  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
 ));

 showSuccessSnackBar(BuildContext context,String message)=> ScaffoldMessenger.of(context).showSnackBar(SnackBar(
   content: ListTile(
     leading: Icon(Icons.check_circle,color: ColorConstant.green,size: 20,),
     title: Text("Success",
       style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.w700,fontSize: 14,
         color: ColorConstant.green
     ),),subtitle:Text(message,style: Theme.of(context).textTheme.bodyMedium!.copyWith(
       color: ColorConstant.green,
     fontSize: 12,
     fontWeight: FontWeight.w500
   ),) ,),
   behavior: SnackBarBehavior.floating,
   elevation: 0,
   padding: EdgeInsets.all(0),
   backgroundColor:ColorConstant.snacSuccessBg,
   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
 ));