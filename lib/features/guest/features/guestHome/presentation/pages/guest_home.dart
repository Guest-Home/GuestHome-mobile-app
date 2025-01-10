import 'package:bottom_navbar_with_indicator/bottom_navbar_with_indicator.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../../../config/color/color.dart';

class GuestHome extends StatelessWidget {
  const GuestHome({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

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
        currentIndex: navigationShell.currentIndex,
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
