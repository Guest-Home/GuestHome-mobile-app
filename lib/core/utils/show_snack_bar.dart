import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../config/color/color.dart';

showNoInternetSnackBar(BuildContext context,){
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          // action: SnackBarAction(label: 'Retry',
          // onPressed:onpressed, textColor: ColorConstant.red,backgroundColor:
          // Colors.white,),
      content: ListTile(
        leading:Icon(Icons.signal_wifi_connected_no_internet_4,color: ColorConstant.red,),
        title: Text("No Internet connection",
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: ColorConstant.red,
                fontWeight: FontWeight.w700,
                fontSize: 14)),
        subtitle: Text("check your connection and try again!",
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                fontSize: 12,
                color: ColorConstant.red,
                fontWeight: FontWeight.w500)),
      ),
      behavior: SnackBarBehavior.floating,
      elevation: 0,
      padding: EdgeInsets.all(0),
      backgroundColor: ColorConstant.snacErrorBg,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
          dismissDirection: DismissDirection.none,
        ));
}
showErrorSnackBar(BuildContext context, String message){
  ScaffoldMessenger.of(context).clearSnackBars();
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: ListTile(
        leading: SvgPicture.asset(
          'assets/icons/errorsnack.svg',
          semanticsLabel: 'language',
          fit: BoxFit.cover,
        ),
        title: Text("Error",
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: ColorConstant.red,
                fontWeight: FontWeight.w700,
                fontSize: 14)),
        subtitle: Text(message,
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                fontSize: 12,
                color: ColorConstant.red,
                fontWeight: FontWeight.w500)),
      ),
      behavior: SnackBarBehavior.floating,
      elevation: 0,
      padding: EdgeInsets.all(0),
      backgroundColor: ColorConstant.snacErrorBg,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
    ));}
showWarningSnackBar(BuildContext context, String message){
  ScaffoldMessenger.of(context).clearSnackBars();
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: ListTile(
      leading: SvgPicture.asset(
        'assets/icons/warning.svg',
        semanticsLabel: 'language',
        fit: BoxFit.cover,
      ),
      title: Text("Information",
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              color: Colors.blue,
              fontWeight: FontWeight.w700,
              fontSize: 14)),
      subtitle: Text(message,
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              fontSize: 12,
              color: Colors.blue,
              fontWeight: FontWeight.w500)),
    ),
    behavior: SnackBarBehavior.floating,
    elevation: 0,
    padding: EdgeInsets.all(0),
    backgroundColor: ColorConstant.snacWrningBg,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
  ));
}

showSuccessSnackBar(BuildContext context, String message){
  ScaffoldMessenger.of(context).clearSnackBars();
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: ListTile(
      leading: SvgPicture.asset(
        'assets/icons/success.svg',
        semanticsLabel: 'language',
        fit: BoxFit.cover,
      ),
      title: Text(
        "Success",
        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
            fontWeight: FontWeight.w700,
            fontSize: 14,
            color: ColorConstant.green),
      ),
      subtitle: Text(
        message,
        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
            color: ColorConstant.green,
            fontSize: 12,
            fontWeight: FontWeight.w500),
      ),
    ),
    behavior: SnackBarBehavior.floating,
    elevation: 0,
    padding: EdgeInsets.all(0),
    backgroundColor: ColorConstant.snacSuccessBg,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
  ));
}


Future<dynamic> noInternetDialog(BuildContext context) {
  return showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) => AlertDialog.adaptive(
      icon: Icon(
        Icons.wifi_off_outlined,
        size: 36,
      ),
      iconColor: ColorConstant.red,
      title: Text(
        "No connection! please check your internet connection and try again",
        textAlign: TextAlign.center,
      ),
      titleTextStyle:
          TextStyle(fontSize: 16, color: ColorConstant.secondBtnColor),
    ),
  );
}
