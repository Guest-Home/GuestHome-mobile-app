
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minapp/core/common/loading_indicator_widget.dart';
import 'package:minapp/core/utils/date_converter.dart';
import 'package:minapp/features/host/features/profile/presentation/bloc/payment_setting_bloc/payment_setting_bloc.dart';

import '../../../../../../config/color/color.dart';
import '../../../../../../service_locator.dart';

class Commission extends StatelessWidget {
  const Commission({super.key});

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      backgroundColor: ColorConstant.primaryColor,
      color: Colors.white,
      onRefresh: ()async{
      //  context.read<PaymentSettingBloc>().add(GetPlatformCommissionEvent());
      },
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: true,
          // leading: AppBarBackButton(),
          title: Text(
            'Platform Commission',
            style: Theme.of(context)
                .textTheme
                .bodyLarge!
                .copyWith(fontWeight: FontWeight.bold),
          ),
        ),
        body:  SingleChildScrollView(
            padding: EdgeInsets.all(15),
            child:
            BlocProvider(
        create: (context) => sl<PaymentSettingBloc>()..add(GetPlatformCommissionEvent()),
        child: BlocBuilder<PaymentSettingBloc, PaymentSettingState>(
            builder: (context, state) {
              if(state is PlatformCommissionLoading || state is PaymentSettingError ||
                  state.platformCommissionEntity.currentCommissionRate==null
              ){
          return Center(child: loadingIndicator(),);
              }
              else if(state.platformCommissionEntity.currentCommissionRate!=null ||
                  state.platformCommissionEntity.currentCommissionRate!.isNotEmpty) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 10,
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
                      "Current Commission rate",
                      style: Theme
                          .of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                    ),
                    subtitle: Text(
                      "${state.platformCommissionEntity.currentCommissionRate}",
                      style: Theme
                          .of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(
                        fontWeight: FontWeight.w700,
                        fontSize: 30,
                      ),
                    ),

                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 6),
                child: Text("Commission breakdown", style: Theme
                    .of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: ColorConstant.inActiveColor.withValues(alpha: 0.8)
                ),),
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
                      "Last month summary",
                      style: Theme
                          .of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                    ),
                    subtitle: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Total booking", style: Theme
                                  .of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: ColorConstant.inActiveColor.withValues(
                                      alpha: 0.8)
                              ),),
                              Text(
                                "${state.platformCommissionEntity.commissionBreakdown!.totalBooking}",
                                style: Theme
                                    .of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Commission paid", style: Theme
                                  .of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: ColorConstant.inActiveColor.withValues(
                                      alpha: 0.8)
                              ),),
                              Text(
                                "${state.platformCommissionEntity.commissionBreakdown!.commissionPaid}",
                                style: Theme
                                    .of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 6),
                child: Text("Recent Commission history", style: Theme
                    .of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: ColorConstant.inActiveColor.withValues(alpha: 0.8)
                ),),
              ),
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                  side:state.platformCommissionEntity.recentCommissionHistory!.isEmpty?BorderSide.none: BorderSide(
                    color: ColorConstant.cardGrey,
                  ),
                ),
                elevation: 0,
                color: Colors.white,
                child: Padding(
                    padding: const EdgeInsets.all(4),
                    child: ListView.separated(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (context, index) =>
                            ListTile(
                              title: Text(
                                "Booking ID #${state.platformCommissionEntity.recentCommissionHistory![index].bookingId}",
                                style: Theme
                                    .of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                ),
                              ),
                              subtitle: Text(state.platformCommissionEntity.recentCommissionHistory![index].transactionDate.toString(), style: Theme
                                  .of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: ColorConstant.inActiveColor.withValues(
                                      alpha: 0.8)
                              ),),
                              trailing: Text(
                                "${state.platformCommissionEntity.recentCommissionHistory![index].amount} ETB",
                                style: Theme
                                    .of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 16,
                                ),
                              ),

                            ),
                        separatorBuilder: (context, index) =>
                            Divider(color: ColorConstant.cardGrey.withValues(
                                alpha: 0.6),),
                        itemCount:state.platformCommissionEntity.recentCommissionHistory!.length)
                ),
              ),
            ],
          );
              }
              return SizedBox.shrink();
            },
          ),
      ),
          ),

      ),
    );
  }
}
