import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:minapp/config/color/color.dart';
import 'package:minapp/core/common/custom_button.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
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
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                spacing: 10,
                children: [
                  CircleAvatar(
                    radius: 45,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Amanuel D",
                        style: Theme.of(context)
                            .textTheme
                            .headlineSmall!
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "098776542",
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall!
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "Host",
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall!
                            .copyWith(color: ColorConstant.secondBtnColor),
                      )
                    ],
                  )
                ],
              ),
              Container(
                  width: MediaQuery.of(context).size.width,
                  margin:
                      EdgeInsets.only(left: 30, right: 30, bottom: 10, top: 20),
                  child: CustomButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                          side: BorderSide(color: ColorConstant.secondBtnColor),
                          backgroundColor: ColorConstant.secondBtnColor),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        spacing: 5,
                        children: [
                          Icon(
                            Icons.recycling,
                            color: Colors.white,
                          ),
                          Text("Switch to Guest",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(
                                    color: Colors.white,
                                  ))
                        ],
                      ))),
              Text("Setting",
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      color: ColorConstant.secondBtnColor,
                      fontWeight: FontWeight.bold)),
              ListTile(
                onTap: () => context.goNamed('generalInformation'),
                leading: Icon(Icons.person_2_outlined),
                title: Text(
                  "General Information",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                trailing: Icon(Icons.arrow_right_alt_outlined),
              ),
              ListTile(
                onTap: () => context.goNamed("language"),
                leading: Icon(Icons.language_outlined),
                title: Text(
                  "Language/English",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                trailing: Icon(Icons.arrow_right_alt_outlined),
              ),
              ListTile(
                onTap: () => context.goNamed("account"),
                leading: Icon(Icons.menu_sharp),
                title: Text(
                  "Account",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                trailing: Icon(Icons.arrow_right_alt_outlined),
              )
            ],
          ),
        ));
  }
}
