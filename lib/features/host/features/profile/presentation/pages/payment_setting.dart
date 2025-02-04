import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:minapp/core/common/custom_button.dart';
import 'package:minapp/features/host/features/profile/presentation/bloc/payment_setting_bloc/payment_setting_bloc.dart';
import 'package:minapp/features/host/features/profile/presentation/bloc/profile_bloc.dart';
import '../../../../../../config/color/color.dart';
import '../../../../../../service_locator.dart';

class PaymentSetting extends StatelessWidget {
  const PaymentSetting({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        // leading: AppBarBackButton(),
        title: Text(
          'Payment Setting',
          style: Theme.of(context)
              .textTheme
              .bodyLarge!
              .copyWith(fontWeight: FontWeight.bold),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: ()async{
          context.read<ProfileBloc>().add(GetUserProfileEvent());

        },
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Column(
            spacing: 15,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                  side: BorderSide(
                    color: ColorConstant.cardGrey,
                  ),
                ),
                elevation: 0,
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(4),
                  child: ListTile(
                    title: Text(
                      "Platform payment system",
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                          ),
                    ),
                    subtitle: Text(
                      "Accept payments though platform",
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                          color:
                              ColorConstant.inActiveColor.withValues(alpha: 0.5)),
                    ),
                    trailing:
                        BlocBuilder<PaymentSettingBloc, PaymentSettingState>(
                      buildWhen: (previous, current) =>
                          previous.isAcceptingPayment !=
                          current.isAcceptingPayment,
                      builder: (context, state) {
                        return Switch.adaptive(
                          value: state.isAcceptingPayment,
                          onChanged: (value) {
                            context
                                .read<PaymentSettingBloc>()
                                .add(IsAcceptingPaymentEvent(isAccepting: value));
                          },
                          activeColor: Colors.white,
                          activeTrackColor: ColorConstant.green,
                        );
                      },
                    ),
                  ),
                ),
              ),
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                  side: BorderSide(
                    color: ColorConstant.cardGrey,
                  ),
                ),
                elevation: 0,
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(4),
                  child: ListTile(
                    title: Text(
                      "Current Deposit",
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                          ),
                    ),
                    subtitle: Column(
                      spacing: 15,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 1,
                        ),
                        BlocBuilder<ProfileBloc, ProfileState>(
                          builder: (context, state) {
                            if(state is ProfileErrorState || state.userProfileEntity.id==null){
                            return SizedBox();
                            }
                          return RichText(
                                  text: TextSpan(children: [
                                    TextSpan(
                                      text:"${state.userProfileEntity.points}",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium!
                                          .copyWith(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 25,
                                      ),
                                    ),
                                    TextSpan(
                                      text: " ETB",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium!
                                          .copyWith(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 13,
                                      ),
                                    ),
                                  ]));
                          },
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: CustomButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: ColorConstant.primaryColor,
                              ),
                              onPressed: () => context.goNamed('addFunds'),
                              child: Text(
                                "Add Funds",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500),
                              )),
                        ),
                        GestureDetector(
                          onTap: () => context.goNamed('depositHistory'),
                          child: Text("Deposit  history ",style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: ColorConstant.primaryColor,
                            fontWeight: FontWeight.w600
                          ),),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                  side: BorderSide(
                    color: ColorConstant.cardGrey,
                  ),
                ),
                elevation: 0,
                color: Colors.white,
                child: Padding(
                    padding: const EdgeInsets.all(4),
                    child: Row(
                      children: [
                        Expanded(
                          child: ListTile(
                            title: Text(
                              "Platform Commission",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14,
                                  ),
                            ),
                            subtitle: BlocProvider(
                              create: (context) => sl<PaymentSettingBloc>()
                                ..add(GetPlatformCommissionEvent()),
                              child: BlocBuilder<PaymentSettingBloc,
                                  PaymentSettingState>(
                                builder: (context, state) {
                                return Text(
                                      "Current rate: ${state.platformCommissionEntity.currentCommissionRate??0}",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium!
                                          .copyWith(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 14,
                                              color: ColorConstant.inActiveColor
                                                  .withValues(alpha: 0.5)),
                                    );

                                },
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () => context.goNamed('commission'),
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              spacing: 4,
                              children: [
                                Text(
                                  "View details",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall!
                                      .copyWith(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                          color: ColorConstant.primaryColor),
                                ),
                                Icon(
                                  Icons.arrow_forward_ios,
                                  size: 17,
                                  color: ColorConstant.primaryColor,
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        )
                      ],
                    )),
              ),
              // Card(
              //   shape: RoundedRectangleBorder(
              //     borderRadius: BorderRadius.circular(10),
              //     side: BorderSide(
              //       color: ColorConstant.cardGrey,
              //     ),
              //   ),
              //   elevation: 0,
              //   color: Colors.white,
              //   child: Padding(
              //       padding: const EdgeInsets.all(4),
              //       child: Row(
              //         children: [
              //           Expanded(
              //             child: ListTile(
              //               title: Text(
              //                 "Payment Notification",
              //                 style: Theme.of(context)
              //                     .textTheme
              //                     .bodyMedium!
              //                     .copyWith(
              //                   fontWeight: FontWeight.w600,
              //                   fontSize: 14,
              //                 ),
              //               ),
              //               subtitle: Text(
              //                 "Configure alerts and reminders",
              //                 style: Theme.of(context)
              //                     .textTheme
              //                     .bodyMedium!
              //                     .copyWith(
              //                     fontWeight: FontWeight.w500,
              //                     fontSize: 14,
              //                     color: ColorConstant.inActiveColor
              //                         .withValues(alpha: 0.5)),
              //               ),
              //             ),
              //           ),
              //           Center(
              //             child: Row(
              //               mainAxisAlignment: MainAxisAlignment.end,
              //               spacing: 4,
              //               children: [
              //                 Text(
              //                   "Configure",
              //                   style: Theme.of(context)
              //                       .textTheme
              //                       .bodySmall!
              //                       .copyWith(
              //                       fontSize: 12,
              //                       fontWeight: FontWeight.w600,
              //                       color: ColorConstant.primaryColor),
              //                 ),
              //                 Icon(Icons.arrow_forward_ios,size: 17,color: ColorConstant.primaryColor,),
              //               ],
              //             ),
              //           ),
              //           SizedBox(width: 10,)
              //         ],
              //       )),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
