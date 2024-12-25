import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:minapp/config/color/color.dart';
import 'package:minapp/core/common/back_button.dart';
import 'package:pinput/pinput.dart';

import '../../../../../../core/common/custom_button.dart';

class OtpVerification extends StatelessWidget {
  const OtpVerification({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: AppBarBackButton(),
      ),
      body: Padding(
        padding: EdgeInsets.all(15),
        child: Column(
          spacing: 25,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Otp Verification",
              style: Theme.of(context)
                  .textTheme
                  .titleLarge!
                  .copyWith(fontWeight: FontWeight.bold),
            ),
            Text(
              "Please enter the one time password sent to your\n mobile number +251988555555",
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            Pinput(
              keyboardType: TextInputType.number,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              focusedPinTheme: PinTheme(
                width: 56,
                height: 56,
                textStyle: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                ),
                decoration: BoxDecoration(
                  border: Border.all(color: ColorConstant.primaryColor),
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onCompleted: (pin) => print(pin),
            ),
            Text('Didn’t receive the code?\n Resend in 45 seconds'),
            Container(
              margin: EdgeInsets.only(top: 30),
              width: MediaQuery.of(context).size.width,
              child: CustomButton(
                  onPressed: () {
                    context.goNamed('profileSetup');
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: ColorConstant.primaryColor,
                      padding: EdgeInsets.all(15)),
                  child: Text(
                    "Verify",
                    style: TextStyle(color: Colors.white),
                  )),
            )
          ],
        ),
      ),
    );
  }
}
