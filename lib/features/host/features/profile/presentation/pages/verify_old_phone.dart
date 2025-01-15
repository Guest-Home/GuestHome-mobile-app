
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pinput/pinput.dart';

import '../../../../../../config/color/color.dart';
import '../../../../../../core/common/back_button.dart';
import '../../../../../../core/common/country_code_selector.dart';
import '../../../../../../core/common/custom_button.dart';
import '../../../../../../core/common/custom_text_field.dart';
import '../../../../../../core/utils/validator.dart';

class VerifyOldPhone extends StatelessWidget {
   VerifyOldPhone({super.key});


  final PageController _pageController=PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: AppBarBackButton(),
        title: Text(
          'Phone number change',
          style: Theme.of(context)
              .textTheme
              .bodyLarge!
              .copyWith(fontWeight: FontWeight.bold),
        ),
      ),
      body:Padding(
        padding: EdgeInsets.all(16),
        child: PageView(
          controller: _pageController,
          physics: NeverScrollableScrollPhysics(),
          children: [
            // old otp
            SingleChildScrollView(
              child: Column(
                spacing: 16,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Verifying old phone number",
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
                            text:
                            'Before changing phone number  we need to verify you old phone number.  Please enter the one time password sent to your mobile number ',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                fontSize: 14,
                                fontWeight: FontWeight.w400),
                          ),
                          TextSpan(
                              text: "0000",
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
                        // context
                        //     .read<AuthBloc>()
                        //     .add(AddOtpCodeEvent(otpCode: pin));
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
                          _pageController.jumpToPage(1);
                          // context
                          //     .read<AuthBloc>()
                          //     .add(VerifyOtpEvent());
                        },
                        style: ElevatedButton.styleFrom(
                            elevation: 0,
                            backgroundColor: ColorConstant.primaryColor,
                            padding: EdgeInsets.symmetric(
                                horizontal: 24, vertical: 18)),
                        child: Text(
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
          // new number
            SingleChildScrollView(
              child: Column(
                spacing: 16,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Enter new phone number",
                    style: Theme.of(context)
                        .textTheme
                        .headlineMedium!
                        .copyWith(fontWeight: FontWeight.w700,fontSize: 18),
                  ),
                  SizedBox(height:3,),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 3,),
                    child: RichText(
                        textAlign: TextAlign.start,
                        text: TextSpan(children: [
                          TextSpan(
                            text:'Phone Number',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                fontSize: 14,
                                fontWeight: FontWeight.w400),
                          ),
                          TextSpan(
                              text: "",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(fontWeight: FontWeight.w700))
                        ])),
                  ),
                  CustomTextField(
                      hintText: "987654321",
                      surfixIcon: null,
                      validator: (value) {
                        if (value!.isEmpty &&
                            !Validation.phoneNumberValidation(value)) {
                          return "please provide valid phone number";
                        }
                        return null;
                      },
                      prifixIcon: CountryCodeSelector(
                        onInit: (value) {},
                        onChange: (value) {},
                      ),
                      onTextChnage: (value) {},
                      isMultiLine: false,
                      textInputType: TextInputType.phone),
                  Container(
                    margin: EdgeInsets.only(top: 30),
                    width: MediaQuery.of(context).size.width,
                    child: CustomButton(
                        onPressed:() {
                          context.goNamed('guestVerifyNewPhone');
                          if(GoRouter.of(context).routerDelegate.state!.name=='guestVerifyOldPhone'){
                            context.goNamed('guestVerifyNewPhone');
                          }else{
                            context.goNamed('verifyNewPhone');
                          }
                          // context
                          //     .read<AuthBloc>()
                          //     .add(VerifyOtpEvent());
                        },
                        style: ElevatedButton.styleFrom(
                            elevation: 0,
                            backgroundColor: ColorConstant.primaryColor,
                            padding: EdgeInsets.symmetric(
                                horizontal: 24, vertical: 18)),
                        child: Text(
                          "Next",
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
          ],
        )

      )
    );
  }
}
