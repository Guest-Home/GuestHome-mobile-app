import 'package:easy_localization/easy_localization.dart';
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

              // based on the user display either card or container
              if(GoRouter.of(context).state!.topRoute!.name=='guestProfile')
              Card(
                color: Colors.white,
                elevation: 3,
                shadowColor: ColorConstant.cardGrey,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                  side: BorderSide(color: ColorConstant.cardGrey,),

                ),
                child:
                Container(
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 10,
                    children: [
                      Text(tr("Become a Host"),style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.bold),),
                      Text(tr("Join our community of hosts and start welcoming guests today"),style: Theme.of(context).textTheme.bodySmall,),
                     Container(
                        margin: EdgeInsets.symmetric(vertical: 10),
                       child: CustomButton(
                         onPressed: () {
                           context.goNamed('properties');

                         },
                           style: ElevatedButton.styleFrom(
                             padding: EdgeInsets.symmetric(horizontal:40,vertical: 15),
                             backgroundColor: ColorConstant.primaryColor
                           ), child:Text(tr('Become a Host'),style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Colors.white),)),
                     )
                    ],
                  ),
                ),
              ),
              //switch to guest button
              if(GoRouter.of(context).state!.topRoute!.name!='guestProfile')
              Container(
                  width: MediaQuery.of(context).size.width,
                  margin:
                      EdgeInsets.only(left: 30, right: 30, bottom: 10, top: 20),
                  child: CustomButton(
                      onPressed: () {
                        context.goNamed('houseType');
                      },
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
              Text(tr('Settings'),
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      color: ColorConstant.secondBtnColor,
                      fontWeight: FontWeight.bold)),
              ListTile(
                onTap: () => context.pushNamed('generalInformation'),
                leading: Image.asset("assets/icons/user.png"),
                title: Text(
                  "General Information",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                trailing: Icon(Icons.arrow_right_alt_outlined),
              ),
              ListTile(
                onTap: () => context.pushNamed("language"),
                leading: Image.asset("assets/icons/lang.png"),
                title: Text(tr(
                  "language"),
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                trailing: Icon(Icons.arrow_right_alt_outlined),
              ),
              ListTile(
                onTap: () => context.pushNamed("account"),
                leading:Image.asset("assets/icons/account.png"),
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
