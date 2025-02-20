import 'package:cached_network_image/cached_network_image.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:minapp/core/common/custom_text_field.dart';
import 'package:minapp/core/common/spin_kit_loading.dart';
import 'package:minapp/core/utils/show_snack_bar.dart';
import 'package:minapp/features/guest/features/booked/domain/entities/my_booking_entity.dart';
import 'package:minapp/features/guest/features/booked/presentation/bloc/guest_payment/guest_payment_bloc.dart';
import '../../../../../../config/color/color.dart';
import '../../../../../../core/common/custom_button.dart';
import '../../../../../../core/common/enum/payment_medthod.dart';
import '../../../../../../core/common/enum/reservation_status_enum.dart';
import '../../../../../../core/utils/get_token.dart';
import '../bloc/booked_bloc.dart';

class BookedCard extends StatelessWidget {
  BookedCard({
    super.key,
    required this.width,
    required this.height,
    required this.property,
  });

  final double width;
  final double? height;
  final ResultBookingEntity property;

  BookingStatus getStatus(String status) {
    switch (status) {
      case 'Waiting for Approval':
        return BookingStatus.pending;
      case 'Waiting For payment':
        return BookingStatus.waitingPayment;
      case 'Approved':
        return BookingStatus.approved;
      case 'Rejected':
        return BookingStatus.rejected;
      default:
        return BookingStatus.pending;
    }
  }

