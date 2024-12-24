import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:minapp/config/color/color.dart';
import 'package:minapp/core/common/back_button.dart';
import 'package:minapp/core/common/custom_button.dart';

import '../widgets/house_type_card.dart';
import '../widgets/property_photo_card.dart';

class ListedPropertyDetail extends StatefulWidget {
  const ListedPropertyDetail({super.key});

  @override
  State<ListedPropertyDetail> createState() => _ListedPropertyDetailState();
}

class _ListedPropertyDetailState extends State<ListedPropertyDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 27,
        title: Text(
          "Listed Property",
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        leading: AppBarBackButton(
          route: "properties",
        ),
        scrolledUnderElevation: 0,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(10),
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    PopupMenuButton(
                      color: Colors.white,
                      child: Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                                color: ColorConstant.secondBtnColor)),
                        child: Row(
                          children: [
                            Text(
                              "Menu",
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                            Icon(Icons.arrow_drop_down_sharp)
                          ],
                        ),
                      ),
                      itemBuilder: (context) => [
                        PopupMenuItem(
                          value: 'delete',
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Icon(
                                Icons.delete,
                                color: ColorConstant.red,
                                size: 18,
                              ),
                              Text(
                                "Delete house",
                                style: TextStyle(color: ColorConstant.red),
                              ),
                            ],
                          ),
                        )
                      ],
                      onSelected: (value) {
                        if (value == 'delete') {
                          _showDeleteDialog(context);
                        }
                      },
                    )
                  ],
                ),
                // typeof house
                Card(
                  elevation: 0.2,
                  color: Colors.white,
                  margin: EdgeInsets.only(top: 10),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: BorderSide(color: ColorConstant.cardGrey)),
                  child: ListTile(
                    title: sectionTitle(
                        context, 'What type of house do you host?'),
                    subtitle: Padding(
                      padding: const EdgeInsets.only(top: 14),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        spacing: 60,
                        children: [
                          Expanded(
                              child: HouseTypeCard(
                            iconData: Icons.other_houses_outlined,
                            title: 'private house',
                            isSelected: true,
                          )),
                          GestureDetector(
                            onTap: () {
                              _showHouseTypeDialog(context);
                            },
                            child: SizedBox(
                              child: Row(
                                spacing: 4,
                                children: [
                                  Icon(
                                    Icons.change_circle_outlined,
                                    color: ColorConstant.primaryColor,
                                  ),
                                  Text("Change Type",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium!
                                          .copyWith(
                                              color:
                                                  ColorConstant.primaryColor))
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                // about the house
                Card(
                    elevation: 0.2,
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                        side: BorderSide(color: ColorConstant.cardGrey)),
                    child: ListTile(
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          sectionTitle(context, 'About the house'),
                          Text(
                            "edit",
                            style:
                                TextStyle(decoration: TextDecoration.underline),
                          ),
                        ],
                      ),
                      subtitle: Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: 10,
                          children: [
                            subSectionText('Registered House name?'),
                            PropertyTextField(
                              hintText: 'MK GUEST HOME',
                              surfixIcon: null,
                            ),
                            subSectionText("Description of the house"),
                            PropertyTextField(
                                surfixIcon: null,
                                hintText:
                                    'Lorem ipsum dolor sit amet consectetur. At justo nec in nunc accumsan in turpis nunc posuere. Risus eget volutpat consectetur vestibulum habitant ut proin enim proin. Cras laoreet venenatis phasellus imperdiet ipsum arcu nullam facilisi. Dui volutpat sapien elementum ipsum bibendum eget rhoncus.'),
                          ],
                        ),
                      ),
                    )),
                // House Amenities
                Card(
                  elevation: 0.2,
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: BorderSide(color: ColorConstant.cardGrey)),
                  child: ListTile(
                    title: sectionTitle(context, "House Amenities"),
                    subtitle: SizedBox(
                      height: 250,
                      child: GridView.builder(
                        padding: EdgeInsets.all(10),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            childAspectRatio: 1,
                            crossAxisSpacing: 2,
                            mainAxisSpacing: 4,
                            mainAxisExtent: 50),
                        itemCount: 12,
                        itemBuilder: (context, index) {
                          return HouseTypeCard(
                            iconData: Icons.wifi,
                            title: 'wifi',
                            isSelected: index.isEven ? true : false,
                          ); // Replace with your actual card widget
                        },
                      ),
                    ),
                  ),
                ),

                //location
                Card(
                    elevation: 0.2,
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                        side: BorderSide(color: ColorConstant.cardGrey)),
                    child: ListTile(
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          sectionTitle(context, 'Location'),
                          Text(
                            "edit",
                            style:
                                TextStyle(decoration: TextDecoration.underline),
                          ),
                        ],
                      ),
                      subtitle: Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: 10,
                          children: [
                            subSectionText('House Location'),
                            PropertyTextField(
                              hintText: 'Google map location name',
                              surfixIcon: null,
                            ),
                            Align(
                              alignment: Alignment.bottomRight,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Icon(
                                    Icons.location_pin,
                                    color: ColorConstant.secondBtnColor,
                                  ),
                                  Text(
                                    'Change House Location',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(
                                            color: ColorConstant.primaryColor),
                                  ),
                                ],
                              ),
                            ),
                            subSectionText(
                                "Know or address  name of the place"),
                            PropertyTextField(
                              hintText: 'Ayat Behind somewhere',
                              surfixIcon: null,
                            ),
                            subSectionText("Name of the city"),
                            PropertyTextField(
                                hintText: "Addis Ababa",
                                surfixIcon: Icon(Icons.keyboard_arrow_down))
                          ],
                        ),
                      ),
                    )),

                Card(
                    elevation: 0.2,
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                        side: BorderSide(color: ColorConstant.cardGrey)),
                    child: ListTile(
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          sectionTitle(context, 'Location'),
                          Text(
                            "edit",
                            style:
                                TextStyle(decoration: TextDecoration.underline),
                          ),
                        ],
                      ),
                      subtitle: Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: 10,
                          children: [
                            subSectionText(
                                'How many rooms do you have with the same price?'),
                            PropertyTextField(
                              hintText: '10',
                              surfixIcon: null,
                            ),
                            subSectionText("Price"),
                            PropertyTextField(
                              hintText: '200',
                              surfixIcon: null,
                            ),
                          ],
                        ),
                      ),
                    )),
                // photo
                Card(
                    elevation: 0.2,
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                        side: BorderSide(color: ColorConstant.cardGrey)),
                    child: ListTile(
                      title: sectionTitle(context, 'House Photo'),
                      subtitle: Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          spacing: 10,
                          children: [
                            GestureDetector(
                              onTap: () {},
                              child: Container(
                                width: double.infinity,
                                padding: EdgeInsets.all(20),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                        color: ColorConstant.cardGrey)),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Icon(Icons.photo),
                                    RichText(
                                        text: TextSpan(children: [
                                      TextSpan(
                                          text: "Click to upload",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall!
                                              .copyWith(
                                                  color: ColorConstant
                                                      .primaryColor)),
                                      TextSpan(
                                          text: "or drag and drop",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium!
                                              .copyWith(
                                                  color: ColorConstant
                                                      .secondBtnColor))
                                    ])),
                                    Text(
                                      "PNG,JPG or PDF (max 3MB)",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall!
                                          .copyWith(
                                              color: ColorConstant
                                                  .secondBtnColor
                                                  .withValues(alpha: 0.6)),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            //photo
                            SizedBox(
                                width: double.infinity,
                                child: Column(
                                  children: List.generate(
                                      3, (index) => PropertyPhotoCard()),
                                ))
                          ],
                        ),
                      ),
                    )),
              ],
            ),
          ),
          Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.all(17),
              child: Row(
                spacing: 10,
                children: [
                  Expanded(
                      child: CustomButton(
                          onPressed: () {
                            _showDialog(context);
                          },
                          style: ElevatedButton.styleFrom(
                              side: BorderSide(
                                  color: ColorConstant.secondBtnColor),
                              backgroundColor: Colors.white),
                          child: Text("Cancel",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(
                                    color: ColorConstant.secondBtnColor,
                                  )))),
                  Expanded(
                      child: CustomButton(
                          onPressed: () => context.goNamed('properties'),
                          style: ElevatedButton.styleFrom(
                              side:
                                  BorderSide(color: ColorConstant.primaryColor),
                              backgroundColor: ColorConstant.primaryColor),
                          child: Text("Save Changes",
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
    );
  }

  Text subSectionText(String title) => Text(title);

  Text sectionTitle(BuildContext context, String title) {
    return Text(title,
        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
            color: ColorConstant.secondBtnColor, fontWeight: FontWeight.bold));
  }

  void _showDeleteDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        title: Text(
          "Delete house?",
          style: Theme.of(context)
              .textTheme
              .bodyMedium!
              .copyWith(fontWeight: FontWeight.bold),
        ),
        content: Text("This cant be undone."),
        actionsAlignment: MainAxisAlignment.end,
        actionsPadding: EdgeInsets.all(10),
        actions: [
          CustomButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.all(0.5),
                  side: BorderSide(
                      color:
                          ColorConstant.secondBtnColor.withValues(alpha: 0.5)),
                  backgroundColor: Colors.white),
              child: Text("Cancel",
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: ColorConstant.secondBtnColor,
                      ))),
          CustomButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.only(left: 4, right: 4),
                  backgroundColor: ColorConstant.red),
              child: Text("delete house",
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: Colors.white,
                      )))
        ],
      ),
    );
  }

  void _showHouseTypeDialog(BuildContext context) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => Dialog(
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              child: Container(
                height: MediaQuery.of(context).size.height / 1.7,
                padding: EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 10,
                  children: [
                    Text(
                      "Change House type",
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: ColorConstant.secondBtnColor,
                          fontWeight: FontWeight.bold),
                    ),
                    Expanded(
                      child: GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2, // Number of columns
                            childAspectRatio: 1, // Aspect ratio of each item
                            crossAxisSpacing: 2, // Spacing between columns
                            mainAxisSpacing: 4,
                            mainAxisExtent: 50),
                        itemCount: 10, // Number of HouseTypeCard items
                        itemBuilder: (context, index) {
                          return HouseTypeCard(
                            iconData: Icons.other_houses_outlined,
                            title: 'private house',
                            isSelected: index.isEven ? true : false,
                          ); // Replace with your actual card widget
                        },
                      ),
                    ),
                    Row(
                      spacing: 10,
                      children: [
                        Expanded(
                          child: ElevatedButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              style: ElevatedButton.styleFrom(
                                  side: BorderSide(
                                      color: ColorConstant.secondBtnColor),
                                  backgroundColor: Colors.white),
                              child: Text(
                                "Cancel",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(
                                      color: ColorConstant.secondBtnColor,
                                    ),
                              )),
                        ),
                        Expanded(
                          child: ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: ColorConstant.primaryColor),
                              child: Text(
                                "Select",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(
                                      color: Colors.white,
                                    ),
                              )),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ));
  }

  void _showDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        title: Text(
          "Discard unsaved changes?",
          style: Theme.of(context)
              .textTheme
              .bodyMedium!
              .copyWith(fontWeight: FontWeight.bold),
        ),
        content: Text("This cant be undone."),
        actionsAlignment: MainAxisAlignment.end,
        actionsPadding: EdgeInsets.all(10),
        actions: [
          CustomButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.all(0.5),
                  side: BorderSide(
                      color:
                          ColorConstant.secondBtnColor.withValues(alpha: 0.5)),
                  backgroundColor: Colors.white),
              child: Text("Discard",
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: ColorConstant.secondBtnColor,
                      ))),
          CustomButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.only(left: 4, right: 4),
                  backgroundColor: ColorConstant.primaryColor),
              child: Text("save changes",
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: Colors.white,
                      )))
        ],
      ),
    );
  }
}

class PropertyTextField extends StatelessWidget {
  const PropertyTextField({
    super.key,
    required this.hintText,
    required this.surfixIcon,
  });

  final String hintText;
  final Widget? surfixIcon;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        keyboardType: TextInputType.multiline,
        enabled: false,
        minLines: 1,
        maxLines: null,
        decoration: InputDecoration(
          hintText: hintText,
          suffixIcon: surfixIcon,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: ColorConstant.cardGrey),
          ),
        ));
  }
}
