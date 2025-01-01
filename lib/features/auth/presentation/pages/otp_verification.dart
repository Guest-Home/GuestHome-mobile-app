import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:minapp/config/color/color.dart';
import 'package:minapp/core/common/back_button.dart';
import 'package:minapp/core/common/spin_kit_loading.dart';
import 'package:minapp/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:pinput/pinput.dart';

import '../../../../core/common/custom_button.dart';

class OtpVerification extends StatelessWidget {
  const OtpVerification({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: context.read<AuthBloc>(),
      child: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is VerifyedOtpLodedState) {
            context.goNamed('profileSetup');
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                backgroundColor: ColorConstant.green,
                content: Text("Otp Verifyed")));
          } else if (state is OtpErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                backgroundColor: ColorConstant.red,
                content: Text(state.failure.message)));
          }
        },
        builder: (context, state) {
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
                    RichText(
                        textAlign: TextAlign.start,
                        text: TextSpan(children: [
                          TextSpan(
                            text:
                                'Please enter the one time password sent to your mobile number ',
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          TextSpan(
                              text: state.phoneNumber,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(fontWeight: FontWeight.bold))
                        ])),
                    Center(
                      child: Pinput(
                        length: 6,
                        keyboardType: TextInputType.number,
                        mainAxisAlignment: MainAxisAlignment.center,
                        focusedPinTheme: PinTheme(
                          width: 56,
                          height: 56,
                          textStyle: TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                          ),
                          padding: EdgeInsets.only(right: 15),
                          decoration: BoxDecoration(
                            border:
                                Border.all(color: ColorConstant.primaryColor),
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        onCompleted: (pin) {
                          context
                              .read<AuthBloc>()
                              .add(AddOtpCodeEvent(otpCode: pin));
                        },
                      ),
                    ),
                    Text('Didn’t receive the code?\n Resend in 45 seconds'),
                    Container(
                      margin: EdgeInsets.only(top: 30),
                      width: MediaQuery.of(context).size.width,
                      child: CustomButton(
                          onPressed: () {
                            context.read<AuthBloc>().add(VerifyOtpEvent());
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: ColorConstant.primaryColor,
                              padding: EdgeInsets.all(15)),
                          child: state is VerifyingOtpLoadingState
                              ? loading
                              : Text(
                                  "Verify",
                                  style: TextStyle(color: Colors.white),
                                )),
                    )
                  ],
                ),
              ));
        },
      ),
    );
  }
}
