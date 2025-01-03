import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppBarBackButton extends StatelessWidget {
  const AppBarBackButton({
    super.key,
    this.route,
  });
  final String? route;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          if (route != null) {
            context.goNamed(route!);
          } else {
            context.pop();
          }
        },
        child: Icon(Icons.arrow_back,size: 27,));
  }
}
