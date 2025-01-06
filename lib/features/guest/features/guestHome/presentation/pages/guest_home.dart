import 'package:bottom_navbar_with_indicator/bottom_navbar_with_indicator.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../../../config/color/color.dart';

class GuestHome extends StatelessWidget {
  const GuestHome({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;
  
  int _getSelectedIndex(BuildContext context) {
    final location = GoRouter.of(context).state?.path;
    if (location!.startsWith('/houseType')) {
      return 0;
    }
    if (location.startsWith('/booked')) {
      return 1;
    }
    if (location.startsWith('/guestProfile')) {
      return 2;
    }
    return 0;
  }

  void _onItemTapped(BuildContext context, int index) {
    switch (index) {
      case 0:
        context.go('/houseType');
        break;
      case 1:
        context.go('/booked');
        break;
      case 2:
        context.go('/guestProfile');

    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
      bottomNavigationBar: CustomLineIndicatorBottomNavbar(
        selectedColor: ColorConstant.primaryColor,
        unSelectedColor: ColorConstant.inActiveColor.withValues(alpha: 0.9),
        backgroundColor: Colors.white,
        enableLineIndicator: true,
        indicatorType: IndicatorType.top,
        currentIndex:navigationShell.currentIndex,
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
              isAssetsImage: true, label:tr('Booked'),
              assetsImagePath: 'assets/icons/booked.png',
              icon: Icons.bookmark),
          CustomBottomBarItems(
              isAssetsImage: true,
              label: 'Profile',
              assetsImagePath: 'assets/icons/user.png',
              icon: Icons.account_circle),
        ],
        onTap: (item) => navigationShell.goBranch(item),
      ),
      body: navigationShell,
    );
  }
}
