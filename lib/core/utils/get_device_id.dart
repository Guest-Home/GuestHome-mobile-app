
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';

class GetDeviceId{
  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

   Future<String> getId()async{
      if(Platform.isAndroid){
        AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
        return androidInfo.id;// e.g. "Moto G (4)"
      }
      else if(Platform.isIOS){
        IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
        return iosInfo.utsname.machine;
      }
      return "";

   }

}