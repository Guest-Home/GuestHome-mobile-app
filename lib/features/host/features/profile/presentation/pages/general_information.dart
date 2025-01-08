import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:minapp/core/common/back_button.dart';
import 'package:minapp/core/common/custom_text_field.dart';
import 'package:minapp/core/common/spin_kit_loading.dart';
import 'package:minapp/core/utils/validator.dart';
import '../../../../../../config/color/color.dart';
import '../../../../../../core/apiConstants/api_url.dart';
import '../../../../../../core/common/country_code_selector.dart';
import '../../../../../../core/common/custom_button.dart';
import '../bloc/profile_bloc.dart';

class GeneralInformation extends StatelessWidget {
   GeneralInformation({super.key});

  Text subSectionText(String title,BuildContext context) => Text(title,style: Theme.of(context).textTheme.bodyMedium!.copyWith(
    fontSize: 14,fontWeight: FontWeight.w600
  ),);

  Text sectionTitle(BuildContext context, String title) {
    return Text(title,
        style: Theme.of(context)
            .textTheme
            .bodyLarge!
            .copyWith(fontWeight: FontWeight.w400));
  }

  TextEditingController phone=TextEditingController();
  TextEditingController email=TextEditingController();
  TextEditingController fullName=TextEditingController();

  final _formKey=GlobalKey<FormState>();



   _showErrorSnackBar(BuildContext context, String message) {
     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
       content: Text(message),
       backgroundColor: ColorConstant.red,
     ));
   }
   _showSuccessSnackBar(BuildContext context, String message) {
     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
       content: Text(message),
       backgroundColor: ColorConstant.green,
     ));
   }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: AppBarBackButton(),
        title: Text(
          'General Information',
          style: Theme.of(context)
              .textTheme
              .bodyLarge!
              .copyWith(fontWeight: FontWeight.bold),
        ),
      ),
      body: BlocListener<ProfileBloc, ProfileState>(
  listener: (context, state) {
    if(state is ProfileErrorState){
      _showErrorSnackBar(context, 'unable to update');
    }
    else if(state is UpdateUserProfileState && state.isUpdate){
      context.read<ProfileBloc>().add(GetUserProfileEvent());
      _showSuccessSnackBar(context, "profile updated");

    }
  },
  child: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child:BlocProvider.value(
            value:context.read<ProfileBloc>(),
        child: BlocBuilder<ProfileBloc,ProfileState>(builder: (context, state) {
          if(state is UpdateUserProfileLoadingState || state is UserProfileLoadingState){
            return SizedBox(
              height: MediaQuery.of(context).size.height,
                child: Center(child: CupertinoActivityIndicator(),));
          }
          if(state is UserProfileLoadedState){
            phone.text=state.userProfileEntity.phoneNumber;
            email.text=state.userProfileEntity.userAccount.email;
            fullName.text="${state.userProfileEntity.userAccount.firstName} ${state.userProfileEntity.userAccount.lastName}";
            return  Form(
              key: _formKey,
              child: Column(
                spacing: 15,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  sectionTitle(context, "Profile Image"),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CircleAvatar(
                        radius: 60,
                        backgroundColor: ColorConstant.cardGrey,
                        backgroundImage: CachedNetworkImageProvider(ApiUrl.baseUrl+state.userProfileEntity.profilePicture,
                          headers: {
                            'Authorization': 'Bearer ${state.token}'
                          },

                        ),
                      ),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                                width: 200,
                                child: CustomButton(
                                    onPressed: () {},
                                    style: ElevatedButton.styleFrom(
                                        elevation: 0,
                                        padding: EdgeInsets.all(10),
                                        side: BorderSide(
                                            color: ColorConstant.primaryColor),
                                        backgroundColor: ColorConstant.primaryColor),
                                    child: Text("Upload",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall!
                                            .copyWith(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ))),
                              ),

                            SizedBox(
                                width: 200,
                                child: CustomButton(
                                    onPressed: () {},
                                    style: ElevatedButton.styleFrom(
                                        padding: EdgeInsets.all(10),
                                        elevation: 0,
                                        side: BorderSide(color: ColorConstant.primaryColor.withValues(alpha: 0.2)),
                                        backgroundColor: ColorConstant.cardGrey),
                                    child: Text("Remove",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall!
                                            .copyWith(
                                          fontWeight: FontWeight.bold,
                                          color: ColorConstant.primaryColor,
                                        ))),
                              ),

                          ],
                        ),
                      )
                    ],
                  ),
                  Divider(
                    thickness: 0.1,
                  ),

                  SizedBox(height: 10,),
                  subSectionText("Full Name",context),
                  CustomTextField(
                      hintText: "${state.userProfileEntity.userAccount.firstName} ${state.userProfileEntity.userAccount.lastName}",
                      surfixIcon:null,
                      textEditingController: fullName,
                      validator: (value) {
                       if(value!.isEmpty || !Validation.validateName(value)){
                         return "please provide valid name";
                       }
                        return null;
                      },
                      onTextChnage:(value) {
                      }, isMultiLine: false, textInputType: TextInputType.text),
                  subSectionText("Email",context),
                  CustomTextField(hintText:'email',
                      surfixIcon:null,
                      textEditingController: email,
                      validator: (value) {
                        if(value!.isEmpty && !Validation.validateEmail(value)){
                          return "please provide valid email";
                        }
                        return null;
                      },
                      onTextChnage:(value) {
                      }, isMultiLine: false, textInputType: TextInputType.emailAddress),
                  subSectionText("Phone number",context),
                  CustomTextField(
                      hintText:state.userProfileEntity.phoneNumber,
                      surfixIcon:null,
                      textEditingController: phone,
    validator: (value) {
      if (value!.isEmpty && !Validation.phoneNumberValidation(value)) {
        return "please provide valid phone number";
      }
      return null;
    },
                      prifixIcon: CountryCodeSelector(
                        onInit: (value) {

                        },
                        onChange: (value) {

                        },
                      ),
                      onTextChnage:(value) {
                      }, isMultiLine: false, textInputType: TextInputType.phone),
                  Container(
                    margin: EdgeInsets.only(top: 20),
                    width: MediaQuery.of(context).size.width,
                    child: CustomButton(
                        onPressed: () {
                          _formKey.currentState!.save();
                          if(_formKey.currentState!.validate()){
                             if(fullName.text!="${state.userProfileEntity.userAccount.firstName} ${state.userProfileEntity.userAccount.lastName}"
                                 || phone.text!=state.userProfileEntity.phoneNumber || email.text!=state.userProfileEntity.userAccount.email ){

                               List<String> names = fullName.text.trim().split(' ');
                              Map<String,dynamic> userProfileUpdate={
                                "id": state.userProfileEntity.userAccount.id,
                                "email":email.text,
                                "first_name":names.first,
                                "last_name":names.last
                              };
                              context.read<ProfileBloc>().add(UpdateUserProfileEvent(userData: userProfileUpdate));
                             }


                          }
                        },
                        style: ElevatedButton.styleFrom(
                            elevation: 0,
                            padding: EdgeInsets.all(21),
                            side: BorderSide(color: ColorConstant.primaryColor),
                            backgroundColor: ColorConstant.primaryColor),
                        child:state is UpdateUserProfileLoadingState?loading: Text("Save Setting",
                            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ))),
                  )
                ],
              ),
            );
          }
          return SizedBox.shrink();
        },),
        )

      ),
),
    );
  }
}
