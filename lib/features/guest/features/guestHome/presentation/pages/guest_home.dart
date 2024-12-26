import 'package:bottom_navbar_with_indicator/bottom_navbar_with_indicator.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../../../config/color/color.dart';

class GuestHome extends StatelessWidget {
  const GuestHome({super.key, required this.child});

  final Widget child;

  int _getSelectedIndex(BuildContext context) {
    final location = GoRouter.of(context).state?.path;
    if (location!.startsWith('/houseType')) {
      return 0;
    }
    if (location.startsWith('/booked')) {
      return 1;
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
        currentIndex: _getSelectedIndex(context),
        unselectedIconSize: 17,
        selectedIconSize: 25,
        customBottomBarItems: [
          CustomBottomBarItems(
            isAssetsImage: false,
            label: 'Home',
            icon: Icons.home_filled,
          ),
          CustomBottomBarItems(
              isAssetsImage: false, label: 'Booked', icon: Icons.bookmark),
          CustomBottomBarItems(
              isAssetsImage: false,
              label: 'Profile',
              icon: Icons.account_circle),
        ],
        onTap: (item) => _onItemTapped(context, item),
      ),
      body: child,
    );
  }
}
