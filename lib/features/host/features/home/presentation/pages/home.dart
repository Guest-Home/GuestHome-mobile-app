import 'package:bottom_navbar_with_indicator/bottom_navbar_with_indicator.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:minapp/config/color/color.dart';

class Home extends StatelessWidget {
  const Home({super.key, required this.child});

  final Widget child;
  int _getSelectedIndex(BuildContext context) {
    final location = GoRouter.of(context).state?.path;
    if (location!.startsWith('/properties')) {
      return 0;
    }
    if (location.startsWith('/request')) {
      return 1;
    }
    if (location.startsWith('/analytics')) {
      return 3;
    }
    if (location.startsWith('/profile')) {
      return 4;
    }
    if (location.startsWith('/generalInformation')) {
      return 4;
    }
    if (location.startsWith('/language')) {
      return 4;
    }
    if (location.startsWith('/account')) {
      return 4;
    }
    return 0;
  }

  void _onItemTapped(BuildContext context, int index) {
    switch (index) {
      case 0:
        context.go('/properties');
        break;
      case 1:
        context.go('/request');
        break;
      case 3:
        context.go('/analytics');
        break;
      case 4:
        context.go('/profile');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Container(
        margin: EdgeInsets.only(top: 65),
        child: FloatingActionButton(
          autofocus: false,
          onPressed: () {
            context.goNamed('addProperty');
          },
          backgroundColor: ColorConstant.primaryColor,
          elevation: 10,
          child: Icon(
            Icons.add_circle_outline,
            size: 27,
            color: Colors.white,
          ),
        ),
      ),
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
            isAssetsImage: true,
            label: 'Properties',
            assetsImagePath: 'assets/icons/home.png',
            icon: Icons.home_filled,
          ),
          CustomBottomBarItems(
              isAssetsImage: true,
              label: 'Request',
              assetsImagePath: 'assets/icons/notification.png',
              icon: Icons.notifications_active),
          CustomBottomBarItems(
              isAssetsImage: false, label: '', icon: Icons.add_box),
          CustomBottomBarItems(
              isAssetsImage: true,
              label: 'Analytics',
              assetsImagePath: 'assets/icons/anaalytics.png',
              icon: Icons.analytics),
          CustomBottomBarItems(
              isAssetsImage: true,
              label: 'Profile',
              assetsImagePath: 'assets/icons/user.png',
              icon: Icons.account_circle),
        ],
        onTap: (item) => _onItemTapped(context, item),
      ),
      body: child,
    );
  }
}
