import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:minapp/config/color/color.dart';
import 'package:minapp/core/common/back_button.dart';
import 'package:minapp/core/common/spin_kit_loading.dart';
import 'package:minapp/core/utils/show_snack_bar.dart';
import 'package:minapp/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:pinput/pinput.dart';
import '../../../../core/common/custom_button.dart';

class OtpVerification extends StatefulWidget {
  const OtpVerification({super.key});

  @override
  State<OtpVerification> createState() => _OtpVerificationState();
}

class _OtpVerificationState extends State<OtpVerification> {
  static const int _initialCountdown = 120; // 2 minutes in seconds
  int _remainingTime = _initialCountdown;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startCountdown();
  }

  void _startCountdown() {
    setState(() {
      _remainingTime = _initialCountdown;
    });

    _timer?.cancel();
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_remainingTime > 0) {
        setState(() {
          _remainingTime--;
        });
      } else {
        _timer?.cancel();
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  String _formatTime(int seconds) {
    int minutes = seconds ~/ 60;
    int secs = seconds % 60;
    return "$minutes:${secs.toString().padLeft(2, '0')}";
  }

  @override
  Widget build(BuildContext context) {
    return
      BlocConsumer<AuthBloc, AuthState>(
        buildWhen: (previous, current) => previous!=current,
        listener: (context, state) {
          if (state is VerifyedOtpLodedState) {
            if (state.verifyOtpEntity.hasProfile==true) {
              showSuccessSnackBar(context, "Otp Verified");
              // context.read<AuthBloc>().add(AuthResetEvent());
              context.goNamed('houseType');
            } else {
              context.goNamed('profileSetup');
              showSuccessSnackBar(context, "Otp Verified");
            }
          }
          if (state is OtpErrorState) {
            showErrorSnackBar(context, state.failure.message);
          }
          if(state is OtpCreatedLodedState){
            setState(() {
              _startCountdown();
            });
            showSuccessSnackBar(context, state.otpResponseEntity.message);
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
                      Text(tr("otp verification"),
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
                                text:"${tr('please enter the one time')} ${tr("password sent to your mobile number")} ",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400),
                              ),
                              TextSpan(
                                  text: "+${state.phoneNumber.substring(1)}",
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
                            text: TextSpan(
                                children: [
                              TextSpan(
                                text:tr("Didn't receive the code"),
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400),
                              ),
                              TextSpan(
                                  text:" ${tr("resend in second")} ${_formatTime(_remainingTime)} ${tr("second")}",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(fontWeight: FontWeight.w700,fontSize: 14))
                            ])),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 30),
                        width: MediaQuery.of(context).size.width,
                        child:_remainingTime==0?
                        CustomButton(
                            onPressed: state is CreatingOtpLoadingState
                                ? () {}
                                : () {
                                    context
                                        .read<AuthBloc>()
                                        .add(CreateOtpEvent(phone:state.phoneNumber));
                                  },
                            style: ElevatedButton.styleFrom(
                              elevation: 0,
                                backgroundColor: ColorConstant.primaryColor,
                                padding: EdgeInsets.symmetric(
                                    horizontal: 24, vertical: 18)),
                            child: state is CreatingOtpLoadingState
                                ? loading
                                : Text(
                                    "Resend",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(
                                            color: Colors.white,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w700),
                                  )):
                        CustomButton(
                            onPressed: state is VerifyingOtpLoadingState
                                ? () {}
                                : () {
                                    context
                                        .read<AuthBloc>()
                                        .add(VerifyOtpEvent());
                                  },
                            style: ElevatedButton.styleFrom(
                              elevation: 0,
                                backgroundColor: ColorConstant.primaryColor,
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
      );

  }
}



