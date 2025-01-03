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
                SnackBar(content: Text(state.otpResponseEntity.message),backgroundColor: ColorConstant.green,));
          }
          else if(state is OtpErrorState){
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.failure.message),backgroundColor: ColorConstant.red,));
          }
        },
        buildWhen: (previous, current) => previous != current,
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(
                spacing: 25,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 10,),
                  Text(
                    "Enter your phone number",
                    style: Theme.of(context)
                        .textTheme
                        .headlineSmall!
                        .copyWith(fontWeight: FontWeight.w700),
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
                    margin: EdgeInsets.only(top: 70),
                    width: MediaQuery.of(context).size.width,
                    child: CustomButton(
                        onPressed: state is CreatingOtpLoadingState
                            ? () {}
                            : () {
                                _formKey.currentState!.save();
                                if (_formKey.currentState!.validate()) {
                                  context.read<AuthBloc>().add(CreateOtpEvent(
                                      phone: "+${state.phoneNumber}"));
                                }
                              },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: ColorConstant.primaryColor,
                            padding: EdgeInsets.symmetric(horizontal: 24,vertical: 21)),
                        child: state is CreatingOtpLoadingState
                            ? loading
                            : Text(
                                "Verify Phone Number",
                                style:Theme.of(context).textTheme.bodyMedium!.copyWith(color: Colors.white,fontSize: 16,
                                    fontWeight: FontWeight.w700),
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
