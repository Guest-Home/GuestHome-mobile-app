import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:minapp/core/common/custom_text_field.dart';
import 'package:minapp/core/common/loading_indicator_widget.dart';
import 'package:minapp/core/common/spin_kit_loading.dart';
import 'package:minapp/core/utils/show_snack_bar.dart';
import 'package:minapp/core/utils/validator.dart';
import 'package:minapp/features/host/features/profile/presentation/bloc/change_phone_number/change_phone_bloc.dart';
import 'package:minapp/features/host/features/profile/presentation/bloc/update_profile_bloc/update_profile_bloc.dart';
import 'package:minapp/features/host/features/profile/presentation/pages/profile.dart';
import '../../../../../../config/color/color.dart';
import '../../../../../../core/apiConstants/api_url.dart';
import '../../../../../../core/common/country_code_selector.dart';
import '../../../../../../core/common/custom_button.dart';
import '../bloc/profile_bloc.dart';

class GeneralInformation extends StatelessWidget {
  GeneralInformation({super.key});

  Text subSectionText(String title, BuildContext context) => Text(
        title,
        style: Theme.of(context)
            .textTheme
            .bodyMedium!
            .copyWith(fontSize: 14, fontWeight: FontWeight.w500),
      );
  Text sectionTitle(BuildContext context, String title) {
    return Text(title,
        style: Theme.of(context)
            .textTheme
            .bodyLarge!
            .copyWith(fontWeight: FontWeight.w400));
  }

