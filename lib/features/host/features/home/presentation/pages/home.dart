import 'package:bottom_navbar_with_indicator/bottom_navbar_with_indicator.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:minapp/config/color/color.dart';

class Home extends StatefulWidget {
  const Home({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
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
                label:tr('Properties'),
                assetsImagePath: 'assets/icons/home.png',
                icon: Icons.home_filled,
              ),
              CustomBottomBarItems(
                  isAssetsImage: true,
                  label:tr('Request'),
                  assetsImagePath: 'assets/icons/notification.png',
                  icon: Icons.notifications_active),
              CustomBottomBarItems(
                  isAssetsImage: false, label: '', icon: Icons.add_box),
              CustomBottomBarItems(
                  isAssetsImage: true,
                  label: tr('Analytics'),
                  assetsImagePath: 'assets/icons/anaalytics.png',
                  icon: Icons.analytics),
              CustomBottomBarItems(
                  isAssetsImage: true,
                  label: tr('Profile'),
                  assetsImagePath: 'assets/icons/user.png',
                  icon: Icons.account_circle),
            ],
            onTap: (item) => {
                  if (item == 0)
                    {widget.navigationShell.goBranch(item)}
                  else if (item == 1)
                    {widget.navigationShell.goBranch(item)}
                  else if (item == 3)
                    {widget.navigationShell.goBranch(2)}
                  else if (item == 4)
                    {widget.navigationShell.goBranch(3)}
                }),
      ),
      body: widget.navigationShell,
    ));
  }
}
