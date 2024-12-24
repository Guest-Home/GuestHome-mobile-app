import 'package:flutter/material.dart';
import 'package:minapp/core/common/back_button.dart';
import 'package:minapp/features/host/features/properties/presentation/pages/listed_property_detail.dart';
import '../../../../../../config/color/color.dart';
import '../../../../../../core/common/custom_button.dart';

class GeneralInformation extends StatelessWidget {
  const GeneralInformation({super.key});

  Text subSectionText(String title) => Text(title);

  Text sectionTitle(BuildContext context, String title) {
    return Text(title,
        style: Theme.of(context)
            .textTheme
            .bodyLarge!
            .copyWith(color: ColorConstant.secondBtnColor));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 27,
        automaticallyImplyLeading: false,
        leading: AppBarBackButton(),
        title: Text(
          'Profile Setting',
          style: Theme.of(context)
              .textTheme
              .bodyLarge!
              .copyWith(fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          spacing: 15,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            sectionTitle(context, "Profile Image"),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CircleAvatar(
                  radius: 50,
                ),
                Expanded(
                  child: Column(
                    spacing: 10,
                    children: [
                      SizedBox(
                        width: 200,
                        child: CustomButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                                elevation: 0,
                                padding: EdgeInsets.all(1),
                                side: BorderSide(
                                    color: ColorConstant.primaryColor),
                                backgroundColor: ColorConstant.primaryColor),
                            child: Text("Upload",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall!
                                    .copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ))),
                      ),
                      SizedBox(
                        width: 200,
                        child: CustomButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                                padding: EdgeInsets.all(1),
                                elevation: 0,
                                side: BorderSide(color: Colors.white),
                                backgroundColor: ColorConstant.cardGrey),
                            child: Text("Remove",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall!
                                    .copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: ColorConstant.primaryColor,
                                    ))),
                      )
                    ],
                  ),
                )
              ],
            ),
            Divider(
              thickness: 0.5,
            ),
            subSectionText("Full Name"),
            PropertyTextField(hintText: "amanuel D", surfixIcon: null),
            subSectionText("Phone number"),
            PropertyTextField(
                hintText: "09876654231", surfixIcon: Icon(Icons.phone)),
            Container(
              margin: EdgeInsets.only(top: 20),
              width: MediaQuery.of(context).size.width,
              child: CustomButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                      elevation: 0,
                      padding: EdgeInsets.all(21),
                      side: BorderSide(color: ColorConstant.primaryColor),
                      backgroundColor: ColorConstant.primaryColor),
                  child: Text("Save Setting",
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ))),
            )
          ],
        ),
      ),
    );
  }
}
