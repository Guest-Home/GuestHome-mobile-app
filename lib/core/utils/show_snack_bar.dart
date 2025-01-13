


 import 'package:flutter/material.dart';

import '../../config/color/color.dart';

showErrorSnackBar(BuildContext context,String message)=> ScaffoldMessenger.of(context).showSnackBar(SnackBar(
 content: Text(message),
 behavior: SnackBarBehavior.floating,
 elevation: 0,
 backgroundColor: ColorConstant.red,
 ));

 showSuccessSnackBar(BuildContext context,String message)=> ScaffoldMessenger.of(context).showSnackBar(SnackBar(
   content: Text(message),
   behavior: SnackBarBehavior.floating,
   elevation: 0,
   backgroundColor: ColorConstant.green,
 ));