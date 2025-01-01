import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:minapp/core/common/upload_photo_widget.dart';
import 'package:minapp/core/common/custom_text_field.dart';
import 'package:minapp/core/utils/validator.dart';
import 'package:minapp/features/auth/presentation/bloc/auth_bloc.dart';

import '../../../../config/color/color.dart';
import '../../../../core/common/back_button.dart';
import '../../../../core/common/custom_button.dart';
import '../widgets/profile_photo_card.dart';

class ProfileSetup extends StatelessWidget {
  const ProfileSetup({super.key});

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
                print("o....");
                print(state.profilePhoto);
              },
              buildWhen: (previous, current) => previous != current,
              builder: (context, state) {
                return Container(
                  padding: EdgeInsets.all(15),
                  child: Column(
                    children: [
                      Expanded(
                        child: ListView(
                          padding: EdgeInsets.all(5),
                          children: [
                            Text(
                              "Profile SetUp",
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge!
                                  .copyWith(fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            stepSutTitle(context, "Full Name", true),
                            SizedBox(
                              height: 10,
                            ),
                            CustomTextField(
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
                                  context
                                      .read<AuthBloc>()
                                      .add(AddFullNameEvent(fullName: value));
                                },
                                isMultiLine: false,
                                textInputType: TextInputType.text),
                            SizedBox(
                              height: 20,
                            ),
                            stepSutTitle(context, "Gender", true),
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
                                                      : ColorConstant.cardGrey
                                                          .withValues(
                                                              alpha: 0.9))),
                                          child: SizedBox(
                                            width: 100,
                                            child: RadioListTile.adaptive(
                                              selectedTileColor:
                                                  ColorConstant.primaryColor,
                                              title: Row(
                                                spacing: 10,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Image.asset(
                                                    gender.assetPath,
                                                    width: 15,
                                                  ),
                                                  Text(gender.name)
                                                ],
                                              ),
                                              useCupertinoCheckmarkStyle: true,
                                              shape: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                              value: gender,
                                              groupValue: state.gender,
                                              onChanged: (value) {
                                                context.read<AuthBloc>().add(
                                                    AddGenderEvent(
                                                        gender: value!));
                                              },
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                    .toList()),
                            SizedBox(
                              height: 20,
                            ),
                            UploadPhoto(
                              ontTap: () {
                                context
                                    .read<AuthBloc>()
                                    .add(SelectPictureEvent());
                              },
                            ),
                            SizedBox(
                              height: 10,
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
                                    : Text("data"))
                          ],
                        ),
                      ),
                      Container(
                          width: MediaQuery.of(context).size.width,
                          padding: EdgeInsets.all(15),
                          child: Row(
                            spacing: 10,
                            children: [
                              Expanded(
                                  child: CustomButton(
                                      onPressed: () {
                                        context.pop();
                                      },
                                      style: ElevatedButton.styleFrom(
                                          side: BorderSide(
                                              color:
                                                  ColorConstant.secondBtnColor),
                                          backgroundColor: Colors.white),
                                      child: Text("Back",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium!
                                              .copyWith(
                                                color: ColorConstant
                                                    .secondBtnColor,
                                              )))),
                              Expanded(
                                  child: CustomButton(
                                      onPressed: () {
                                        context
                                            .read<AuthBloc>()
                                            .add(CreateCustomerProfileEvent());
                                      },
                                      style: ElevatedButton.styleFrom(
                                          side: BorderSide(
                                              color:
                                                  ColorConstant.primaryColor),
                                          backgroundColor:
                                              ColorConstant.primaryColor),
                                      child: Text("Finish",
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
              },
            )));
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
}
