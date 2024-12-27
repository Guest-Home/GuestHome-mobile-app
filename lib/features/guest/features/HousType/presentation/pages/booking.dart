import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:minapp/core/common/custom_text_field.dart';
import 'package:minapp/features/guest/features/HousType/presentation/widgets/section_header_text.dart';

import '../../../../../../config/color/color.dart';
import '../../../../../../core/common/country_code_selector.dart';
import '../../../../../../core/common/custom_button.dart';

class Booking extends StatelessWidget {
  const Booking({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Expanded(
              child: ListView(
            padding: EdgeInsets.all(15),
            children: [
              SecctionHeader(title: "Booking", isSeeMore: false),
              Text("Fill out the information below and confirm your booking. "),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: stepSutTitle(context, "First Name", true),
              ),
              CustomTextField(
                  hintText: "first name",
                  surfixIcon: null,
                  onTextChnage: (value) {},
                  isMultiLine: false,
                  textInputType: TextInputType.text),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: stepSutTitle(context, "Last Name", true),
              ),
              CustomTextField(
                  hintText: "last name",
                  surfixIcon: null,
                  onTextChnage: (value) {},
                  isMultiLine: false,
                  textInputType: TextInputType.text),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: stepSutTitle(context, "Phone Number", true),
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
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: SizedBox(
                  height: 100,
                  child: Row(
                    spacing: 15,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          spacing: 10,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            stepSutTitle(context, "CheckIn", true),
                            CustomTextField(
                                hintText: DateTime.now().month.toString(),
                                surfixIcon: GestureDetector(
                                    onTap: () => showDatePicker(
                                        context: context,
                                        barrierColor: Colors.white,
                                        firstDate: DateTime.now(),
                                        lastDate: DateTime(2060)),
                                    child: Icon(
                                      Icons.calendar_month,
                                      color: ColorConstant.secondBtnColor,
                                    )),
                                onTextChnage: (value) {},
                                isMultiLine: false,
                                textInputType: TextInputType.text),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          spacing: 10,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            stepSutTitle(context, "CheckOut", true),
                            CustomTextField(
                                hintText: DateTime.now().month.toString(),
                                surfixIcon: GestureDetector(
                                    onTap: () => showDatePicker(
                                        context: context,
                                        barrierColor: Colors.white,
                                        firstDate: DateTime.now(),
                                        lastDate: DateTime(2060)),
                                    child: Icon(
                                      Icons.calendar_month,
                                      color: ColorConstant.secondBtnColor,
                                    )),
                                onTextChnage: (value) {},
                                isMultiLine: false,
                                textInputType: TextInputType.text),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: stepSutTitle(context, "Select ID type you have", true),
              ),
              GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, mainAxisExtent: 80),
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: 4,
                itemBuilder: (context, index) => Card(
                  color: Colors.white,
                  elevation: 0,
                  shape: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide:
                          BorderSide(color: ColorConstant.primaryColor)),
                  child: RadioListTile.adaptive(
                    selectedTileColor: ColorConstant.primaryColor,
                    title: Text(
                      "Passport",
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    useCupertinoCheckmarkStyle: true,
                    shape: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                    value: true,
                    groupValue: true,
                    onChanged: (value) {},
                  ),
                ),
              ),
            ],
          )),
          Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.all(15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              spacing: 15,
              children: [
                Expanded(
                    child: CustomButton(
                        onPressed: () {
                          context.pop();
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            padding: EdgeInsets.all(20),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                                side: BorderSide(
                                    color: ColorConstant.secondBtnColor))),
                        child: Text(
                          "Cancel",
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(
                                  color: ColorConstant.secondBtnColor,
                                  fontWeight: FontWeight.w600),
                        ))),
                Expanded(
                    child: CustomButton(
                        onPressed: () {
                          showBookedDialog(context);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: ColorConstant.primaryColor,
                          padding: EdgeInsets.all(20),
                        ),
                        child: Text(
                          "Confirm Booking",
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600),
                        )))
              ],
            ),
          )
        ],
      ),
    );
  }

  Future<dynamic> showBookedDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
          backgroundColor: Colors.white,
          title: Text(
            "Book pending...",
            style: Theme.of(context)
                .textTheme
                .headlineSmall!
                .copyWith(fontWeight: FontWeight.bold),
          ),
          icon: SvgPicture.asset(
            'assets/icons/congrates.svg',
            semanticsLabel: 'language',
            fit: BoxFit.cover,
          ),
          content: SizedBox(
            height: 150,
            child: Column(
              spacing: 10,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "You will get a call in a minute from the host or check booked menu for more information.",
                  textAlign: TextAlign.center,
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  child: CustomButton(
                      onPressed: () {
                        context.goNamed('booked');
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: ColorConstant.primaryColor,
                          padding: EdgeInsets.all(15)),
                      child: Text(
                        "Done",
                        style: TextStyle(color: Colors.white),
                      )),
                )
              ],
            ),
          )),
    );
  }

  RichText stepSutTitle(BuildContext context, String title, bool isRequired) {
    return RichText(
        text: TextSpan(children: [
      TextSpan(
          text: title,
          style: Theme.of(context)
              .textTheme
              .bodyMedium!
              .copyWith(fontWeight: FontWeight.bold)),
      TextSpan(
          text: isRequired ? "*" : '(optional)',
          style: TextStyle(
              color: isRequired
                  ? ColorConstant.red
                  : ColorConstant.cardGrey.withValues(alpha: 0.5)))
    ]));
  }
}
