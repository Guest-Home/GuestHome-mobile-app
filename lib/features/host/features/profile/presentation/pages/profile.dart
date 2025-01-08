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
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              spacing: 10,
                              children: [
                                CircleAvatar(
                                  radius: 45,
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
                                      "${state.userProfileEntity.userAccount.firstName} ${state.userProfileEntity.userAccount.lastName}",
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineSmall!
                                          .copyWith(
                                              fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      state.userProfileEntity.phoneNumber,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall!
                                          .copyWith(
                                              fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      state.userProfileEntity.typeOfCustomer,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall!
                                          .copyWith(
                                              color:
                                                  ColorConstant.secondBtnColor),
                                    )
                                  ],
                                )
                              ],
                            ),
                            // based on the user display either card or container
                            // if (GoRouter.of(context).state!.topRoute!.name ==
                            //     'guestProfile')
                            //   Card(
                            //     color: Colors.white,
                            //     elevation: 3,
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
                            //       child: Column(
                            //         crossAxisAlignment: CrossAxisAlignment.start,
                            //         spacing: 10,
                            //         children: [
                            //           Text(
                            //             tr("Become a Host"),
                            //             style: Theme.of(context)
                            //                 .textTheme
                            //                 .bodyLarge!
                            //                 .copyWith(fontWeight: FontWeight.bold),
                            //           ),
                            //           Text(
                            //             tr("Join our community of hosts and start welcoming guests today"),
                            //             style:
                            //             Theme.of(context).textTheme.bodySmall,
                            //           ),
                            //           Container(
                            //             margin: EdgeInsets.symmetric(vertical: 10),
                            //             child: CustomButton(
                            //                 onPressed: () {
                            //                   context.goNamed('properties');
                            //                 },
                            //                 style: ElevatedButton.styleFrom(
                            //                     padding: EdgeInsets.symmetric(
                            //                         horizontal: 40, vertical: 15),
                            //                     backgroundColor:
                            //                     ColorConstant.primaryColor),
                            //                 child: Text(
                            //                   tr('Become a Host'),
                            //                   style: Theme.of(context)
                            //                       .textTheme
                            //                       .bodyMedium!
                            //                       .copyWith(color: Colors.white),
                            //                 )),
                            //           )
                            //         ],
                            //       ),
                            //     ),
                            //   ),
                            //switch to guest button
                            Container(
                                width: MediaQuery.of(context).size.width,
                                margin: EdgeInsets.only(
                                    left: 30, right: 30, bottom: 10, top: 20),
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
                  title: Text(
                    tr("language"),
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  trailing: Icon(Icons.arrow_right_alt_outlined),
                ),
                ListTile(
                  onTap: () => context.pushNamed("account"),
                  leading: Image.asset("assets/icons/account.png"),
                  title: Text(
                    "Account",
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  trailing: Icon(Icons.arrow_right_alt_outlined),
                )
              ],
            ),
          ),
        ));
  }
}
