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

import '../../../../core/common/bloc/internet_connection_bloc/connectivity_bloc.dart';
import '../../../../core/common/bloc/internet_connection_bloc/connectivity_state.dart';
import '../../../../core/common/country_code_selector.dart';
import '../../../../service_locator.dart';

class AccountSetup extends StatefulWidget {
  AccountSetup({super.key});

  @override
  State<AccountSetup> createState() => _AccountSetupState();
}

class _AccountSetupState extends State<AccountSetup> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _phoneController = TextEditingController();

  final connectivityBloc = sl<ConnectivityBloc>();

  @override
  Widget build(BuildContext context) {
    return BlocListener<ConnectivityBloc,ConnectivityState>(
      bloc: connectivityBloc,
      listener:(context, state) {
                 if (state is Disconnected) {
                  showNoInternetSnackBar(context,);
                }
    },
      child: Scaffold(
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
               showNoInternetSnackBar(context,);
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
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    connectivityBloc.close();
  }
}
