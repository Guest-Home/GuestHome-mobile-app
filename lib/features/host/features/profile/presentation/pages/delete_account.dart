import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minapp/features/auth/presentation/bloc/log_out/log_out_bloc.dart';

import '../../../../../../config/color/color.dart';
import '../../../../../../core/common/back_button.dart';
import '../../../../../../core/common/custom_button.dart';

class DeleteAccount extends StatelessWidget {
  const DeleteAccount({super.key});

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
    // TODO: implement listener
  },
  builder: (context, state) {
    return ListTile(
            title: Text(
              "Delete Account",
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .copyWith(fontWeight: FontWeight.w700,fontSize: 16),
            ),
            subtitle: Column(
              spacing: 15,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("delete your account and all the data"),
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
                        "Delete Account",
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
          height:80,
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
                      "Delete Account?",
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                    Icon(Icons.cancel_outlined,size: 15,)
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("This cant be undone."),
              ),
            ],
          ),
        ),
        actionsAlignment: MainAxisAlignment.end,
        contentPadding: EdgeInsets.all(0),
        actionsPadding: EdgeInsets.all(10),
        actions: [
          CustomButton(
              onPressed: () {},
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
          CustomButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.only(left: 4, right: 4),
                  backgroundColor: ColorConstant.red),
              child: Text("delete",
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    color: Colors.white,
                  )))
        ],
      ),
    );
  }
}
