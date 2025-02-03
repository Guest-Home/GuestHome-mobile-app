import 'package:bottom_navbar_with_indicator/bottom_navbar_with_indicator.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:minapp/config/color/color.dart';

class Home extends StatelessWidget {
  const Home({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

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
    if (location.startsWith('/deleteAccount')) {
      return 4;
    }
    if (location.startsWith('/paymentSetting')) {
      return 4;
    }
    if (location.startsWith('/addFunds')) {
      return 4;
    }
    if (location.startsWith('/commission')) {
      return 4;
    }
    if (location.startsWith('/verifyOldPhone')) {
      return 4;
    } if (location.startsWith('/depositHistory')) {
      return 4;
    }
    if (location.startsWith('/verifyNewPhone')) {
      return 4;
    }




    return 0;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      floatingActionButton: Container(
        margin: EdgeInsets.only(top: 65),
        child: FloatingActionButton(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8)
          ),
          autofocus: false,
          onPressed: () {
            context.pushNamed('addProperty');
          },
          backgroundColor: ColorConstant.primaryColor,
          elevation:0,
          child: Icon(
            Icons.add_circle_outline,
            size: 27,
            color: Colors.white,
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButtonAnimator: FloatingActionButtonAnimator.noAnimation,

      bottomNavigationBar: Material(
        elevation: 10,
        shadowColor: ColorConstant.primaryColor,
        child: CustomLineIndicatorBottomNavbar(
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
            onTap: (item) => {
                  if (item == 0)
                    {navigationShell.goBranch(item)}
                  else if (item == 1)
                    {navigationShell.goBranch(item)}
                  else if (item == 3)
                    {navigationShell.goBranch(2)}
                  else if (item == 4)
                    {navigationShell.goBranch(3)}
                }),
      ),
      body: navigationShell,
    );
  }
}
