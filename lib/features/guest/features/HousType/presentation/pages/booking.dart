import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:minapp/core/common/custom_text_field.dart';
import 'package:minapp/core/utils/show_snack_bar.dart';
import 'package:minapp/core/utils/validator.dart';
import 'package:minapp/features/guest/features/HousType/presentation/bloc/booking/booking_bloc.dart';
import 'package:minapp/features/guest/features/HousType/presentation/widgets/section_header_text.dart';

import '../../../../../../config/color/color.dart';
import '../../../../../../core/common/back_button.dart';
import '../../../../../../core/common/country_code_selector.dart';
import '../../../../../../core/common/custom_button.dart';
import '../../../../../../core/common/spin_kit_loading.dart';
import '../../../../../../core/utils/date_converter.dart';

class Booking extends StatelessWidget {
   Booking({super.key,required this.id});
final int id;

  final _formKey=GlobalKey<FormState>();
  TextEditingController checkInController=TextEditingController();
  TextEditingController checkOutController=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: AppBarBackButton(),
      ),
      body: BlocListener<BookingBloc, BookingState>(
  listener: (context, state) {
    if(state is BookingLoadingState){
      _bookingDialog(context, "booking...");
    }
    else if(state is BookingSuccessState){
      context.pop();
      showBookedDialog(context);
    }
    else if(state is BookingErrorState){
      showErrorSnackBar(context, state.failure.message);
    }
  },
  child: Padding(
        padding: const EdgeInsets.all(5),
        child:Form(
          key:_formKey ,
          child:BlocBuilder<BookingBloc,BookingState>(
            buildWhen: (previous, current) => previous!=current,
            builder: (context, state) =>
        Column(
          children: [
            Expanded(
                child:
                ListView(
              padding: EdgeInsets.all(15),
              children: [
                SecctionHeader(title: tr("Booking Detail"), isSeeMore: false),
                Text(tr(
                    "Fill out the information below and confirm your booking. "),
                  style: Theme.of(context).textTheme.bodyMedium
                  !.copyWith(
                    fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),),
                SizedBox(height:28,),
                stepSutTitle(context, tr("Check-in"), true),
                SizedBox(height: 10,),
                CustomTextField(
                    enabled: true,
                    hintText:DateConverter().formatDateRange(DateTime.now().toString()),
                    surfixIcon:  GestureDetector(
                        onTap: ()async{
                          DateTime? time=  await showDatePicker(
                              context: context,
                              firstDate: DateTime.now(),
                              lastDate: DateTime(2060));
                          if(time!=null){
                            context.read<BookingBloc>().add(AddCheckInEvent(checkIn: time.toString()));
                            checkInController.text=DateConverter().formatDateRange(time.toString());
                          }
                        },
                        child: Icon(
                          Icons.calendar_month,
                          size: 20,
                          color: ColorConstant.secondBtnColor,
                        )),
                    textEditingController: checkInController,
                    onTextChnage: (value) {},
                    validator: (value) {
                      if(value!.isEmpty){
                        return "add checkIn";
                      }
                      return null;
                    },
                    isMultiLine: false,
                    textInputType: TextInputType.text),
                SizedBox(height:16),
                stepSutTitle(context, tr("Check-out"), true),
                SizedBox(height: 10,),
                CustomTextField(
                    hintText:DateConverter().formatDateRange(DateTime.now().toString()),
                    surfixIcon: GestureDetector(
                        onTap: ()async{
                          DateTime? time=  await showDatePicker(
                              context: context,
                              firstDate: DateTime.now(),
                              lastDate: DateTime(2060));
                          if(time!=null){
                            context.read<BookingBloc>().add(AddCheckOutEvent(checkOut: time.toString()));
                            checkOutController.text=DateConverter().formatDateRange(time.toString());
                          }
                        },
                        child: Icon(
                          size: 20,
                          Icons.calendar_month,
                          color: ColorConstant.secondBtnColor,
                        )),
                    validator: (value) {
                      if(value!.isEmpty){
                        return "add checkout";
                      }
                      return null;
                    },
                    onTextChnage: (value) {},
                    textEditingController: checkOutController,
                    isMultiLine: false,
                    textInputType: TextInputType.text),
                SizedBox(height:16),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child:stepSutTitle(context, tr("Select ID type you have"), true),
                ),
                SizedBox(height: 10,),
                GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                    mainAxisExtent: 60,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10),
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount:IdType.values.length,
                  itemBuilder: (context, index){
                    final id = IdType.values[index];
                  return   RadioListTile.adaptive(
                          activeColor: ColorConstant.primaryColor,
                          selectedTileColor: ColorConstant.primaryColor,
                          controlAffinity: ListTileControlAffinity.trailing,
                        title: Text(
                            id.name,
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                          useCupertinoCheckmarkStyle: true,
                          shape: OutlineInputBorder(
                            borderSide: BorderSide(color:state.idType.name==id.name?ColorConstant.primaryColor: ColorConstant.cardGrey),
                              borderRadius: BorderRadius.circular(10)),
                          value: id,
                          groupValue:state.idType,
                          onChanged: (value) {
                            context.read<BookingBloc>().add(AddIdEvent(id:id));
                          },


                    );
                  }

                ),
              ],
            ),),
                Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.all(15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                spacing: 15,
                children: [
                  Expanded(
                      child: CustomButton(
                          onPressed: () {
                            context.read<BookingBloc>().add(ResetBookingEvent());
                            context.pop();
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              elevation: 0,
                              padding: EdgeInsets.all(20),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  side: BorderSide(
                                      color: ColorConstant.secondBtnColor))),
                          child: Text(
                            tr("Cancel"),
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                    color: ColorConstant.secondBtnColor,
                                    fontWeight: FontWeight.w600),
                          ))),
                  Expanded(
                      child: CustomButton(
                          onPressed: () {
                            _formKey.currentState!.save();
                            if(_formKey.currentState!.validate()){
                              context.read<BookingBloc>().add(BookEvent(id: id));
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: ColorConstant.primaryColor,
                            elevation: 0,
                            padding: EdgeInsets.all(20),
                          ),
                          child: Text(
                            tr("Confirm Booking"),
                            textAlign: TextAlign.center,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600),
                          )))
                ],
              ),
            )
          ],
        ),
      ),)),
)
    );
  }

  Future<dynamic> showBookedDialog(BuildContext context) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
          backgroundColor: Colors.white,
          title: Text(
            tr('Book Pending'),
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
              spacing: 10,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  tr("You will get a call in a minute from the host or check booked menu for more information."),
                  textAlign: TextAlign.center,
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  child: CustomButton(
                      onPressed: () {
                        context.goNamed('booked');
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

  RichText stepSutTitle(BuildContext context, String title, bool isRequired) {
    return RichText(
        text: TextSpan(children: [
      TextSpan(
          text: title,
          style: Theme.of(context)
              .textTheme
              .bodyMedium!
              .copyWith(fontWeight: FontWeight.w500,fontSize: 14)),
      TextSpan(
          text: isRequired ? "*" : '(optional)',
          style: TextStyle(
              color: isRequired
                  ? ColorConstant.red
                  : ColorConstant.cardGrey.withValues(alpha: 0.5)))
    ]));
  }
   void _bookingDialog(BuildContext context,String title) {
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
}
