

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import '../../../../config/color/color.dart';
import '../../../../core/common/custom_button.dart';
import '../widgets/tg_signin_button.dart';

class SignIn extends StatelessWidget {
   SignIn({super.key});

  DateTime? _lastBackPressTime;

  void _onWillPop(BuildContext context, bool didPop) async {
    if (!didPop && GoRouterState.of(context).matchedLocation != '/signIn') {


    } else if (!didPop && GoRouterState.of(context).matchedLocation == '/signIn') {
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
    child:
      Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: () => context.goNamed("houseType"), icon: Icon(Icons.arrow_back)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          spacing:27,
          children: [
            Text(tr("Sign in with"),
              style: Theme.of(context)
                  .textTheme
                  .headlineSmall!
                  .copyWith(fontWeight: FontWeight.w700,fontSize: 20),
            ),
            Container(
              margin: EdgeInsets.only(top:10),
              width: MediaQuery.of(context).size.width,
              child: CustomButton(
                  onPressed:(){
                    context.goNamed('accountSetup');
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: ColorConstant.primaryColor,
                      elevation: 0,
                      padding: EdgeInsets.symmetric(
                          horizontal: 24, vertical: 18)),
                  child:Text(tr("Phone number"),
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w700),
                  )),
            ),
            OrSignInWithDiv(),
            SignInTgButton()

          ],
        ),
      ),
    ));
  }
}

class OrSignInWithDiv extends StatelessWidget {
  const OrSignInWithDiv({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 10,
      children: [
      Expanded(
        child: Divider(
          color: ColorConstant.cardGrey,
        ),
      ),Text(tr("Or sign with"),style: Theme.of(context).textTheme.bodyMedium!.copyWith(
        fontSize: 14,fontWeight: FontWeight.w500,color: ColorConstant.secondBtnColor.withValues(alpha: 0.6)
      ),),
      
      Expanded(child: Divider(color: ColorConstant.cardGrey,))
    ],);
  }
}
