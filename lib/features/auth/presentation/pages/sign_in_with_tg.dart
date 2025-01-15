import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../config/color/color.dart';
import '../../../../core/common/back_button.dart';
import '../../../../core/common/custom_button.dart';
import '../../../../core/common/custom_text_field.dart';
import '../../../../core/utils/validator.dart';

class SignInWithTg extends StatelessWidget {
   SignInWithTg({super.key});


  final TextEditingController tgUserController=TextEditingController();
  final _formKey=GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: AppBarBackButton(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          spacing:27,
          children: [
            Text(
              "Sign with telegram",
              style: Theme.of(context)
                  .textTheme
                  .headlineSmall!
                  .copyWith(fontWeight: FontWeight.w700,fontSize: 20),
            ),
            SizedBox(
              child:Form(
                key: _formKey,
                child:
              Column(
                spacing: 10,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(text: TextSpan(
                      children: [
                        TextSpan(
                            text: "Telegram username",
                            style: Theme.of(context).textTheme.bodySmall!.copyWith(fontWeight: FontWeight.w500)
                        ),
                        TextSpan(text: "*",style: TextStyle(color: ColorConstant.red))
                      ]
                  )),
                  CustomTextField(
                    textEditingController: tgUserController,
                      hintText: "eg @UserName",
                      surfixIcon: Icon(Icons.telegram),
                      validator: (value) {
                        if (!Validation.tgUserName(value!)) {
                          return 'Please enter a valid TG userName';
                        }
                        return null;
                      },
                      onTextChnage: (value) {
                        // context.read<AuthBloc>().add(AddPhoneNumberEvent(phoneNumber: value));
                      },
                      isMultiLine: false,
                      textInputType: TextInputType.phone),
                ],
              ),)
            ),
            Container(
              margin: EdgeInsets.only(top:10),
              width: MediaQuery.of(context).size.width,
              child: CustomButton(
                  onPressed:(){
                    _formKey.currentState!.save();
                    if(_formKey.currentState!.validate()){

                    }
                    context.goNamed('tgOtpVerification');
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: ColorConstant.primaryColor,
                      elevation: 0,
                      padding: EdgeInsets.symmetric(
                          horizontal: 24, vertical: 18)),
                  child:Text(
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
  }
}
