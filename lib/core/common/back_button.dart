
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

class AppBarBackButton extends StatelessWidget {
  const AppBarBackButton({
    super.key, this.route,
  });
  final String? route;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:() {
        if(route!.isNotEmpty){
          context.goNamed(route!);
        }else{
          context.pop();
        }
      },
      child: SvgPicture.asset('assets/icons/arrow-left.svg',
        semanticsLabel: 'back',
      ),
    );
  }
}