import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:minapp/config/color/color.dart';
import 'package:minapp/core/apiConstants/api_url.dart';
import 'package:minapp/core/common/custom_button.dart';
import 'package:minapp/core/common/loading_indicator_widget.dart';
import 'package:minapp/features/auth/presentation/bloc/log_out/log_out_bloc.dart';
import 'package:minapp/features/host/features/profile/presentation/bloc/profile_bloc.dart';

import '../../../../../../core/common/spin_kit_loading.dart';

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
                      if (state is UserProfileLoadingState ||state is ProfileErrorState) {
                        return SizedBox(
                          height: 150,
                          child: Center(child: loadingIndicator()),
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
                                  backgroundImage:state.userProfileEntity.profilePicture!=null? CachedNetworkImageProvider(
                                    ApiUrl.baseUrl +
                                        state.userProfileEntity.profilePicture!,
                                    headers: {
                                      'Authorization': 'Bearer ${state.token!}'
                                    },
                                  ):null,
                                  child: state.userProfileEntity.profilePicture == null
                                      ? Icon(
                                    Icons.person,
                                    color: Colors.black12,
                                    size: 20,
                                  )
                                      : null,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${state.userProfileEntity.userAccount.firstName} "
                                      "${state.userProfileEntity.userAccount.lastName}",
                                      textAlign: TextAlign.start,
                                      overflow: TextOverflow.ellipsis,
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
                                              fontWeight: FontWeight.w600,
                                              fontSize: 14),
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

                            // if (GoRouter.of(context).state!.name == 'profile')
                            //   Card(
                            //     color: ColorConstant.cardGrey,
                            //     elevation: 0,
                            //     shadowColor: ColorConstant.cardGrey,
                            //     shape: RoundedRectangleBorder(
                            //       borderRadius: BorderRadius.circular(15),
                            //       side: BorderSide(
                            //         color: ColorConstant.cardGrey,
                            //       ),
                            //     ),
                            //     child: Container(
                            //       width: MediaQuery.of(context).size.width,
                            //       padding: const EdgeInsets.all(15),
                            //       child: Row(
                            //         mainAxisAlignment:
                            //             MainAxisAlignment.spaceBetween,
                            //         children: [
                            //           Column(
                            //             crossAxisAlignment:
                            //                 CrossAxisAlignment.start,
                            //             spacing: 10,
                            //             children: [
                            //               Text(
                            //                 tr("Amount"),
                            //                 style: Theme.of(context)
                            //                     .textTheme
                            //                     .bodyLarge!
                            //                     .copyWith(
                            //                         fontWeight: FontWeight.w700,
                            //                         fontSize: 14),
                            //               ),
                            //               Text(
                            //                 tr("Lorem ipsum dolor sit amet\n consectetur."),
                            //                 style: Theme.of(context)
                            //                     .textTheme
                            //                     .bodySmall,
                            //               ),
                            //             ],
                            //           ),
                            //           Row(
                            //             mainAxisAlignment:
                            //                 MainAxisAlignment.end,
                            //             spacing: 10,
                            //             children: [
                            //               Text(
                            //                 "2344",
                            //                 style: Theme.of(context)
                            //                     .textTheme
                            //                     .bodyLarge!
                            //                     .copyWith(
                            //                         fontWeight: FontWeight.w700,
                            //                         fontSize: 20,
                            //                         color: ColorConstant
                            //                             .primaryColor),
                            //               ),
                            //               Text(
                            //                 "ETB",
                            //                 style: Theme.of(context)
                            //                     .textTheme
                            //                     .bodySmall!
                            //                     .copyWith(
                            //                         color: ColorConstant
                            //                             .primaryColor),
                            //               )
                            //             ],
                            //           )
                            //         ],
                            //       ),
                            //     ),
                            //   ),


                            //switch to guest button
                            // if (GoRouter.of(context).state!.name == 'profile')
                            Container(
                                  width: MediaQuery.of(context).size.width / 2,
                                  margin: EdgeInsets.only(
                                      left: 10, right: 10, bottom: 15, top: 10),
                                  child: CustomButton(
                                      onPressed: () {
                                        if (GoRouter.of(context).state!.name == 'profile'){
                                          context.goNamed('houseType');
                                        }else{
                                          context.goNamed('properties');
                                        }

                                      },
                                      style: ElevatedButton.styleFrom(
                                          elevation: 10,
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
                                          if (GoRouterState.of(context).matchedLocation == '/profile')
                                          Text("Switch to Guest",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodySmall!
                                                  .copyWith(
                                                    color: Colors.white,
                                                  )),
                                          if (GoRouterState.of(context).matchedLocation=='/guestProfile')
                                            Text("Switch to Host",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodySmall!
                                                    .copyWith(
                                                  color: Colors.white,
                                                )),
                                        ],
                                      ))),
                          ],
                        );
                      }
                      return SizedBox(
                          height: 150,
                          child: Center(child: loadingIndicator()));
                    },
                  ),
                ),
                Text(tr('Settings'),
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        color: ColorConstant.secondBtnColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w700)),
                ListTile(
                  onTap: () {
                    if (GoRouter.of(context).routerDelegate.state!.name ==
                        'guestProfile') {
                      context.pushNamed('guestGeneralInformation');
                    } else {
                      context.pushNamed('generalInformation');
                    }
                  },
                  leading: Image.asset("assets/icons/user.png"),
                  title: Text(
                    "General Information",
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(fontWeight: FontWeight.w400, fontSize: 14),
                  ),
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    size: 17,
                  ),
                ),
                ListTile(
                  onTap: () {
                    if (GoRouter.of(context).routerDelegate.state!.name ==
                        'guestProfile') {
                      context.go("/guestProfile/guestLanguage");
                    } else {
                      context.go("/profile/language");
                    }
                  },
                  leading: Image.asset("assets/icons/lang.png"),
                  title: Text(
                    tr("language"),
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(fontWeight: FontWeight.w400, fontSize: 14),
                  ),
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    size: 17,
                  ),
                ),
                ListTile(
                  onTap: () {
                    if (GoRouter.of(context).routerDelegate.state!.name ==
                        'guestProfile') {
                      context.pushNamed("guestAccount");
                    } else {
                      context.pushNamed("account");
                    }
                  },
                  leading: Image.asset("assets/icons/account.png"),
                  title: Text(
                    "Account",
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(fontWeight: FontWeight.w400, fontSize: 14),
                  ),
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    size: 17,
                  ),
                ),
                if (GoRouterState.of(context).matchedLocation == '/profile')
                Text(tr('Payment Setting'),
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        color: ColorConstant.secondBtnColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w700)),
                if (GoRouterState.of(context).matchedLocation == '/profile')
                ListTile(
                  onTap: () {
                      context.pushNamed("paymentSetting");
                  },
                  leading: Icon(Icons.currency_exchange,color: ColorConstant.secondBtnColor.withValues(alpha: 0.6),size: 22,),
                  title: Text(
                    "Payment Setting",
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(fontWeight: FontWeight.w400, fontSize: 14),
                  ),
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    size: 17,
                  ),
                ),
                BlocConsumer<LogOutBloc, LogOutState>(
                  listener: (context, state) {
                    if (state is LogOutLoadingState) {
                      context.pop();
                      _deletingDialog(context, "Logging Out");
                    } else if (state is LogOutLoadedState) {
                      context.pop();
                      context.pushNamed('signIn');
                    }
                  },
                  builder: (context, state) {
                    return ListTile(
                      onTap: () {
                        _showLogOutDialog(context);
                      },
                      leading: Icon(
                        Icons.logout,
                        color: ColorConstant.red,
                      ),
                      title: Text(
                        "LogOut",
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            fontWeight: FontWeight.w400,
                            color: ColorConstant.red,
                            fontSize: 14),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ));
  }

  void _deletingDialog(BuildContext context, String title) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        contentPadding: EdgeInsets.all(15),
        content: SizedBox(
          height: 80,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              loadingWithPrimary,
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  title,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showLogOutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        content: SizedBox(
          height: 130,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.all(9),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: ColorConstant.cardGrey,
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(10),
                        topLeft: Radius.circular(10))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "LogOut",
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                    Icon(
                      Icons.cancel_outlined,
                      size: 15,
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Do you want to logout? This cant be undone."),
              ),
            ],
          ),
        ),
        actionsAlignment: MainAxisAlignment.end,
        contentPadding: EdgeInsets.all(0),
        actionsPadding: EdgeInsets.all(10),
        actions: [
          CustomButton(
              onPressed: () => context.pop(),
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
          BlocConsumer<ProfileBloc, ProfileState>(
            listener: (context, state) {
              if (state is LogOutState) {
                context.pop();
                if (GoRouter.of(context).routerDelegate.state!.name ==
                    'guestProfile') {
                  context.pushNamed("houseType");
                } else {
                  context.pushNamed("properties");
                }
              }
            },
            builder: (context, state) {
              return CustomButton(
                  onPressed: () {
                    context.read<LogOutBloc>().add(UserLogoutEvent());
                  },
                  style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.only(left: 4, right: 4),
                      backgroundColor: ColorConstant.red),
                  child: Text("LogOut",
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            color: Colors.white,
                          )));
            },
          )
        ],
      ),
    );
  }
}
