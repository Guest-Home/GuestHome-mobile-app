import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:minapp/config/color/color.dart';
import 'package:minapp/core/common/back_button.dart';
import 'package:minapp/core/common/custom_button.dart';
import 'package:minapp/features/host/features/properties/presentation/widgets/custom_text_field.dart';

import '../../../../../../core/common/country_code_selector.dart';

class AccountSetup extends StatefulWidget {
  const AccountSetup({super.key});

  @override
  State<AccountSetup> createState() => _AccountSetupState();
}

class _AccountSetupState extends State<AccountSetup> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: AppBarBackButton(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
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
                hintText: "098667236",
                surfixIcon: null,
                onTextChnage: (value) {},
                isMultiLine: false,
                prifixIcon: CountryCodeSelector(
                  onChange: (value) => print(value.code),
                ),
                textInputType: TextInputType.phone),
            Container(
              margin: EdgeInsets.only(top: 30),
              width: MediaQuery.of(context).size.width,
              child: CustomButton(
                  onPressed: () {
                    context.goNamed('otpVerification');
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: ColorConstant.primaryColor,
                      padding: EdgeInsets.all(15)),
                  child: Text(
                    "Verify Phone Number",
                    style: TextStyle(color: Colors.white),
                  )),
            )
          ],
        ),
      ),
    );
  }
}
