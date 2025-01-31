import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:minapp/core/common/spin_kit_loading.dart';

RepaintBoundary loadingIndicator() => RepaintBoundary(child: CupertinoActivityIndicator());

Future<dynamic> lodingDialog(BuildContext context) {
  return showDialog(context: context,
    barrierDismissible: false,
    builder: (context) => SizedBox(
      width: 100,
      height: 100,
      child: loadingWithPrimary,
    ),);
}