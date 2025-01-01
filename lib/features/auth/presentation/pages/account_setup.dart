import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:minapp/config/color/color.dart';
import 'package:minapp/core/common/back_button.dart';
import 'package:minapp/core/common/custom_button.dart';
import 'package:minapp/core/common/custom_text_field.dart';
import 'package:minapp/core/common/spin_kit_loading.dart';
import 'package:minapp/core/utils/validator.dart';
import 'package:minapp/features/auth/presentation/bloc/auth_bloc.dart';

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
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.otpResponseEntity.message)));
          }
        },
        buildWhen: (previous, current) => previous != current,
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(15),
            child: Form(
              key: _formKey,
              child: Column(
                spacing: 25,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Enter your phone number",
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge!
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                  CustomTextField(
                      textEditingController: _phoneController,
                      hintText: "988885555",
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
                          context.read<AuthBloc>().add(CountryCodeSelectorEvent(
                              countryCode: value.toString()));
                        },
                        onChange: (value) {
                          context.read<AuthBloc>().add(CountryCodeSelectorEvent(
                              countryCode: value.toString()));
                        },
                      ),
                      textInputType: TextInputType.phone),
                  Container(
                    margin: EdgeInsets.only(top: 30),
                    width: MediaQuery.of(context).size.width,
                    child: CustomButton(
                        onPressed: () {
                          _formKey.currentState!.save();
                          if (_formKey.currentState!.validate()) {
                            context.read<AuthBloc>().add(
                                CreateOtpEvent(phone: "+${state.phoneNumber}"));
                          }
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: ColorConstant.primaryColor,
                            padding: EdgeInsets.all(15)),
                        child: state is CreatingOtpLoadingState
                            ? loading
                            : Text(
                                "Verify Phone Number",
                                style: TextStyle(color: Colors.white),
                              )),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
