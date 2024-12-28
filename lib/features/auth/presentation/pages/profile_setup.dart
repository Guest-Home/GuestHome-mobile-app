import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:minapp/core/common/upload_photo_widget.dart';
import 'package:minapp/core/common/custom_text_field.dart';

import '../../../../config/color/color.dart';
import '../../../../core/common/back_button.dart';
import '../../../../core/common/custom_button.dart';
import '../../../host/features/properties/presentation/widgets/property_photo_card.dart';

class ProfileSetup extends StatelessWidget {
  const ProfileSetup({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: AppBarBackButton(),
        ),
        body: Container(
          padding: EdgeInsets.all(15),
          child: Column(
            children: [
              Expanded(
                child: ListView(
                  children: [
                    Text(
                      "Profile SetUp",
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge!
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height:20,),
                    stepSutTitle(context, "Full Name", true),
                    SizedBox(height:10,),
                    CustomTextField(
                        hintText: "full name",
                        surfixIcon: null,
                        onTextChnage: (value) {},
                        isMultiLine: false,
                        textInputType: TextInputType.text),
                    SizedBox(height:10,),
                    stepSutTitle(context, "Gender", true),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: List.generate(
                        2,
                        (index) => Expanded(
                          child: Card(
                            color: Colors.white,
                            elevation: 0,
                            shape: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                    color: ColorConstant.cardGrey
                                        .withValues(alpha: 0.9))),
                            child: SizedBox(
                              width: 100,
                              child: RadioListTile.adaptive(
                                selectedTileColor: ColorConstant.primaryColor,
                                title: Row(
                                  spacing: 10,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    index==0?Image.asset('assets/icons/woman.png',width: 15,):
                                    Image.asset('assets/icons/man.png',width: 15,),
                                    Text("Male",style: Theme.of(context).textTheme.bodySmall,),
                                  ],
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
                        ),
                      ),
                    ),
                    SizedBox(height:10,),
                    UploadPhoto(
                      ontTap: () {},
                    ),
                    SizedBox(height:10,),
                    Card(
                        elevation: 0.2,
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                            side: BorderSide(color: ColorConstant.cardGrey)),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: PropertyPhotoCard(),
                        )),
                  ],
                ),
              ),
              Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.all(15),
                  child: Row(
                    spacing: 10,
                    children: [
                      Expanded(
                          child: CustomButton(
                              onPressed: () {
                                context.pop();
                              },
                              style: ElevatedButton.styleFrom(
                                  side: BorderSide(
                                      color: ColorConstant.secondBtnColor),
                                  backgroundColor: Colors.white),
                              child: Text("Back",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(
                                        color: ColorConstant.secondBtnColor,
                                      )))),
                      Expanded(
                          child: CustomButton(
                              onPressed: () async {
                                //  context.goNamed("properties");
                                context.goNamed('houseType');
                              },
                              style: ElevatedButton.styleFrom(
                                  side: BorderSide(
                                      color: ColorConstant.primaryColor),
                                  backgroundColor: ColorConstant.primaryColor),
                              child: Text("Finish",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(
                                        color: Colors.white,
                                      ))))
                    ],
                  ))
            ],
          ),
        ));
  }

  RichText stepSutTitle(BuildContext context, String title, bool isRequired) {
    return RichText(
        text: TextSpan(children: [
      TextSpan(
          text: title,
          style: Theme.of(context)
              .textTheme
              .bodySmall!
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
