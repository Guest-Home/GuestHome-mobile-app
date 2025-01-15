import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:minapp/config/color/color.dart';
import 'package:minapp/core/apiConstants/api_url.dart';
import 'package:minapp/core/common/custom_button.dart';
import 'package:minapp/features/host/features/profile/presentation/bloc/profile_bloc.dart';

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
        body: Container(
          padding: EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Column(
              spacing: 15,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: BlocBuilder<ProfileBloc, ProfileState>(
                    builder: (context, state) {
                      if (state is UserProfileLoadingState) {
                        return SizedBox(
                          height: 150,
                          child: Center(child: CupertinoActivityIndicator()),
                        );
                      } else if (state is UserProfileLoadedState) {
                        return Column(
                          spacing: 15,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              spacing: 10,
                              children: [
                                CircleAvatar(
                                  radius: 38,
                                  backgroundColor: ColorConstant.cardGrey,
                                  backgroundImage: CachedNetworkImageProvider(
                                    ApiUrl.baseUrl +
                                        state.userProfileEntity.profilePicture,
                                    headers: {
                                      'Authorization': 'Bearer ${state.token}'
                                    },
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${state.userProfileEntity.userAccount.firstName} "
                                          "${state.userProfileEntity.userAccount.lastName}",
                                      textAlign:TextAlign.start,
                                      overflow:TextOverflow.ellipsis,
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineSmall!
                                          .copyWith(
                                        fontSize: 21,
                                              fontWeight: FontWeight.w700),
                                    ),
                                    Text(
                                      state.userProfileEntity.phoneNumber,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall!
                                          .copyWith(
                                              fontWeight: FontWeight.w600,fontSize: 14),
                                    ),
                                    Text(
                                      state.userProfileEntity.typeOfCustomer,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall!
                                          .copyWith(
                                        fontSize: 14,
                                              fontWeight: FontWeight.w400,
                                              color:
                                                  ColorConstant.secondBtnColor),
                                    )
                                  ],
                                )
                              ],
                            ),
                            // based on the user display either card or container
                            if (GoRouter.of(context).state!.topRoute!.name !=
                                'guestProfile')
                              Card(
                                color: ColorConstant.cardGrey,
                                elevation:0,
                                shadowColor: ColorConstant.cardGrey,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  side: BorderSide(
                                    color: ColorConstant.cardGrey,
                                  ),
                                ),
                                child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  padding: const EdgeInsets.all(15),
                                  child: Row(
                                    mainAxisAlignment:MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        spacing: 10,
                                        children: [
                                          Text(
                                            tr("Amount"),
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyLarge!
                                                .copyWith(fontWeight: FontWeight.w700,fontSize: 14),
                                          ),
                                          Text(
                                            tr("Lorem ipsum dolor sit amet\n consectetur."),
                                            style:
                                            Theme.of(context).textTheme.bodySmall,
                                          ),

                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        spacing:10,
                                        children: [
                                          Text("2344",style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                                            fontWeight: FontWeight.w700,
                                            fontSize: 20,
                                            color: ColorConstant.primaryColor
                                          ),),
                                          Text("ETB",style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                            color: ColorConstant.primaryColor
                                          ),)
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            //switch to guest button
                            Container(
                                width: MediaQuery.of(context).size.width/2,
                                margin: EdgeInsets.only(
                                    left: 10, right: 10, bottom: 15,top: 10),
                                child: CustomButton(
                                    onPressed: () {
                                      if (GoRouter.of(context)
                                              .state!
                                              .topRoute!
                                              .name !=
                                          'guestProfile') {
                                        context.goNamed('houseType');
                                      } else {
                                        context.goNamed('properties');
                                      }
                                    },
                                    style: ElevatedButton.styleFrom(
                                      elevation:10,
                                        side: BorderSide(
                                            color:
                                                ColorConstant.secondBtnColor),
                                        backgroundColor:
                                            ColorConstant.secondBtnColor),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      spacing: 5,
                                      children: [
                                        Icon(
                                          Icons.recycling,
                                          color: Colors.white,
                                        ),
                                        GoRouter.of(context)
                                                    .state!
                                                    .topRoute!
                                                    .name !=
                                                'guestProfile'
                                            ? Text("Switch to Guest",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodySmall!
                                                    .copyWith(
                                                      color: Colors.white,
                                                    ))
                                            : Text("Switch to Host",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodySmall!
                                                    .copyWith(
                                                      color: Colors.white,
                                                    ))
                                      ],
                                    ))),
                          ],
                        );
                      } else if (state is ProfileErrorState) {
                        return SizedBox(
                          child: Text(state.failure.message),
                        );
                      }
                      return SizedBox.shrink();
                    },
                  ),
                ),
                Text(tr('Settings'),
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        color: ColorConstant.secondBtnColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w700)),
                ListTile(
                  onTap: (){
                   if(GoRouter.of(context).routerDelegate.state!.name=='guestProfile'){
                      context.pushNamed('guestGeneralInformation');
                   }else{
                     context.pushNamed('generalInformation');
                   }

                  },
                  leading: Image.asset("assets/icons/user.png"),
                  title: Text(
                    "General Information",
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      fontWeight: FontWeight.w400,
                      fontSize: 14
                    ),
                  ),
                  trailing: Icon(Icons.arrow_forward_ios,size: 17,),
                ),
                ListTile(
                  onTap: (){
                    if(GoRouter.of(context).routerDelegate.state!.name=='guestProfile'){
                      context.pushNamed("guestLanguage");
                    }else{
                      context.pushNamed("language");
                    }

                      },
                  leading: Image.asset("assets/icons/lang.png"),
                  title: Text(
                    tr("language"),
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.w400,fontSize: 14),
                  ),
                  trailing: Icon(Icons.arrow_forward_ios,size: 17,),
                ),
                ListTile(
                  onTap: (){
                    if(GoRouter.of(context).routerDelegate.state!.name=='guestProfile'){
                      context.pushNamed("guestAccount");
                    }else{
                      context.pushNamed("account");
                    }
                  },
                  leading: Image.asset("assets/icons/account.png"),
                  title: Text(
                    "Account",
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.w400,fontSize: 14),
                  ),
                  trailing: Icon(Icons.arrow_forward_ios,size: 17,),
                ),
                ListTile(
                  onTap: (){},
                  leading:Icon(Icons.logout,color: ColorConstant.red,),
                  title: Text(
                    "LogOut",
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.w400,
                        color: ColorConstant.red,
                        fontSize: 14),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
