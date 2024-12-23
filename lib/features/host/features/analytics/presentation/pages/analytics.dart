import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:minapp/config/color/color.dart';
import '../widgets/analytics_chart.dart';

class Analytics extends StatefulWidget {
  const Analytics({super.key});

  @override
  State<Analytics> createState() => _AnalyticsState();
}

class _AnalyticsState extends State<Analytics> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text(
            'Analytics',
            style: Theme.of(context)
                .textTheme
                .bodyLarge!
                .copyWith(fontWeight: FontWeight.bold),
          ),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 15,
            children: [
              sectionTitle(context, 'General Metrics'),
              Container(
                width: 200,
                height: 100,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: ColorConstant.primaryColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ListTile(
                  title: Text(
                    'Total Properties',
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: Colors.white,
                        ),
                  ),
                  subtitle: Text(
                    '10',
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                ),
              ),
              SizedBox(
                height: 30,
                width: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: ListView.builder(
                        itemCount: 5,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) => Container(
                          width: 55,
                          margin: const EdgeInsets.only(right: 6),
                          padding: EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: index == 0
                                ? ColorConstant.secondBtnColor
                                : ColorConstant.cardGrey,
                            borderRadius: BorderRadius.circular(40),
                          ),
                          child: Center(
                            child: Text("7 days",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall!
                                    .copyWith(
                                      color: index == 0
                                          ? Colors.white
                                          : ColorConstant.secondBtnColor,
                                    )),
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        if (Platform.isAndroid) {
                          showDateRangePicker(
                              barrierLabel: "Custom",
                              context: context,
                              barrierColor: ColorConstant.primaryColor,
                              firstDate: DateTime.now(),
                              lastDate: DateTime.now(),
                              initialDateRange: DateTimeRange(
                                  start: DateTime.now(), end: DateTime.now()));
                        } else {
                          CupertinoDatePicker(
                            mode: CupertinoDatePickerMode.date,
                            initialDateTime: DateTime.now(),
                            onDateTimeChanged: (DateTime value) {
                              print(value);
                            },
                          );
                        }
                      },
                      child: Container(
                        width: 80,
                        margin: const EdgeInsets.only(right: 6),
                        padding: EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: ColorConstant.cardGrey,
                          borderRadius: BorderRadius.circular(40),
                        ),
                        child: Center(
                          child: Row(
                            children: [
                              Expanded(
                                child: Text("Custom",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall!
                                        .copyWith()),
                              ),
                              Icon(Icons.arrow_drop_down)
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              sectionTitle(context, 'Key Metrics'),
              Wrap(
                children: [
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: BorderSide(
                        color: ColorConstant.primaryColor,
                      ),
                    ),
                    elevation: 0,
                    color: ColorConstant.cardGrey.withValues(alpha: 0.5),
                    child: SizedBox(
                      width: 150,
                      height: 80,
                      child: Padding(
                        padding: const EdgeInsets.all(14),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Revenue",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(
                                      color: ColorConstant.secondBtnColor
                                          .withValues(alpha: 0.5),
                                    )),
                            Text("34,000 ETB",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                      color: ColorConstant.secondBtnColor
                                          .withValues(),
                                    )),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Card(
                    elevation: 0,
                    color: ColorConstant.cardGrey.withValues(alpha: 0.5),
                    child: SizedBox(
                      width: 150,
                      height: 80,
                      child: Padding(
                        padding: const EdgeInsets.all(14),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Active Bookings",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(
                                      color: ColorConstant.secondBtnColor
                                          .withValues(alpha: 0.5),
                                    )),
                            Text("20",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: ColorConstant.secondBtnColor
                                          .withValues(),
                                    )),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Card(
                    elevation: 0,
                    color: ColorConstant.cardGrey.withValues(alpha: 0.5),
                    child: SizedBox(
                      width: 150,
                      height: 80,
                      child: Padding(
                        padding: const EdgeInsets.all(14),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Occupancy Rate",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(
                                      color: ColorConstant.secondBtnColor
                                          .withValues(alpha: 0.5),
                                    )),
                            Text("82 %",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                      color: ColorConstant.secondBtnColor
                                          .withValues(),
                                    )),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
              Container(
                height: 300,
                width: double.infinity,
                padding: const EdgeInsets.all(15),
                child: AnalyticsChart(),
              ),
              sectionTitle(context, "Report"),
              ListTile(
                title: Text(
                  "This is report of your property performance over time. you can download and review in PDF.",
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                subtitle: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                        backgroundColor: ColorConstant.secondBtnColor,
                        padding: EdgeInsets.all(10),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10))),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.download,
                          color: Colors.white,
                        ),
                        Text(
                          "Download",
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(color: Colors.white),
                        )
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ));
  }

  Text sectionTitle(BuildContext context, String title) {
    return Text(
      title,
      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
            fontWeight: FontWeight.bold,
          ),
    );
  }
}
