import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:minapp/core/utils/show_snack_bar.dart';
import 'package:minapp/features/auth/presentation/bloc/log_out/log_out_bloc.dart';

import '../../../../../../config/color/color.dart';
import '../../../../../../core/common/back_button.dart';
import '../../../../../../core/common/custom_button.dart';
import '../../../../../../core/common/spin_kit_loading.dart';

class DeleteAccount extends StatelessWidget {
  const DeleteAccount({super.key});

  void _deletingDialog(BuildContext context,String title) {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          leading: AppBarBackButton(),
          title: Text(
            'Account',
            style: Theme.of(context)
                .textTheme
                .bodyLarge!
                .copyWith(fontWeight: FontWeight.bold),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child:
          BlocConsumer<LogOutBloc, LogOutState>(
  listener: (context, state) {
    if(state is DeactivateLoadingState){
      context.pop();
      _deletingDialog(context, "deactivating account");
    }
    if(state is DeactivatedState){
      context.pop();
      showSuccessSnackBar(context, 'your account is deactivated');
        context.pushNamed('signIn');

    }
  },
  builder: (context, state) {
    return ListTile(
            title: Text(
              "Deactivate Account",
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .copyWith(fontWeight: FontWeight.w700,fontSize: 16),
            ),
            subtitle: Column(
              spacing: 15,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Deactivating will hide your profile and save your data Reactivate anytime by logging back in.",style:
                  Theme.of(context).textTheme.bodyMedium!.copyWith(
                    fontSize: 14,fontWeight: FontWeight.w400
                  ),),
                SizedBox(
                  width: 200,
                  child: CustomButton(
                      onPressed: () {
                        _showDeleteDialog(context);
                      },
                      style: ElevatedButton.styleFrom(
                          elevation: 0,
                          padding: EdgeInsets.all(1),
                          side: BorderSide(color: ColorConstant.red),
                          backgroundColor: Colors.white),
                      child: Text(
                        "Deactivate Account",
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            color: ColorConstant.red,
                            fontWeight: FontWeight.bold),
                      )),
                )
              ],
            ),
          );
  },
),
        ));
  }

  void _showDeleteDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        content:
        SizedBox(
          height: 120,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.all(9),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: ColorConstant.cardGrey,
                    borderRadius: BorderRadius.only(topRight: Radius.circular(10),topLeft: Radius.circular(10))
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Deactivate Account?",
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                    Icon(Icons.cancel_outlined,size: 15,)
                  ],
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("are you sure you want to deactivate your account? you\n can reactivate it anytime by logging back in. ",style:
                  Theme.of(context).textTheme.bodyMedium!.copyWith(
                      fontSize:12,fontWeight: FontWeight.w400
                  ),),
                ),
              ),
            ],
          ),
        ),
        actionsAlignment: MainAxisAlignment.end,
        contentPadding: EdgeInsets.all(0),
        actionsPadding: EdgeInsets.all(10),
        actions: [
          CustomButton(
              onPressed: () {context.pop();},
              style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.all(0.5),
                  side: BorderSide(
                      color:
                      ColorConstant.secondBtnColor.withValues(alpha: 0.5)),
                  backgroundColor: Colors.white),
              child: Text("Cancel",
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    color: ColorConstant.secondBtnColor,
                  ))),
          BlocBuilder<LogOutBloc, LogOutState>(
  builder: (context, state) {
    return CustomButton(
              onPressed: () {
                context.read<LogOutBloc>().add(DeactivateEvent());
              },
              style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.only(left: 4, right: 4),
                  backgroundColor: ColorConstant.red),
              child: Text("Deactivate",
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    color: Colors.white,
                  )));
  },
)
        ],
      ),
    );
  }
}
