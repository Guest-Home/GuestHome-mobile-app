
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

import '../../../../../../config/color/color.dart';
import '../../../../../../core/common/back_button.dart';
import '../../../../../../core/common/custom_button.dart';

class VerifyNewPhone extends StatelessWidget {
  const VerifyNewPhone({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: AppBarBackButton(),
        title: Text(
          'OTP',
          style: Theme.of(context)
              .textTheme
              .bodyLarge!
              .copyWith(fontWeight: FontWeight.bold),
        ),
      ),

      body: Padding(padding:EdgeInsets.all(16),
      child:   SingleChildScrollView(
        child: Column(
        spacing: 16,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "OTP Verification",
            style: Theme.of(context)
                .textTheme
                .headlineMedium!
                .copyWith(fontWeight: FontWeight.w700,fontSize: 18),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 3),
            child: RichText(
                textAlign: TextAlign.start,
                text: TextSpan(children: [
                  TextSpan(
                    text:'Please enter the one time password sent to your mobile number ',
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(
                        fontSize: 14,
                        fontWeight: FontWeight.w400),
                  ),
                  TextSpan(
                      text: "0000",
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(fontWeight: FontWeight.w700))
                ])),
          ),
          SizedBox(
            height: 8,
          ),
          Center(
            child: Pinput(
              length: 6,
              keyboardType: TextInputType.number,
              mainAxisAlignment: MainAxisAlignment.start,
              focusedPinTheme: PinTheme(
                width: 56,
                height: 56,
                textStyle: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                ),
                padding: EdgeInsets.only(right: 20),
                decoration: BoxDecoration(
                  border:
                  Border.all(color: ColorConstant.primaryColor),
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onCompleted: (pin) {
                // context
                //     .read<AuthBloc>()
                //     .add(AddOtpCodeEvent(otpCode: pin));
              },
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 3),
            child: RichText(
                textAlign: TextAlign.start,
                text: TextSpan(children: [
                  TextSpan(
                    text: 'Did’t receive the code?\n Resend in ',
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(
                        fontSize: 14,
                        fontWeight: FontWeight.w400),
                  ),
                  TextSpan(
                      text: "45 second",
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(fontWeight: FontWeight.w700,fontSize: 14))
                ])),
          ),
          Container(
            margin: EdgeInsets.only(top: 30),
            width: MediaQuery.of(context).size.width,
            child: CustomButton(
                onPressed:() {
                  // context
                  //     .read<AuthBloc>()
                  //     .add(VerifyOtpEvent());
                },
                style: ElevatedButton.styleFrom(
                    elevation: 0,
                    backgroundColor: ColorConstant.primaryColor,
                    padding: EdgeInsets.symmetric(
                        horizontal: 24, vertical: 18)),
                child: Text(
                  "Verify",
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w700),
                )),
          )
        ],
      ),
    ),

        ),
    );
  }
}
