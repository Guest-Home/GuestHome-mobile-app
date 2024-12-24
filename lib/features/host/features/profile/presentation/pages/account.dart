import 'package:flutter/material.dart';
import 'package:minapp/core/common/back_button.dart';
import 'package:minapp/core/common/custom_button.dart';

import '../../../../../../config/color/color.dart';

class Account extends StatelessWidget {
  const Account({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          leading: AppBarBackButton(),
          leadingWidth: 27,
          title: Text(
            'Account',
            style: Theme.of(context)
                .textTheme
                .bodyLarge!
                .copyWith(fontWeight: FontWeight.bold),
          ),
        ),
        body: ListTile(
          title: Text(
            "Delete Account",
            style: Theme.of(context)
                .textTheme
                .bodyLarge!
                .copyWith(fontWeight: FontWeight.bold),
          ),
          subtitle: Column(
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
        title: Text(
          "Delete Account?",
          style: Theme.of(context)
              .textTheme
              .bodyMedium!
              .copyWith(fontWeight: FontWeight.bold),
        ),
        content: Text("This cant be undone."),
        actionsAlignment: MainAxisAlignment.end,
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