  Future<dynamic> showSucessdDialog(BuildContext context) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
          backgroundColor: Colors.white,
          title: Text(
            tr("Successfully Paid."),
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
                  tr("you will receive USSD payment dialog and please verify your payment"),
                  textAlign: TextAlign.center,
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  child: CustomButton(
                      onPressed: () {
                        context.pop();
                        context.read<BookedBloc>().add(GetMyBookingEvent());
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

  final TextEditingController phoneController = TextEditingController();
  final TextEditingController codeController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () async {
          final token = await GetToken().getUserToken();
          if (getStatus(property.status!) == BookingStatus.approved) {
            context.goNamed('bookedDetail',
                pathParameters: {'token': token}, extra: property.id);
          } else {
            context.goNamed('bookedDetailNonApproved',
                pathParameters: {'token': token}, extra: property);
          }
        },
        child: BlocListener<GuestPaymentBloc, GuestPaymentState>(
          listener: (context, state) {
            if (state is GuestReservationPaymentSuccess) {
              context.pop();
              showSucessdDialog(context);
            }
            else if (state is GuestPaymentError) {
              context.pop();
              showErrorSnackBar(context, state.failure.message);
            }
          },
          child: Container(
            width: width,
            height: MediaQuery.of(context).size.height * 0.5,
            margin: EdgeInsets.only(bottom: 30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 1,
              children: [
                Expanded(
                  child: AbsorbPointer(
                    absorbing: true,
                    child: CarouselView(
                        elevation: 0,
                        padding: EdgeInsets.all(0),
                        reverse: true,
                        backgroundColor: ColorConstant.cardGrey,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        itemExtent: MediaQuery.of(context).size.width,
                        children: List.generate(
                          property.house!.houseImage!.length,
                          (index) => ClipRRect(
                            child: CachedNetworkImage(
                              imageUrl:
                                  property.house!.houseImage![index].image!,
                              placeholder: (context, url) => Icon(
                                Icons.photo,
                                color: Colors.black12,
                              ),
                              errorWidget: (context, url, error) =>
                                  Icon(Icons.error),
                              fit: BoxFit.cover,
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height * 0.5,
                            ),
                          ),
                        )),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  spacing: 10,
                  children: [
                    Text(
                      property.house!.title!,
                      textAlign: TextAlign.start,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .copyWith(fontWeight: FontWeight.w700, fontSize: 14),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      spacing: 2,
                      children: [
                        Icon(
                          Icons.star,
                          size: 20,
                          color: ColorConstant.yellow,
                        ),
                        Text(
                          "${property.house!.postedBy!.rating}/5.0",
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall!
                              .copyWith(
                                  fontWeight: FontWeight.w700, fontSize: 13),
                        )
                      ],
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  spacing: 4,
                  children: [
                    Text(property.house!.subDescription!.toString(),
                        textAlign: TextAlign.start,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: ColorConstant.secondBtnColor
                                .withValues(alpha: 0.6))),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        RichText(
                            text: TextSpan(children: [
                          TextSpan(
                              text: tr("posted by"),
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                      color: ColorConstant.secondBtnColor
                                          .withValues(alpha: 0.6))),
                          TextSpan(
                              text:
                                  " @${property.house!.postedBy!.userAccount!.firstName} ${property.house!.postedBy!.userAccount!.lastName}",
                              style: TextStyle(
                                  color: ColorConstant.secondBtnColor
                                      .withValues(alpha: 1)))
                        ])),
                        RichText(
                            text: TextSpan(children: [
                          TextSpan(
                              text:
                                  "${property.house!.price} ${tr(property.house!.unit!)} ",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700,
                                      color: ColorConstant.secondBtnColor)),
                          TextSpan(
                              text: tr("/ ${tr("day")}"),
                              style: TextStyle(
                                  color: ColorConstant.secondBtnColor
                                      .withValues(alpha: 0.7))),
                        ])),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      spacing: 5,
                      children: [
                        Icon(
                          Icons.location_pin,
                          size: 21,
                          color: ColorConstant.secondBtnColor,
                        ),
                        Expanded(
                          child: Text(
                            "${tr(property.house!.city!)}, ${property.house!.specificAddress!}",
                            textAlign: TextAlign.start,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall!
                                .copyWith(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 12,
                                    color: ColorConstant.secondBtnColor),
                          ),
                        ),
                        SizedBox(width: 10,),
                        if (property.assignedRoom != null)
                          RichText(
                              text: TextSpan(children: [
                                TextSpan(
                                  text: tr("Room number"),
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(
                                      fontWeight: FontWeight.w500, fontSize: 12),
                                ),
                                TextSpan(
                                  text:" ${property.assignedRoom}",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14,
                                      color: ColorConstant.primaryColor),
                                )
                              ])),
                      ],
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 3),
                  child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          spacing: 10,
                          children: [
                            Text(
                              tr("Booking Status"),
                              textAlign: TextAlign.start,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12),
                            ),
                          StatusButton(
                                status: getStatus(property.status.toString()),
                              ),

                          ],
                        ),

                ),
                if(!property.house!.postedBy!.isPaymentRequired! &&
                   (getStatus(property.status!) == BookingStatus.pending ||
                    getStatus(property.status!) == BookingStatus.approved))
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal:3),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        tr("Booking Payment"),
                        textAlign: TextAlign.start,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(fontWeight: FontWeight.w700, fontSize: 12),
                      ),
                      Text(
                        tr("Your will pay on arrival. "),
                        textAlign: TextAlign.start,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(fontWeight: FontWeight.w400, fontSize: 12,color: ColorConstant.secondBtnColor
                                    .withValues(alpha: 0.8)),
                      ),

                    ],
                  ),
                ),
                if(property.house!.postedBy!.isPaymentRequired! &&
                    getStatus(property.status!) == BookingStatus.approved)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal:3),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          tr("Booking Payment"),
                          textAlign: TextAlign.start,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(fontWeight: FontWeight.w700, fontSize: 12),
                        ),
                        Text(
                          tr("You have Paid Successfully"),
                          textAlign: TextAlign.start,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(fontWeight: FontWeight.w400, fontSize: 12,color: ColorConstant.secondBtnColor
                              .withValues(alpha: 0.8)),
                        ),

                      ],
                    ),
                  ),
                if (property.house!.postedBy!.isPaymentRequired! && getStatus(property.status!) == BookingStatus.waitingPayment )
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 3),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          tr("Booking Payment"),
                          textAlign: TextAlign.start,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(
                                  fontWeight: FontWeight.w700, fontSize: 12),
                        ),
                        Text(
                          tr("Please pay your booking payment under 1 hour"),
                          textAlign: TextAlign.start,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 12,
                                  color: ColorConstant.secondBtnColor
                                      .withValues(alpha: 0.8)),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: CustomButton(
                              onPressed: () {
                            showModalBottomSheet(
                                  context: context,
                                  showDragHandle: true,
                                  isScrollControlled: true,
                                  builder: (context) => Container(
                                    width: MediaQuery.of(context).size.width,
                                    height: MediaQuery.of(context).size.height*0.7,
                                    padding: EdgeInsets.all(15),
                                    child: BlocBuilder<GuestPaymentBloc,
                                        GuestPaymentState>(
                                      builder: (context, state) {
                                        return Form(
                                        key: _formKey,
                                            child:SingleChildScrollView(
                                            child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            spacing: 10,
                                            children: [
                                              Text(
                                                tr("Booking Payment"),
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyLarge!
                                                    .copyWith(
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontSize: 16),
                                              ),
                                              SizedBox(height: 10,),
                                              RichText(
                                                  text: TextSpan(children: [
                                                    TextSpan(
                                                      text: tr("Choose Payment method"),
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodyMedium!
                                                          .copyWith(fontWeight: FontWeight.w500),
                                                    ),
                                                    TextSpan(
                                                        text: "*",
                                                        style: TextStyle(color: ColorConstant.red))
                                                  ])),
                                              ListView.builder(
                                                  shrinkWrap: true,
                                                  physics:
                                                      NeverScrollableScrollPhysics(),
                                                  itemCount:
                                                      PaymentMethod.values.length,
                                                  itemBuilder: (context, index) {
                                                    final id = PaymentMethod
                                                        .values[index];
                                                    return Padding(
                                                      padding: EdgeInsets.only(
                                                          bottom: 10),
                                                      child:
                                                          RadioListTile.adaptive(
                                                        activeColor: ColorConstant
                                                            .primaryColor,
                                                        selectedTileColor:
                                                            ColorConstant
                                                                .primaryColor,
                                                        controlAffinity:
                                                            ListTileControlAffinity
                                                                .trailing,
                                                        title: Text(
                                                          tr(id.name),
                                                          style: Theme.of(context)
                                                              .textTheme
                                                              .bodySmall,
                                                        ),
                                                        useCupertinoCheckmarkStyle:
                                                            true,
                                                        shape: OutlineInputBorder(
                                                            borderSide: BorderSide(
                                                                color: state.paymentMethod
                                                                            .name ==
                                                                        id.name
                                                                    ? ColorConstant
                                                                        .primaryColor
                                                                    : ColorConstant
                                                                        .cardGrey),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10)),
                                                        value: id,
                                                        groupValue:
                                                            state.paymentMethod,
                                                        onChanged: (value) {
                                                          context
                                                              .read<
                                                                  GuestPaymentBloc>()
                                                              .add(AddGuestPaymentMethodEvent(
                                                                  paymentMethod:
                                                                      id));
                                                        },
                                                      ),
                                                    );
                                                  }),
                                              RichText(
                                                  text: TextSpan(children: [
                                                    TextSpan(
                                                      text: tr("Enter phone number associated with selected payment"),
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodyMedium!
                                                          .copyWith(fontWeight: FontWeight.w500),
                                                    ),
                                                    TextSpan(
                                                        text: " (optional)",
                                                        style: TextStyle(color: ColorConstant.secondBtnColor.withValues(alpha: 0.7)))
                                                  ])),
                                              CustomTextField(
                                                  hintText: tr("phone number"),
                                                  textEditingController: phoneController,
                                                  surfixIcon: null,
                                                  prifixIcon: CountryCodePicker(
                                                    onChanged: (value) {
                                                      codeController.text =
                                                          value.dialCode.toString().substring(1);
                                                    },
                                                    initialSelection: 'ET',
                                                    favorite: ['+251', 'ET'],
                                                    onInit: (value) {
                                                      codeController.text =
                                                          value!.dialCode.toString().substring(1);
                                                    },
                                                    showCountryOnly: false,
                                                    showDropDownButton: false,
                                                    alignLeft: false,
                                                    showFlag: true,
                                                    backgroundColor: Colors.white,
                                                    flagDecoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                    ),
                                                  ),
                                                  onTextChnage: (value) {},
                                                  validator: (value) {
                                                    // if(value!.isEmpty){
                                                    //   return "please add phone number";
                                                    // }
                                                    return null;
                                                  },
                                                  isMultiLine: false,
                                                  textInputType: TextInputType.phone),
                                              Container(
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                padding: EdgeInsets.symmetric(vertical: 15),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  spacing: 15,
                                                  children: [
                                                    Expanded(
                                                        child: CustomButton(
                                                            onPressed: state
                                                                    is GuestReservationPaymentLoading
                                                                ? () {}
                                                                : () {
                                                                    context.pop();
                                                                  },
                                                            style: ElevatedButton.styleFrom(
                                                                backgroundColor:
                                                                    Colors.white,
                                                                elevation: 0,
                                                                padding:
                                                                    EdgeInsets
                                                                        .all(20),
                                                                shape: RoundedRectangleBorder(
                                                                    borderRadius:
                                                                        BorderRadius
                                                                            .circular(
                                                                                15),
                                                                    side: BorderSide(
                                                                        color: ColorConstant
                                                                            .secondBtnColor))),
                                                            child: Text(
                                                              tr("Cancel"),
                                                              textAlign: TextAlign
                                                                  .center,
                                                              maxLines: 2,
                                                              style: Theme.of(
                                                                      context)
                                                                  .textTheme
                                                                  .bodyMedium!
                                                                  .copyWith(
                                                                      color: ColorConstant
                                                                          .secondBtnColor,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600),
                                                            ))),
                                                    Expanded(
                                                        child: CustomButton(
                                                            onPressed: state is GuestReservationPaymentLoading
                                                                ? () {}
                                                                : () {
                                                              _formKey.currentState!.save();
                                                              if (_formKey.currentState!.validate()) {
                                                                context
                                                                    .read<GuestPaymentBloc>()
                                                                    .add(MakeReservationPaymentEvent(
                                                                  phone: phoneController
                                                                      .text.isNotEmpty
                                                                      ? codeController.text +
                                                                      phoneController.text
                                                                      : "",
                                                                  id: property.id!,
                                                                ));
                                            
                                                              }
                                                            },
                                                            style: ElevatedButton
                                                                .styleFrom(
                                                              backgroundColor:
                                                                  ColorConstant
                                                                      .primaryColor,
                                                              elevation: 0,
                                                              padding:
                                                                  EdgeInsets.all(
                                                                      20),
                                                            ),
                                                            child:state is GuestReservationPaymentLoading?loading:Text(
                                                              tr("Proceed"),
                                                              style: Theme.of(
                                                                      context)
                                                                  .textTheme
                                                                  .bodyMedium!
                                                                  .copyWith(
                                                                      color: Colors
                                                                          .white,
                                                                      fontSize:
                                                                          14,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600),
                                                            ))),
                                                  ],
                                                ),
                                              )
                                            ],
                                                                                    ),
                                          ));
                                      },
                                    ),
                                  ),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                  elevation: 0,
                                  padding: EdgeInsets.all(0),
                                  foregroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      side: BorderSide(
                                          color:
                                              ColorConstant.secondBtnColor))),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                spacing: 10,
                                children: [
                                  Icon(
                                    Icons.currency_exchange,
                                    color: ColorConstant.secondBtnColor,
                                  ),
                                  Text(
                                    tr("Make payment"),
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(fontWeight: FontWeight.bold),
                                  ),
                                ],
                              )),
                        )
                      ],
                    ),
                  ),
                  Divider(
                  color: ColorConstant.cardGrey,
                ),
              ],
            ),
          ),
        ));
  }

}

class StatusButton extends StatelessWidget {
  const StatusButton({super.key, required this.status});
  final BookingStatus status;

  @override
  Widget build(BuildContext context) {
    return AbsorbPointer(
      absorbing: true,
      child: CustomButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: status.backgroundColor.withValues(alpha: 0.2),
          padding: EdgeInsets.symmetric(horizontal: 10),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
        ),
        child: Text(
          tr(status.status),
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
              color: status.backgroundColor,
              fontWeight: FontWeight.w700,
              fontSize: 12),
        ),
      ),
    );
  }
}
