import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:minapp/config/color/color.dart';

final loading = SpinKitFadingCircle(
  color: Colors.white,
  size: 30.0,
);

final loadingWithPrimary = SpinKitFadingCircle(
  color: ColorConstant.primaryColor,
  size: 30.0,
);