  final TextEditingController phone = TextEditingController();
  final TextEditingController fullName = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: Text(
          tr('General information'),
          style: Theme.of(context)
              .textTheme
              .bodyLarge!
              .copyWith(fontWeight: FontWeight.bold),
        ),
      ),
      body: MultiBlocListener(
        listeners: [
          BlocListener<ProfileBloc, ProfileState>(
            listener: (context, state) {
              if (state is ProfileErrorState) {
                showErrorSnackBar(context, 'unable to update');
              }
            },
          ),
          BlocListener<UpdateProfileBloc, UpdateProfileState>(
            listener: (context, state) {
              if (state is UpdateUserProfileLoadedState) {
                showSuccessSnackBar(context, "profile updated");
                context.read<ProfileBloc>().add(ResetProfileEvent());
                context.read<UpdateProfileBloc>().add(ResetUpdateEvent());
                context.read<ProfileBloc>().add(GetUserProfileEvent());
                context.pop();
                // if (GoRouterState.of(context).matchedLocation == '/profile'){
                //   context.goNamed("profile");
                // }else{
                //   context.goNamed("guestProfile");
                // }
              }
              if (state is UpdateProfileError) {
                showErrorSnackBar(context, state.failure.message);
              }
            },
          ),
          BlocListener<ChangePhoneBloc, ChangePhoneState>(
            listener: (context, state) {
              if(state is GettingOtpOldPhone){
                showDialog(context: context,
                  barrierDismissible: false,
                  builder: (context) => SizedBox(
                    width: 100,
                  height: 100,
                  child: loadingWithPrimary,
                ),);
              }
              if (state is GettingOtpOldPhoneSuccess) {
                context.pop();
                showSuccessSnackBar(context, state.otpResponseEntity.message);
                if (GoRouter.of(context).routerDelegate.state!.name ==
                    'guestGeneralInformation') {
                  context.goNamed(
                    "guestVerifyOldPhone",
                  );
                } else {
                  context.goNamed("verifyOldPhone",
                  );
                }
              } else if (state is PhoneChangeErrorState) {
                context.pop();
                showErrorSnackBar(context, state.failure.message);
              }
            },
          )
        ],
        child: SingleChildScrollView(
            padding: EdgeInsets.all(20),
            child:BlocBuilder<ProfileBloc, ProfileState>(
              bloc: context.read<ProfileBloc>(),
                builder: (context, state) {
                  if (state is UserProfileLoadingState) {
                    return SizedBox(
                        height: MediaQuery.of(context).size.height * 0.5,
                        child: Center(
                          child: loadingIndicator(),
                        ));
                  }
                  else if(state is ProfileErrorState){
                    return  SizedBox(
                        height: MediaQuery.of(context).size.height/2,
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.error_outline,size: 25,color: ColorConstant.red,),
                              Text(
                                state.failure.message,
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                            ],
                          ),
                        ),

                    );
                  }

                    phone.text = state.userProfileEntity.phoneNumber!.substring("251".length);
                    fullName.text ="${state.userProfileEntity.userAccount!.firstName}"
                        " ${state.userProfileEntity.userAccount!.lastName}";
                    return BlocBuilder<UpdateProfileBloc, UpdateProfileState>(
                      buildWhen: (previous, current) => previous!=current,
                      builder: (context, updateProfileState) {
                        return Form(
                          key: _formKey,
                          child: Column(
                            spacing: 15,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              sectionTitle(context, tr("Profile image")),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  (updateProfileState.profilePhoto != null &&
                                          updateProfileState
                                              .profilePhoto!.path.isNotEmpty)
                                      ? CircleAvatar(
                                          radius:50,
                                          backgroundColor:
                                              ColorConstant.cardGrey,
                                          backgroundImage: FileImage(File(
                                              updateProfileState
                                                  .profilePhoto!.path)))
                                      : CircleAvatar(
                                          radius: 50,
                                          backgroundColor:
                                              ColorConstant.cardGrey,
                                          backgroundImage: state
                                                      .userProfileEntity
                                                      .profilePicture !=
                                                  null
                                              ?
                                          CachedNetworkImageProvider(
                                              ApiUrl.baseUrl + state.userProfileEntity.profilePicture!,
                                              headers: {'Authorization': 'Bearer ${state.token}'
                                              },
                                              cacheManager: NoCacheManager()
                                          )
                                          // NetworkImage(
                                          //   ApiUrl.baseUrl + state.userProfileEntity.profilePicture!,
                                          //   headers: {
                                          //     'Authorization': 'Bearer ${state.token}'
                                          //   },// Use custom manager
                                          // )
                                              : null,
                                          child: state.userProfileEntity
                                                      .profilePicture ==
                                                  null
                                              ? Icon(
                                                  Icons.person,
                                                  color: Colors.black12,
                                                  size: 20,
                                                )
                                              : Icon(
                                            Icons.person,
                                            color: Colors.black12,
                                            size: 20,
                                          ),
                                        ),
                                  Expanded(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        SizedBox(
                                          width: 200,
                                          child: CustomButton(
                                              onPressed: () {
                                                context
                                                    .read<UpdateProfileBloc>()
                                                    .add(
                                                        SelectPictureUpdateEvent());
                                              },
                                              style: ElevatedButton.styleFrom(
                                                  elevation: 0,
                                                  padding: EdgeInsets.all(10),
                                                  side: BorderSide(
                                                      color: ColorConstant
                                                          .primaryColor),
                                                  backgroundColor: ColorConstant
                                                      .primaryColor),
                                              child: Text(tr("Upload"),
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodySmall!
                                                      .copyWith(
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        color: Colors.white,
                                                      ))),
                                        ),
                                        SizedBox(
                                          width: 200,
                                          child: CustomButton(
                                              onPressed: () {
                                                context
                                                    .read<UpdateProfileBloc>()
                                                    .add(
                                                        RemovePictureUpdateEvent());
                                              },
                                              style: ElevatedButton.styleFrom(
                                                  padding: EdgeInsets.all(10),
                                                  elevation: 0,
                                                  side: BorderSide(
                                                      color: ColorConstant
                                                          .primaryColor
                                                          .withValues(
                                                              alpha: 0.2)),
                                                  backgroundColor:
                                                      ColorConstant.cardGrey),
                                              child: Text(tr("Remove"),
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodySmall!
                                                      .copyWith(
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        color: ColorConstant
                                                            .primaryColor,
                                                      ))),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                              Divider(
                                thickness: 0.1,
                                color: ColorConstant.inActiveColor
                                    .withValues(alpha: 0.8),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              subSectionText(tr("Full name"), context),
                              CustomTextField(
                                  hintText:
                                      "${state.userProfileEntity.userAccount!.firstName}"
                                          " ${state.userProfileEntity.userAccount!.lastName??""}",
                                  surfixIcon: null,
                                  textEditingController: fullName,
                                  validator: (value) {
                                    if (value!.isEmpty ||
                                        !Validation.validateName(value)) {
                                      return "please provide valid name";
                                    }
                                    return null;
                                  },
                                  onTextChnage: (value) {},
                                  isMultiLine: false,
                                  textInputType: TextInputType.text),
                              SizedBox(
                                height: 3,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  subSectionText(tr("Phone number"), context),
                                  GestureDetector(
                                    onTap: () {
                                      context.read<ChangePhoneBloc>().add(
                                          GetOtpForOldPhoneEvent(
                                              oldPone: state.userProfileEntity
                                                  .phoneNumber!));
                                    },
                                    child: Text(
                                      tr("Change phone number"),
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium!
                                          .copyWith(
                                              fontWeight: FontWeight.w400,
                                              color: ColorConstant.primaryColor,
                                              fontSize: 14),
                                    ),
                                  )
                                ],
                              ),
                              CustomTextField(
                                  hintText: state.userProfileEntity.phoneNumber!.substring("251".length),
                                  surfixIcon: null,
                                  textEditingController: phone,
                                  validator: (value) {
                                    if (value!.isEmpty ||
                                        !Validation.phoneNumberValidation(
                                            value)) {
                                      return "please provide valid phone number with country code";
                                    }
                                    return null;
                                  },
                                  prifixIcon: CountryCodeSelector(
                                    onInit: (value) {},
                                    onChange: (value) {},
                                  ),
                                  onTextChnage: (value) {},
                                  isMultiLine: false,
                                  textInputType: TextInputType.phone),
                              Container(
                                  margin: EdgeInsets.only(top: 20),
                                  width: MediaQuery.of(context).size.width,
                                  child: CustomButton(
                                      onPressed: () {
                                        _formKey.currentState!.save();
                                        if (_formKey.currentState!.validate()) {
                                          if (fullName.text !="${state.userProfileEntity.userAccount!.firstName}"
                                                      " ${state.userProfileEntity.userAccount!.lastName}" ||
                                              (updateProfileState.profilePhoto != null &&
                                                  updateProfileState
                                                      .profilePhoto!
                                                      .path
                                                      .isNotEmpty)) {
                                            List<String> names =fullName.text.trim().split(' ');
                                            Map<String, dynamic>
                                                userProfileUpdate = {
                                             // "id": state.userProfileEntity.userAccount.id,
                                              "first_name": names.first,
                                              "last_name": names.last
                                            };
                                            context
                                                .read<UpdateProfileBloc>()
                                                .add(UpdateUserProfileEvent(
                                                    userData:
                                                        userProfileUpdate));
                                          }
                                        }
                                      },
                                      style: ElevatedButton.styleFrom(
                                          elevation: 0,
                                          padding: EdgeInsets.all(17),
                                          side: BorderSide(
                                              color:
                                                  ColorConstant.primaryColor),
                                          backgroundColor:
                                              ColorConstant.primaryColor),
                                      child: updateProfileState
                                              is UpdateUserProfileLoadingState
                                          ? loading
                                          : Text(tr("Save setting"),
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyMedium!
                                                  .copyWith(
                                                    fontWeight: FontWeight.w700,
                                                    color: Colors.white,
                                                  ))))
                            ].animate().fade(),
                          ),
                        );
                      },
                    );

                  // return SizedBox.shrink();
                },
              ),
            ),
      ),
    );
  }
}
