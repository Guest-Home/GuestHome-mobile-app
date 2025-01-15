
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pinput/pinput.dart';

import '../../../../config/color/color.dart';
import '../../../../core/common/back_button.dart';
import '../../../../core/common/custom_button.dart';
import '../../../../core/common/spin_kit_loading.dart';
import '../../../../core/utils/show_snack_bar.dart';
import '../bloc/auth_bloc.dart';

class TgOtpVerification extends StatelessWidget {
  const TgOtpVerification({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: context.read<AuthBloc>(),
      child: BlocConsumer<AuthBloc, AuthState>(
        buildWhen: (previous, current) => previous!=current,
        listenWhen: (previous, current) => previous!=current,
        listener: (context, state) {
          if (state is VerifyedOtpLodedState) {
            if (state.verifyOtpEntity.hasProfile==true)
              {
              showSuccessSnackBar(context, "Otp Verified");
              context.goNamed('houseType');
            } else {
              context.goNamed('profileSetup');
              showSuccessSnackBar(context, "Otp Verified");
            }
          }
          if (state is OtpErrorState) {
            showErrorSnackBar(context, state.failure.message);
          }
        },
        builder: (context, state) {
          return Scaffold(
              appBar: AppBar(
                leading: AppBarBackButton(),
              ),
              body: Padding(
                padding: EdgeInsets.all(16),
                child: SingleChildScrollView(
                  child: Column(
                    spacing: 16,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Otp Verification",
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium!
                            .copyWith(fontWeight: FontWeight.w700,fontSize: 20),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 3),
                        child: RichText(
                            textAlign: TextAlign.start,
                            text: TextSpan(children: [
                              TextSpan(
                                text:
                                'Please enter the one time password sent to your telegram username ',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400),
                              ),
                              TextSpan(
                                  text:"@${state.phoneNumber}",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(fontWeight: FontWeight.bold))
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
                            context
                                .read<AuthBloc>()
                                .add(AddOtpCodeEvent(otpCode: pin));
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
                            onPressed: state is VerifyingOtpLoadingState
                                ? () {}
                                : () {
                              context
                                  .read<AuthBloc>()
                                  .add(VerifyOtpEvent());
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor: ColorConstant.primaryColor,
                                elevation: 0,
                                padding: EdgeInsets.symmetric(
                                    horizontal: 24, vertical: 18)),
                            child: state is VerifyingOtpLoadingState
                                ? loading
                                : Text(
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
              ));
        },
      ),
    );
  }
}
