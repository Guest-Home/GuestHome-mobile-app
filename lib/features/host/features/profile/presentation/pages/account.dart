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
                    onPressed: () {},
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
}
