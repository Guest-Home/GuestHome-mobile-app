import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:minapp/core/common/spin_kit_loading.dart';
import 'package:minapp/core/common/custom_text_field.dart';
import 'package:minapp/core/utils/show_snack_bar.dart';
import 'package:minapp/core/utils/validator.dart';
import 'package:minapp/features/auth/presentation/bloc/auth_bloc.dart';
import '../../../../config/color/color.dart';
import '../../../../core/common/back_button.dart';
import '../../../../core/common/custom_button.dart';
import '../widgets/profile_photo_card.dart';
import '../widgets/upload_profile_photo.dart';

class ProfileSetup extends StatelessWidget {
  ProfileSetup({super.key});

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _fullNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: AppBarBackButton(),
        ),
        body: BlocProvider.value(
            value: context.read<AuthBloc>(),
            child: BlocConsumer<AuthBloc, AuthState>(
              listener: (context, state) {
                if (state is CreatedCustomerProfileLodedState) {
                  showSuccessSnackBar(context, "Profile Created Successfully");
                  context.read<AuthBloc>().add(AuthResetEvent());
                  context.goNamed('houseType');

                } else if (state is OtpErrorState) {
                  showErrorSnackBar(context, state.failure.message);
                }
              },
              buildWhen: (previous, current) => previous != current,
              builder: (context, state) {
                return Container(
                    padding: EdgeInsets.all(16),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          Expanded(
                            child: ListView(
                              children: [
                                Text(
                                  "Profile SetUp",
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineSmall!
                                      .copyWith(
                                          fontWeight: FontWeight.w700,
                                          fontSize:18),
                                ),
                                SizedBox(
                                  height: 32,
                                ),
                                stepSutTitle(context, "Full Name", true),
                                SizedBox(
                                  height: 13,
                                ),
                                CustomTextField(
                                    textEditingController: _fullNameController,
                                    hintText: "full name",
                                    surfixIcon: null,
                                    validator: (value) {
                                      if (value!.isEmpty ||
                                          !Validation.validateName(value)) {
                                        return "please enter valid name";
                                      }

                                      return null;
                                    },
                                    onTextChnage: (value) {
                                      context.read<AuthBloc>().add(
                                          AddFullNameEvent(fullName: value));
                                    },
                                    isMultiLine: false,
                                    textInputType: TextInputType.text),
                                SizedBox(
                                  height: 24,
                                ),
                                stepSutTitle(context, "Gender", true),
                                SizedBox(
                                  height: 14,
                                ),
                                Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: Gender.values
                                        .map(
                                          (gender) => Expanded(
                                            child: Card(
                                              color: Colors.white,
                                              elevation: 0,
                                              shape: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  borderSide: BorderSide(
                                                      color: gender.name ==
                                                              state.gender.name
                                                          ? ColorConstant
                                                              .primaryColor
                                                          : ColorConstant
                                                              .cardGrey
                                                              .withValues(
                                                                  alpha: 0.9))),
                                              child: SizedBox(
                                                width: 80,
                                                child: RadioListTile.adaptive(
                                                  selectedTileColor:
                                                      ColorConstant
                                                          .primaryColor,
                                                  title: Row(
                                                    spacing: 5,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      Image.asset(
                                                        gender.assetPath,
                                                        width: 15,
                                                      ),
                                                      Text(
                                                        gender.name,
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .bodySmall!
                                                            .copyWith(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400),
                                                      )
                                                    ],
                                                  ),
                                                  useCupertinoCheckmarkStyle:
                                                      true,
                                                  shape: OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10)),
                                                  value: gender,
                                                  groupValue: state.gender,
                                                  controlAffinity: ListTileControlAffinity.trailing,
                                                  onChanged: (value) {
                                                    context
                                                        .read<AuthBloc>()
                                                        .add(AddGenderEvent(
                                                            gender: value!));
                                                  },
                                                ),
                                              ),
                                            ),
                                          ),
                                        )
                                        .toList()),
                                SizedBox(
                                  height: 24,
                                ),
                                UploadProfilePhoto(
                                  ontTap: () {
                                    context
                                        .read<AuthBloc>()
                                        .add(SelectPictureEvent());
                                  },
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                SizedBox(
                                    child: state.profilePhoto != null
                                        ? ProfilePhotoCard(
                                            image: state.profilePhoto!,
                                            ontap: () {
                                              context
                                                  .read<AuthBloc>()
                                                  .add(RemovePictureEvent());
                                            },
                                          )
                                        : SizedBox.shrink())
                              ],
                            ),
                          ),
                          Container(
                              width: MediaQuery.of(context).size.width,
                              padding: EdgeInsets.symmetric(horizontal: 15),
                              child: Row(
                                spacing: 10,
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Expanded(child: CustomButton(
                                          onPressed: () {
                                            context.pop();
                                          },
                                          style: ElevatedButton.styleFrom(
                                            elevation: 0,
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 24, vertical: 21),
                                              side: BorderSide(
                                                  color: ColorConstant
                                                      .secondBtnColor),
                                              backgroundColor: Colors.white),
                                          child: Text("Back",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyLarge!
                                                  .copyWith(
                                                fontSize: 14,
                                                    fontWeight: FontWeight.w700,
                                                    color: ColorConstant
                                                        .secondBtnColor,
                                                  )))),
                                  Expanded(
                                      child: CustomButton(
                                          onPressed: state
                                                  is CreatingCustomerProfileLoadingState
                                              ? () {}
                                              : () {
                                                  _formKey.currentState!.save();
                                                  if (_formKey.currentState!
                                                      .validate()) {
                                                      context.read<AuthBloc>().add(
                                                          CreateCustomerProfileEvent());
                                                  }
                                                },
                                          style: ElevatedButton.styleFrom(
                                            elevation: 0,
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 24, vertical: 21),
                                              side: BorderSide(
                                                  color: ColorConstant
                                                      .primaryColor),
                                              backgroundColor:
                                                  ColorConstant.primaryColor),
                                          child: state
                                                  is CreatingCustomerProfileLoadingState
                                              ? loading
                                              : Text("Finish",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyLarge!
                                                      .copyWith(
                                                    fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        color: Colors.white,
                                                      ))))
                                ],
                              ))
                        ],
                      ),
                    ));
              },
            )));
  }

  RichText stepSutTitle(BuildContext context, String title, bool isRequired) {
    return RichText(
        text: TextSpan(children: [
      TextSpan(
          text:tr(title),
          style: Theme.of(context)
              .textTheme
              .bodyMedium!
              .copyWith(fontWeight: FontWeight.w500, fontSize: 14)),
      TextSpan(
          text: isRequired ? " *" : '(optional)',
          style: TextStyle(
              color: isRequired
                  ? ColorConstant.red
                  : ColorConstant.cardGrey.withValues(alpha: 0.5)))
    ]));
  }
}
