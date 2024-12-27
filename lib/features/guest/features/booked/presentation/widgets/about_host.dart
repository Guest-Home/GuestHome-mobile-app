import 'package:flutter/material.dart';

import '../../../../../../config/color/color.dart';
import '../../../../../../core/common/custom_button.dart';

class AboutHostCard extends StatelessWidget {
  const AboutHostCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: Colors.white,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: BorderSide(color: Colors.white)),
      child: Column(
        spacing: 10,
        children: [
          ListTile(
            leading: CircleAvatar(),
            title: Text("Aman Root"),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              spacing: 10,
              children: [
                Text("Phone Number:"),
                Text(
                  "098765432",
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(fontWeight: FontWeight.bold),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              spacing: 10,
              children: [
                Text("Telegram UserName:"),
                Text(
                  "@Amanroot",
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(fontWeight: FontWeight.bold),
                )
              ],
            ),
          ),
          Row(
            spacing: 10,
            children: [
              Expanded(
                  child: CustomButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                          elevation: 0,
                          backgroundColor: ColorConstant.green,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(100),
                          )),
                      child: Text(
                        "Call",
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(color: Colors.white),
                      ))),
              Expanded(
                  child: CustomButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                          elevation: 0,
                          backgroundColor: ColorConstant.primaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(100),
                          )),
                      child: Text(
                        "Sms",
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(color: Colors.white),
                      ))),
            ],
          ),
        ],
      ),
    );
  }
}
