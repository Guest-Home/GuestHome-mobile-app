import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:minapp/core/common/spin_kit_loading.dart';
import 'package:minapp/core/utils/show_snack_bar.dart';
import 'package:minapp/features/host/features/profile/presentation/bloc/payment_setting_bloc/payment_setting_bloc.dart';
import 'package:minapp/features/host/features/profile/presentation/bloc/profile_bloc.dart';
import '../../../../../../config/color/color.dart';
import '../../../../../../core/common/custom_button.dart';
import '../../../../../../core/common/custom_text_field.dart';
import '../../../../../../core/common/enum/payment_medthod.dart';

class AddFunds extends StatelessWidget {
   AddFunds({super.key});

  final _formKey=GlobalKey<FormState>();
  final TextEditingController amountController=TextEditingController();

   Future<dynamic> showBookedDialog(BuildContext context) {
     return showDialog(
       context: context,
       barrierDismissible: false,
       builder: (context) => AlertDialog(
           backgroundColor: Colors.white,
           title: Text(
             'Deposit Request Success',
             style: Theme.of(context)
                 .textTheme
                 .headlineSmall!
                 .copyWith(fontWeight: FontWeight.bold),
           ),
           icon: SvgPicture.asset(
             'assets/icons/congrates.svg',
             semanticsLabel: 'language',
             fit: BoxFit.cover,
           ),
           content: SizedBox(
             height: 150,
             child: Column(
               spacing:5,
               mainAxisAlignment: MainAxisAlignment.start,
               children: [
                 Text(
                   "you will receive USSD payment dialog and please verify your payment",
                   textAlign: TextAlign.center,
                 ),
                 Container(
                   width: MediaQuery.of(context).size.width,
                   margin: EdgeInsets.symmetric(horizontal: 20),
                   child: CustomButton(
                       onPressed: () {
                         context.pop();
                         context.read<ProfileBloc>().add(GetUserProfileEvent());
                       },
                       style: ElevatedButton.styleFrom(
                           backgroundColor: ColorConstant.primaryColor,
                           padding: EdgeInsets.all(15)),
                       child: Text(
                         tr("Done"),
                         style: TextStyle(color: Colors.white),
                       )),
                 )
               ],
             ),
           )),
     );
   }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        // leading: AppBarBackButton(),
        title: Text(
         tr('Add fund'),
          style: Theme.of(context)
              .textTheme
              .bodyLarge!
              .copyWith(fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child:
         BlocConsumer<PaymentSettingBloc, PaymentSettingState>(
  listener: (context, state) {
    if(state is DepositPaymentSuccess){
      showBookedDialog(context);

    }
    else if(state is PaymentSettingError){
     showErrorSnackBar(context, "deposit error");
    }

  },
  builder: (context, state) {
    return Form(
      key: _formKey,
          child: Column(
            spacing: 13,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                tr("Enter amount"),
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: ColorConstant.inActiveColor),
              ),
              CustomTextField(
                hintText: 'price',
                textEditingController: amountController,
                surfixIcon:null,
                isMultiLine: false,
                onTextChnage: (value) {
                  context.read<PaymentSettingBloc>().add(AddAmountEvent(amount: amountController.text));
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter price';
                  }
                  return null;
                },
                textInputType: TextInputType.number,
                prifixIcon: null,
              ),
              SizedBox(height: 15,),
              Text(
                tr("Select payment method"),
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: ColorConstant.inActiveColor),
              ),
              ListView.builder(
                shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount:PaymentMethod.values.length,
                    itemBuilder: (context, index){
                      final id = PaymentMethod.values[index];
                      return   Padding(
                        padding: EdgeInsets.only(bottom: 10),
                        child: RadioListTile.adaptive(
                          activeColor: ColorConstant.primaryColor,
                          selectedTileColor: ColorConstant.primaryColor,
                          controlAffinity: ListTileControlAffinity.trailing,
                          title: Text(
                            id.name,
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                          useCupertinoCheckmarkStyle: true,
                          shape: OutlineInputBorder(
                              borderSide: BorderSide(color:state.paymentMethod.name==id.name?ColorConstant.primaryColor: ColorConstant.cardGrey),
                              borderRadius: BorderRadius.circular(10)),
                          value: id,
                          groupValue:state.paymentMethod,
                          onChanged: (value) {
                            context.read<PaymentSettingBloc>().add(AddPaymentMethodEvent(paymentMethod: id));
                          },
                        ),
                      );
                    }

              ),
              SizedBox(height: 15,),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: CustomButton(
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      backgroundColor: ColorConstant.primaryColor,
                    ),
                    onPressed:() {
                     _formKey.currentState!.save();
                     if(_formKey.currentState!.validate()){
                        context.read<PaymentSettingBloc>().add(MakePaymentEvent());
                     }
                    },
                    child:state is DepositPaymentLoading?loading:Text(
                      tr("Continue"),
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w500),
                    )),
              )
            ],
          ),
        );
  },
),
      ),
    );
  }
}
