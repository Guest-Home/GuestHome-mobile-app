import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import '../../../../config/color/color.dart';
import '../../../../core/common/custom_button.dart';

class SignInTgButton extends StatelessWidget {
  const SignInTgButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top:1),
      width: MediaQuery.of(context).size.width,
      child: CustomButton(
          onPressed: () {
            context.goNamed('signInWithTg');
          },
          style: ElevatedButton.styleFrom(
              elevation: 0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                  side: BorderSide(color: ColorConstant.cardGrey)
              ),
              backgroundColor: Colors.white,
              foregroundColor: Colors.white,
              padding: EdgeInsets.symmetric(
                  horizontal: 24, vertical: 18)),
          child:Row(
            spacing: 15,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                'assets/icons/telegram.svg',
                semanticsLabel: 'language',
                fit: BoxFit.cover,
              ),
              Text(
                "Sign in with telegram",
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(
                    fontSize: 14,
                    fontWeight: FontWeight.w500),
              ),
            ],
          )),
    );
  }
}
