import 'package:bottom_navbar_with_indicator/bottom_navbar_with_indicator.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:minapp/main.dart';

import '../../../../../../config/color/color.dart';

class GuestHome extends StatefulWidget {
  const GuestHome({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  @override
  State<GuestHome> createState() => _GuestHomeState();
}

class _GuestHomeState extends State<GuestHome> {
  DateTime? _lastBackPressTime;
  void _onWillPop(BuildContext context, bool didPop) async {
    if (!didPop && widget.navigationShell.currentIndex != 0) {
      widget.navigationShell.goBranch(0);

    } else if (!didPop && widget.navigationShell.currentIndex == 0) {
      final currentTime = DateTime.now();
      if (_lastBackPressTime == null ||
          currentTime.difference(_lastBackPressTime!) >
              const Duration(seconds: 2)) {
        _lastBackPressTime = currentTime;
        Fluttertoast.showToast(
          msg: "Tap again to exit.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      } else {
        SystemNavigator.pop();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
        canPop: false,
        onPopInvokedWithResult: (didPop, result) {
      if (didPop) {}
      _onWillPop(context, didPop);
    },
     child: Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
      bottomNavigationBar: CustomLineIndicatorBottomNavbar(
        selectedColor: ColorConstant.primaryColor,
        unSelectedColor: ColorConstant.inActiveColor.withValues(alpha: 0.9),
        backgroundColor: Colors.white,
        enableLineIndicator: true,
        indicatorType: IndicatorType.top,
        currentIndex: widget.navigationShell.currentIndex,
        unselectedIconSize: 17,
        selectedIconSize: 25,
        customBottomBarItems: [
          CustomBottomBarItems(
            isAssetsImage: true,
            label: tr('Home'),
            assetsImagePath: 'assets/icons/home.png',
            icon: Icons.home_filled,
          ),
          CustomBottomBarItems(
              isAssetsImage: true,
              label: tr('Booked'),
              assetsImagePath: 'assets/icons/booked.png',
              icon: Icons.bookmark),
          CustomBottomBarItems(
              isAssetsImage: true,
              label:tr('Profile'),
              assetsImagePath: 'assets/icons/user.png',
              icon: Icons.account_circle),
        ],
        onTap: (item) => widget.navigationShell.goBranch(item),
      ),
      body: widget.navigationShell,
    ));
  }
}
