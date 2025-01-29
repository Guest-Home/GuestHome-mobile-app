import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:minapp/core/common/spin_kit_loading.dart';
import 'package:minapp/features/auth/presentation/bloc/auth_bloc.dart';
import '../../../../config/color/color.dart';
import '../../../../core/common/back_button.dart';
import '../../../../core/common/custom_button.dart';
import '../../../../core/common/custom_text_field.dart';
import '../../../../core/utils/show_snack_bar.dart';
import '../../../../core/utils/validator.dart';

class SignInWithTg extends StatelessWidget {
  SignInWithTg({super.key});

  final TextEditingController tgUserController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: AppBarBackButton(),
      ),
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is OtpCreatedLodedState) {
            context.goNamed('tgOtpVerification');
            showSuccessSnackBar(context, state.otpResponseEntity.message);
          } else if (state is OtpErrorState) {
            showErrorSnackBar(context, state.failure.message);
          } else if (state is NoInternetSate) {
            noInternetDialog(context);
          }
        },
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(16),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                spacing: 27,
                children: [
                  Text(
                    "Sign with telegram",
                    style: Theme.of(context)
                        .textTheme
                        .headlineSmall!
                        .copyWith(fontWeight: FontWeight.w700, fontSize: 20),
                  ),
                  SizedBox(
                      child: Form(
                    key: _formKey,
                    child: Column(
                      spacing: 10,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RichText(
                            text: TextSpan(children: [
                          TextSpan(
                              text: "Telegram username",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(fontWeight: FontWeight.w500)),
                          TextSpan(
                              text: "*",
                              style: TextStyle(color: ColorConstant.red))
                        ])),
                        CustomTextField(
                            textEditingController: tgUserController,
                            hintText: "eg UserName",
                            surfixIcon: Icon(Icons.telegram),
                            validator: (value) {
                              if (!Validation.tgUserName(value!)) {
                                return 'Please enter a valid TG userName';
                              }
                              return null;
                            },
                            onTextChnage: (value) {
                              context
                                  .read<AuthBloc>()
                                  .add(AddTgUserNameEvent(tgUserName: value));
                            },
                            isMultiLine: false,
                            textInputType: TextInputType.text),
                      ],
                    ),
                  )),
                  Container(
                    margin: EdgeInsets.only(top: 10),
                    width: MediaQuery.of(context).size.width,
                    child: CustomButton(
                        onPressed: state is CreatingOtpLoadingState
                            ? () {}
                            : () {
                                _formKey.currentState!.save();
                                if (_formKey.currentState!.validate()) {
                                  context
                                      .read<AuthBloc>()
                                      .add(CreateTgOtpEvent());
                                }
                              },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: ColorConstant.primaryColor,
                            elevation: 0,
                            padding: EdgeInsets.symmetric(
                                horizontal: 24, vertical: 18)),
                        child: state is CreatingOtpLoadingState
                            ? loading
                            : Text(
                                "Verify username",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(
                                        color: Colors.white,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w700),
                              )),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
