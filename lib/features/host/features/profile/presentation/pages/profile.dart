import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:go_router/go_router.dart';
import 'package:minapp/config/color/color.dart';
import 'package:minapp/core/apiConstants/api_url.dart';
import 'package:minapp/core/common/custom_button.dart';
import 'package:minapp/core/common/loading_indicator_widget.dart';
import 'package:minapp/features/auth/presentation/bloc/log_out/log_out_bloc.dart';
import 'package:minapp/features/host/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../../core/common/spin_kit_loading.dart';
import '../../../../../../core/utils/show_snack_bar.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {

  @override
  void initState() {
    super.initState();
  //  context.read<ProfileBloc>().add(GetUserProfileEvent());
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
        onRefresh: () async{
          context.read<ProfileBloc>().add(GetUserProfileEvent());
        },
      child: Scaffold(
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
                  spacing: 13,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: BlocConsumer<ProfileBloc, ProfileState>(
                        listener: (context, state) {
                          if(state is NoInternetSate){
                            showNoInternetSnackBar(context,(){context.read<ProfileBloc>().add(GetUserProfileEvent());});
                          }
                        },
                        bloc: context.read<ProfileBloc>(),
                        buildWhen: (previous, current) => previous!=current,
                        builder: (context, state) {
                          if (state is UserProfileLoadingState) {
                            return SizedBox(
                              height: 100,
                              child: Center(child: loadingIndicator()),
                            );
                          }
                          else if(state is ProfileErrorState || state.userProfileEntity.id==null){
                               return SizedBox(
                              height: 100,
                              child: Center(child: loadingIndicator()),
                            );
                          }
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
                                      backgroundImage:state.userProfileEntity.profilePicture!=null?
                                      CachedNetworkImageProvider(
                                        ApiUrl.baseUrl + state.userProfileEntity.profilePicture!,
                                          headers: {'Authorization': 'Bearer ${state.token}'
                                          },
                                        cacheManager: NoCacheManager()
                                      )
                                      // NetworkImage(
                                      //   ApiUrl.baseUrl + state.userProfileEntity.profilePicture!,
                                      //   headers: {'Authorization': 'Bearer ${state.token}'
                                      //   },// Use custom manager
                                      // )
                                            :null,
                                      child: state.userProfileEntity.profilePicture == null
                                          ? Icon(
                                        Icons.person,
                                        color: Colors.black12,
                                        size: 20,
                                      )
                                          :   Icon(
                                              Icons.photo,
                                           color: Colors.black12,
                                             ),
                                    ),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "${state.userProfileEntity.userAccount!.firstName} "
                                          "${state.userProfileEntity.userAccount!.lastName}",
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
                                          state.userProfileEntity.phoneNumber!,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall!
                                              .copyWith(
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 14),
                                        ),
                                        Text(
                                          tr(state.userProfileEntity.typeOfCustomer!),
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall!
                                              .copyWith(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w400,
                                                  color:
                                                      ColorConstant.secondBtnColor),
                                        )
                                      ].animate(interval: 10.ms).fade(),
                                    )
                                  ].animate(interval: 10.ms).fade(),
                                ),
                                // based on the user display either card or container
                                if (GoRouterState.of(context).matchedLocation == '/profile')
                                  Card(
                                    color: ColorConstant.cardGrey,
                                    elevation: 0,
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
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            spacing: 5,
                                            children: [
                                              Text(
                                                tr("Amount"),
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyLarge!
                                                    .copyWith(
                                                        fontWeight: FontWeight.w700,
                                                        fontSize: 14),
                                              ),
                                              Text(tr("Your current deposited amount"),
                                                textAlign: TextAlign.start,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodySmall,
                                              ),
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            spacing: 10,
                                            children: [
                                              Text(
                                                state.userProfileEntity.points!.toString(),
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyLarge!
                                                    .copyWith(
                                                        fontWeight: FontWeight.w700,
                                                        fontSize: 20,
                                                        color: ColorConstant
                                                            .primaryColor),
                                              ),
                                              Text(
                                                tr("ETB"),
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodySmall!
                                                    .copyWith(
                                                        color: ColorConstant
                                                            .primaryColor),
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                              ],
                            );

                          // return SizedBox(
                          //     height: 150,
                          //     child: Center(child: loadingIndicator()));
                        },
                      ),
                    ),
                    Container(
                        width: MediaQuery.of(context).size.width,
                        margin: EdgeInsets.only(
                            left:20, right: 20, bottom: 20, top: 10),
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
                                  Icons.swap_horiz,
                                  color: Colors.white,
                                ),
                                if (GoRouterState.of(context).matchedLocation == '/profile')
                                  Text(tr("Switch Guest"),
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall!
                                          .copyWith(
                                        color: Colors.white,
                                      )),
                                if (GoRouterState.of(context).matchedLocation=='/guestProfile')
                                  Text(tr("Switch to host"),
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall!
                                          .copyWith(
                                        color: Colors.white,
                                      )),
                              ],
                            ))),
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
                      title: Text(tr("General information"),
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
                       tr("Account"),
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
                      onTap: () async{
                        final Uri url = Uri.parse("https://etguesthome.com/");
                        if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
                        throw 'Could not launch $url';
                        }
                      },
                      leading: Icon(Icons.info_outline,color: ColorConstant.inActiveColor.withValues(alpha: 0.6),),
                      title: Text(
                       tr("About us"),
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
                      onTap: () async{
                        final Uri url = Uri.parse("https://etguesthome.com/TermCondition.html");
                        if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
                          throw 'Could not launch $url';
                        }
                      },
                      leading: Icon(Icons.privacy_tip_outlined,color: ColorConstant.inActiveColor.withValues(alpha: 0.6),),
                      title: Text(
                        tr("Term and condition"),
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
                    Text(tr('Payment setting'),
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
                      title: Text(tr("Payment setting"),
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
                         // context.read<ProfileBloc>().add(ResetProfileEvent());
                          context.goNamed('signIn');
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
                            tr("Log out"),
                            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                fontWeight: FontWeight.w400,
                                color: ColorConstant.red,
                                fontSize: 14),
                          ),
                        );
                      },
                    ),
                  ].animate().fade(),
                ),
              ),

          )),
    );
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
                      tr("Log out"),
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
                child: Text("${tr("Do you want to logout")}?${tr("This can’t be undone")}"),
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
              child: Text(tr("Cancel"),
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
                  child: Text(tr("Log out"),
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


class NoCacheManager extends CacheManager {
  static const key = 'noCacheManager';

  NoCacheManager()
      : super(Config(
    key,
    stalePeriod: Duration.zero, // Disable cache
    maxNrOfCacheObjects: 0,
  ));
}