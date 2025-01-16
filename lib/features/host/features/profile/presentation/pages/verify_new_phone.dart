
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:minapp/features/host/features/profile/presentation/bloc/change_phone_number/change_phone_bloc.dart';
import 'package:minapp/features/host/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:pinput/pinput.dart';

import '../../../../../../config/color/color.dart';
import '../../../../../../core/common/back_button.dart';
import '../../../../../../core/common/custom_button.dart';
import '../../../../../../core/common/spin_kit_loading.dart';
import '../../../../../../core/utils/show_snack_bar.dart';

class VerifyNewPhone extends StatelessWidget {
  const VerifyNewPhone({super.key,});


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
        child: BlocConsumer<ChangePhoneBloc, ChangePhoneState>(
  listener: (context, state) {
    if(state is VerifyingOtpNewSuccess){
      showSuccessSnackBar(context, state.message);
      context.read<ProfileBloc>().add(GetUserProfileEvent());
      if (GoRouter.of(context)
          .routerDelegate
          .state!
          .name ==
          'guestVerifyOldPhone') {
        context.goNamed('guestProfile');
      } else {
        context.goNamed('profile',
        );
      }
    }
    else if(state is PhoneChangeErrorState){
      showErrorSnackBar(context, state.failure.message);
    }

  },
  builder: (context, state) {
    return Column(
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
                      text:state.newPhone,
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
                context
                    .read<ChangePhoneBloc>()
                    .add(AddNewOtpEvent(otp: pin));
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
                  context
                      .read<ChangePhoneBloc>()
                      .add(VerifyNewOtpEvent());
                },
                style: ElevatedButton.styleFrom(
                    elevation: 0,
                    backgroundColor: ColorConstant.primaryColor,
                    padding: EdgeInsets.symmetric(
                        horizontal: 24, vertical: 18)),
                child:state is VerifyingOtpNew?loading: Text(
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
      );
  },
),
    ),

        ),
    );
  }
}
