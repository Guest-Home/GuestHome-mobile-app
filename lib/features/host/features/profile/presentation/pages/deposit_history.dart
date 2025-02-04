
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:minapp/core/common/spin_kit_loading.dart';
import 'package:minapp/core/utils/date_converter.dart';
import 'package:minapp/features/host/features/profile/presentation/bloc/deposit_transaction_bloc/deposit_transaction_bloc.dart';
import '../../../../../../config/color/color.dart';
import '../../../../../../core/common/custom_button.dart';
import '../bloc/profile_bloc.dart';

class DepositHistory extends StatefulWidget {
  const DepositHistory({super.key});

  @override
  State<DepositHistory> createState() => _DepositHistoryState();
}

class _DepositHistoryState extends State<DepositHistory> {

  @override
  void initState() {
    super.initState();
    context.read<DepositTransactionBloc>().add(GetDepositTransactionEvent());

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        // leading: AppBarBackButton(),
        title: Text(
          'Deposit History',
          style: Theme.of(context)
              .textTheme
              .bodyLarge!
              .copyWith(fontWeight: FontWeight.bold),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: ()async{
          context.read<ProfileBloc>().add(GetUserProfileEvent());
          context.read<DepositTransactionBloc>().add(GetDepositTransactionEvent());
        },
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 15,
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
                      "Current Deposit",
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                    ),
                    subtitle: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: BlocBuilder<ProfileBloc, ProfileState>(
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
                        ),
                        SizedBox(
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
                      ],
                    ),
                  ),
                ),
              ),
              Text(
                "Deposit History ",
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                    color:
                    ColorConstant.inActiveColor.withValues(alpha: 0.5)),
              ),
              Expanded(
                child: BlocBuilder<DepositTransactionBloc, DepositTransactionState>(
  builder: (context, state) {
    if(state is DepositTransactionLoading || state.depositTransactionEntity.results==null){
      return Center(child:RepaintBoundary(child: CupertinoActivityIndicator(),),);
    }
    if(state.depositTransactionEntity.results!=null && state.depositTransactionEntity.results!.isEmpty){
      return Center(child: Text("no transaction yet!"),);
    }
    return NotificationListener<ScrollNotification>(
      onNotification: (scrollInfo) {
        if (scrollInfo.metrics.pixels ==
            scrollInfo.metrics.maxScrollExtent) {
          context.read<DepositTransactionBloc>().add(LoadMoreDepositTransactionEvent());
        }
        return false;
      },
      child: ListView.builder(
                    itemCount:state.depositTransactionEntity.results!.length+
                        (state is DepositTransactionLoadingMoreState
                            ? 1
                            : 0),
                      itemBuilder: (context, index){
                        if (index >=
                            state
                                .depositTransactionEntity.results!.length) {
                          return Center(
                              child: loadingWithPrimary);
                        }
                      return  Card(
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
                              leading:state.depositTransactionEntity.results![index].typeOfTransaction=='deposit'?
                              Icon(Icons.download,color: ColorConstant.green,):
                              Icon(Icons.upload,color: ColorConstant.red,),
                              title: Text(state.depositTransactionEntity.results![index].typeOfTransaction!,
                                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                ),
                              ),
                              subtitle: Text(DateConverter().formatDateRange(state.depositTransactionEntity.results![index].timeStamp!),
                                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14,
                                    color:
                                    ColorConstant.inActiveColor.withValues(alpha: 0.5)),
                              ),
                              trailing:Text("${state.depositTransactionEntity.results![index].amount} ETB",style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                                  color: ColorConstant.primaryColor,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14
                              ),)
                          ),
                        ),
                      );

                      }

    ),
    );
  },
),
              )
            ],
          ),
        ),
      ),
    );
  }
}
