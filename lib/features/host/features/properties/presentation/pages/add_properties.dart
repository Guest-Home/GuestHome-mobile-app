import 'package:flutter/material.dart';
import '../../../../../../config/color/color.dart';
import '../../../../../../core/common/back_button.dart';
import '../../../../../../core/common/custom_button.dart';

class AddProperties extends StatefulWidget {
  const AddProperties({super.key});

  @override
  State<AddProperties> createState() => _AddPropertiesState();
}

class _AddPropertiesState extends State<AddProperties> {
  PageController pageController = PageController(initialPage: 0);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leadingWidth: 27,
          leading: AppBarBackButton(
            route: "properties",
          ),
        ),
        body: Column(
          children: [
            Expanded(
                child: PageView(
              controller: pageController,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                //step1
                Container(
                  padding: EdgeInsets.all(15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "What type of house do you host?",
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge!
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                      Expanded(
                          child: GridView.builder(
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2, mainAxisExtent: 100),
                              itemCount: 12,
                              itemBuilder: (context, index) => Card(
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        side: BorderSide(
                                            color: index == 0
                                                ? ColorConstant.primaryColor
                                                : ColorConstant.cardGrey)),
                                    elevation: 0,
                                    color: ColorConstant.cardGrey
                                        .withValues(alpha: 0.7),
                                    child: Container(
                                      width: 150,
                                      padding: const EdgeInsets.all(10),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.house,
                                            color: ColorConstant.primaryColor,
                                          ),
                                          Text(
                                            "Private Rooms",
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyMedium!
                                                .copyWith(
                                                    color: ColorConstant
                                                        .secondBtnColor),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )))
                    ],
                  ),
                ),
                // step 2
              ],
            )),
            Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.all(15),
                child: Row(
                  spacing: 10,
                  children: [
                    Expanded(
                        child: CustomButton(
                            onPressed: () {},
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
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                                side: BorderSide(
                                    color: ColorConstant.primaryColor),
                                backgroundColor: ColorConstant.primaryColor),
                            child: Text("Next",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(
                                      color: Colors.white,
                                    ))))
                  ],
                ))
          ],
        ));
  }
}
