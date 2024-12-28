import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:minapp/features/host/features/properties/presentation/bloc/add_property/add_property_bloc.dart';
import 'package:minapp/features/host/features/properties/presentation/widgets/property_photo_card.dart';
import '../../../../../../config/color/color.dart';
import '../../../../../../core/common/amenitie_type_card.dart';
import '../../../../../../core/common/back_button.dart';
import '../../../../../../core/common/custom_button.dart';
import '../../../../../../core/common/house_type_card.dart';
import '../../../../../../core/common/upload_photo_widget.dart';
import '../../../../../../core/common/custom_text_field.dart';

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
        body: BlocConsumer<AddPropertyBloc, AddPropertyState>(
          builder: (context, state) {
            return Column(
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
                        spacing: 15,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          stepTitleText(
                              context, 'What type of house do you host?'),
                          Expanded(
                              child: GridView.builder(
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 2,
                                          mainAxisExtent: 100),
                                  itemCount: 12,
                                  itemBuilder: (context, index) =>
                                      HouseTypeCard(
                                        iconData: Icons.house,
                                        title: "Private Rooms",
                                      )))
                        ],
                      ),
                    ),
                    // step 2
                    Container(
                      padding: EdgeInsets.all(15),
                      child: Column(
                        spacing: 15,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          stepTitleText(context, 'About the house'),
                          stepSutTitle(context, "Registered House name?", true),
                          CustomTextField(
                            hintText: "eg Diamond Guest House",
                            surfixIcon: null,
                            textInputType: TextInputType.text,
                            isMultiLine: false,
                            onTextChnage: (value) {},
                          ),
                          stepSutTitle(
                              context, "Description of the house", true),
                          CustomTextField(
                            hintText: "eg Diamond Guest House",
                            surfixIcon: null,
                            isMultiLine: false,
                            textInputType: TextInputType.multiline,
                            onTextChnage: (value) {},
                          ),
                        ],
                      ),
                    ),
                    // step 3
                    Container(
                      padding: EdgeInsets.all(15),
                      child: Column(
                        spacing: 15,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          stepTitleText(context, 'Add Amenities '),
                          Expanded(
                              child: GridView.builder(
                                  padding: EdgeInsets.all(10),
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 2,
                                          crossAxisSpacing: 10,
                                          mainAxisExtent: 100),
                                  itemCount: 12,
                                  itemBuilder: (context, index) =>
                                      AmenitieTypeCard(
                                        iconData: Icons.local_laundry_service_outlined,
                                        title: "Air Condition",

                                      )))
                        ],
                      ),
                    ),
                    // step 4
                    Container(
                      padding: EdgeInsets.all(15),
                      child: SingleChildScrollView(
                        child: Column(
                          spacing: 15,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            stepTitleText(context, "Location"),
                            Stack(children: [
                              Placeholder(
                                fallbackHeight: 340,
                              ),
                              Positioned(
                                bottom: 4,
                                left:
                                    MediaQuery.of(context).size.width / 2 - 100,
                                right:
                                    MediaQuery.of(context).size.width / 2 - 100,
                                child: CustomButton(
                                    onPressed: () {},
                                    style: ElevatedButton.styleFrom(
                                      elevation: 0,
                                      backgroundColor:
                                          ColorConstant.primaryColor,
                                      padding: EdgeInsets.all(1),
                                    ),
                                    child: Text(
                                      "use current location",
                                      style: TextStyle(color: Colors.white),
                                    )),
                              )
                            ]),
                            stepSutTitle(context,
                                "Know or address  name of the place", true),
                            CustomTextField(
                              hintText: "eg bole ",
                              surfixIcon: null,
                              isMultiLine: false,
                              textInputType: TextInputType.text,
                              onTextChnage: (value) {},
                            ),
                            stepSutTitle(context,
                                "Please select the name of the city", true),
                            CustomTextField(
                              hintText: "eg Addis Ababa",
                              textInputType: TextInputType.text,
                              surfixIcon: Icon(Icons.arrow_drop_down),
                              isMultiLine: false,
                              onTextChnage: (value) {},
                            ),
                          ],
                        ),
                      ),
                    ),
                    // step 5
                    Container(
                      padding: EdgeInsets.all(15),
                      child: Column(
                        spacing: 15,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          stepTitleText(context, "Price"),
                          stepSutTitle(
                              context,
                              "How many rooms do you have with the same price?",
                              true),
                          CustomTextField(
                            hintText: "eg 4",
                            surfixIcon: null,
                            isMultiLine: false,
                            textInputType:
                                TextInputType.numberWithOptions(decimal: true),
                            onTextChnage: (value) {},
                          ),
                          stepSutTitle(context, 'Enter the price', true),
                          CustomTextField(
                            hintText: "500",
                            surfixIcon: null,
                            isMultiLine: false,
                            textInputType: TextInputType.number,
                            onTextChnage: (value) {},
                          ),
                        ],
                      ),
                    ),
                    // step 6
                    Container(
                      padding: EdgeInsets.all(15),
                      child: Column(
                        spacing: 15,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          stepTitleText(context, "Add Photos of the house"),
                          UploadPhoto(
                            ontTap: () {},
                          ),
                          Expanded(
                              child: ListView.builder(
                            itemCount: 4,
                            itemBuilder: (context, index) => Card(
                                elevation: 0.2,
                                color: Colors.white,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    side: BorderSide(
                                        color: ColorConstant.cardGrey)),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: PropertyPhotoCard(),
                                )),
                          ))
                        ],
                      ),
                    ),
                    //step 7
                    Container(
                      padding: EdgeInsets.all(15),
                      child: Column(
                        spacing: 15,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          stepTitleText(context, "Agent Info"),
                          stepSutTitle(
                              context,
                              "Enter agent id if you don’t have click finish(optional)",
                              false),
                          CustomTextField(
                            hintText: "agent id",
                            surfixIcon: null,
                            isMultiLine: false,
                            textInputType: TextInputType.number,
                            onTextChnage: (value) {},
                          ),
                        ],
                      ),
                    )
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
                                onPressed: () {
                                  if (state.step != 0) {
                                    context
                                        .read<AddPropertyBloc>()
                                        .add(BackStepEvent());
                                  } else {
                                    context.goNamed('properties');
                                  }
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
                                  if (state.step == 6) {
                                    context.goNamed('properties');
                                  } else {
                                    context
                                        .read<AddPropertyBloc>()
                                        .add(NextStepEvent());
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                    side: BorderSide(
                                        color: ColorConstant.primaryColor),
                                    backgroundColor:
                                        ColorConstant.primaryColor),
                                child: Text(state.step != 6 ? "Next" : "Finish",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(
                                          color: Colors.white,
                                        ))))
                      ],
                    ))
              ],
            );
          },
          buildWhen: (previous, current) => previous != current,
          listenWhen: (previous, current) => previous.step != current.step,
          listener: (context, state) {
            pageController.jumpToPage(state.step);
          },
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

  Text stepTitleText(BuildContext context, String title) {
    return Text(
      title,
      style: Theme.of(context)
          .textTheme
          .bodyLarge!
          .copyWith(fontWeight: FontWeight.bold),
    );
  }
}
