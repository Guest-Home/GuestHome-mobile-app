import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:minapp/config/color/color.dart';
import 'package:minapp/core/common/back_button.dart';
import 'package:minapp/core/common/custom_button.dart';
import 'package:minapp/core/common/custom_text_field.dart';
import 'package:minapp/core/common/spin_kit_loading.dart';
import 'package:minapp/core/utils/show_snack_bar.dart';
import 'package:minapp/core/utils/validator.dart';
import 'package:minapp/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:minapp/features/auth/presentation/pages/sign_in.dart';
import 'package:minapp/features/auth/presentation/widgets/tg_signin_button.dart';

import '../../../../core/common/country_code_selector.dart';

class AccountSetup extends StatelessWidget {
  AccountSetup({super.key});

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: AppBarBackButton(),
      ),
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is OtpCreatedLodedState) {
            context.goNamed('otpVerification');
            showSuccessSnackBar(context, state.otpResponseEntity.message);
          } else if (state is OtpErrorState) {
            showErrorSnackBar(context, state.failure.message);
          }
          else if (state is NoInternetSate) {
            showNoInternetSnackBar(context,() {},);
          }
        },
        buildWhen: (previous, current) => previous != current,
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(16),
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  spacing: 25,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(tr("Enter your phone number"),
                      textAlign: TextAlign.start,
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall!
                          .copyWith(fontWeight: FontWeight.w700,fontSize: 20),
                    ),
                    CustomTextField(
                        textEditingController: _phoneController,
                        hintText: "9********",
                        surfixIcon: null,
                        validator: (value) {
                          if (!Validation.numberValidation(value ?? "")) {
                            return 'Please enter a valid phone number and country code';
                          }
                          return null;
                        },
                        onTextChnage: (value) {
                          context
                              .read<AuthBloc>()
                              .add(AddPhoneNumberEvent(phoneNumber: value));
                        },
                        isMultiLine: false,
                        prifixIcon: CountryCodeSelector(
                          onInit: (value) {
                            context.read<AuthBloc>().add(
                                CountryCodeSelectorEvent(
                                    countryCode: value.toString()));
                          },
                          onChange: (value) {
                            context.read<AuthBloc>().add(
                                CountryCodeSelectorEvent(
                                    countryCode: value.toString()));
                          },
                        ),
                        textInputType: TextInputType.phone),
                    Container(
                      margin: EdgeInsets.only(top: 70),
                      width: MediaQuery.of(context).size.width,
                      child: CustomButton(
                          onPressed: state is CreatingOtpLoadingState
                              ? () {}
                              : () {
                                  _formKey.currentState!.save();
                                  if (_formKey.currentState!.validate()) {
                                    context.read<AuthBloc>().add(
                                        CreateOtpEvent(phone:"${state.countryCode}${_phoneController.text}"));
                                  }
                                },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: ColorConstant.primaryColor,
                              elevation: 0,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 24, vertical: 18)),
                          child: state is CreatingOtpLoadingState
                              ? loading
                              : Text(tr("Verify phone number"),
                                  textAlign: TextAlign.start,
                                  overflow: TextOverflow.ellipsis,
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
            ),
          );
        },
      ),
    );
  }
}
