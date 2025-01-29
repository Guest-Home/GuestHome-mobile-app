import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:minapp/config/color/color.dart';
import 'package:minapp/core/common/loading_indicator_widget.dart';
import 'package:minapp/core/common/spin_kit_loading.dart';
import 'package:minapp/core/utils/date_converter.dart';
import 'package:minapp/core/utils/show_snack_bar.dart';
import 'package:minapp/features/host/features/analytics/presentation/bloc/analytics_bloc.dart';
import 'package:minapp/features/host/features/analytics/presentation/bloc/total_property_bloc.dart';
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
        body: RefreshIndicator(
          onRefresh: () async {
            context.read<AnalyticsBloc>().add(GetOccupancyRateEvent());
            context.read<TotalPropertyBloc>().add(GetTotalPropertyEvent());
          },
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 15,
              children: [
                sectionTitle(context, 'General Metrics'),
                BlocBuilder<TotalPropertyBloc, TotalPropertyState>(
                  buildWhen: (previous, current) =>
                      previous.totalProperty != current.totalProperty,
                  builder: (context, state) {
                    return Container(
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
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14),
                        ),
                        subtitle: Text(
                          state.totalProperty.totalNumberOfProperty.toString(),
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 20),
                        ),
                      ),
                    );
                  },
                ),
                // days
                SizedBox(
                  height: 40,
                  width: double.infinity,
                  child: Row(
                    children: [
                      Expanded(
                        child: BlocBuilder<AnalyticsBloc, AnalyticsState>(
                          buildWhen: (previous, current) =>
                              previous.selectedDate != current.selectedDate,
                          builder: (context, state) {
                            return ListView.separated(
                              itemCount: state.occupancyDate.length,
                              scrollDirection: Axis.horizontal,
                              separatorBuilder: (context, index) => SizedBox(
                                width: 4,
                              ),
                              itemBuilder: (context, index) => GestureDetector(
                                onTap: () {
                                  context.read<AnalyticsBloc>().add(
                                      ChangeOccupancyDateEvent(
                                          date: state.occupancyDate[index]));
                                },
                                child: AnimatedContainer(
                                  duration: const Duration(milliseconds: 10),
                                  margin: const EdgeInsets.only(right: 6),
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: state.selectedDate ==
                                            state.occupancyDate[index]
                                        ? ColorConstant.secondBtnColor
                                        : ColorConstant.cardGrey,
                                    borderRadius: BorderRadius.circular(40),
                                  ),
                                  child: Center(
                                    child: Text(state.occupancyDate[index],
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall!
                                            .copyWith(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500,
                                              color: state.selectedDate ==
                                                      state.occupancyDate[index]
                                                  ? Colors.white
                                                  : ColorConstant
                                                      .secondBtnColor,
                                            )),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      GestureDetector(
                        onTap: () async {
                          DateTimeRange? dateRange =
                              await buildShowDateRangePicker(context);
                          if (dateRange != null) {
                            context
                                .read<AnalyticsBloc>()
                                .add(AddCustomDateEvent(
                                  startDate: DateConverter().formatDateRange(
                                      dateRange.start.toString()),
                                  endDate: DateConverter().formatDateRange(
                                      dateRange.end.toString()),
                                ));
                            context
                                .read<AnalyticsBloc>()
                                .add(GetCustomOccupancyEvent());
                          }
                        },
                        child: Container(
                          width: 100,
                          margin: const EdgeInsets.only(right: 6),
                          padding: EdgeInsets.symmetric(horizontal: 5),
                          decoration: BoxDecoration(
                            color: ColorConstant.cardGrey,
                            borderRadius: BorderRadius.circular(40),
                          ),
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: Text("Custom",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall!
                                          .copyWith(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 12)),
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
                BlocConsumer<AnalyticsBloc, AnalyticsState>(
                  listener: (context, state) {
                    if (state is AnalyticsErrorState) {
                      context.pop();
                      showErrorSnackBar(context, state.failure.message);
                    } else if (state is DownloadingLoadingState) {
                      showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (context) => AlertDialog(
                          content: Container(
                            padding: EdgeInsets.all(10),
                            height: 100,
                            child: Column(
                              spacing: 15,
                              children: [
                                loadingWithPrimary,
                                Text("Downloading report")
                              ],
                            ),
                          ),
                        ),
                      );
                    } else if (state is DownloadedState) {
                      context.pop();
                      showSuccessSnackBar(context, "report saved");
                    }
                  },
                  buildWhen: (previous, current) => previous != current,
                  builder: (context, state) {
                    if (state.occupancyRateEntity.last7Days == null) {
                      return Center(child: loadingIndicator());
                    } else {
                      if (state.selectedDate == '30 Days') {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: 10,
                          children: [
                            sectionTitle(context, 'Key Metrics'),
                            Wrap(
                              children: [
                                MetricsCard(
                                  title: 'Revenue',
                                  value:
                                      "${state.occupancyRateEntity.last30Days!.totalRevenue} ETB",
                                ),
                                MetricsCard(
                                  title: "Active Bookings",
                                  value:
                                      "${state.occupancyRateEntity.last30Days!.totalReservations}",
                                ),
                                MetricsCard(
                                  title: 'Occupancy Rate',
                                  value:
                                      "${state.occupancyRateEntity.last30Days!.averageOccupancy}%",
                                ),
                              ],
                            ),
                            Container(
                              height: 300,
                              width: double.infinity,
                              padding: const EdgeInsets.all(15),
                              child: AnalyticsChart(
                                dailyOccupancy: state.occupancyRateEntity
                                    .last30Days!.dailyOccupancy!,
                              ),
                            ),
                            ReportDownload()
                          ],
                        );
                      } else if (state.selectedDate == '60 Days') {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: 10,
                          children: [
                            sectionTitle(context, 'Key Metrics'),
                            Wrap(
                              children: [
                                MetricsCard(
                                  title: 'Revenue',
                                  value:
                                      "${state.occupancyRateEntity.last60Days!.totalRevenue} ETB",
                                ),
                                MetricsCard(
                                  title: "Active Bookings",
                                  value:
                                      "${state.occupancyRateEntity.last60Days!.totalReservations}",
                                ),
                                MetricsCard(
                                  title: 'Occupancy Rate',
                                  value:
                                      "${state.occupancyRateEntity.last60Days!.averageOccupancy}%",
                                ),
                              ],
                            ),
                            Container(
                              height: 300,
                              width: double.infinity,
                              padding: const EdgeInsets.all(15),
                              child: AnalyticsChart(
                                dailyOccupancy: state.occupancyRateEntity
                                    .last60Days!.dailyOccupancy!,
                              ),
                            ),
                            ReportDownload()
                          ],
                        );
                      } else if (state.selectedDate == '7 Days') {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: 10,
                          children: [
                            sectionTitle(context, 'Key Metrics'),
                            Wrap(
                              children: [
                                MetricsCard(
                                  title: 'Revenue',
                                  value:
                                      "${state.occupancyRateEntity.last7Days!.totalRevenue} ETB",
                                ),
                                MetricsCard(
                                  title: "Active Bookings",
                                  value:
                                      "${state.occupancyRateEntity.last7Days!.totalReservations}",
                                ),
                                MetricsCard(
                                  title: 'Occupancy Rate',
                                  value:
                                      "${state.occupancyRateEntity.last7Days!.averageOccupancy}%",
                                ),
                              ],
                            ),
                            Container(
                              height: 300,
                              width: double.infinity,
                              padding: const EdgeInsets.all(15),
                              child: AnalyticsChart(
                                dailyOccupancy: state.occupancyRateEntity
                                    .last7Days!.dailyOccupancy!,
                              ),
                            ),
                            ReportDownload()
                          ],
                        );
                      } else if (state.selectedDate == 'custom') {
                        if (state is CustomOccupancyRateLoadingState) {
                          return Center(
                            child: loadingIndicator(),
                          );
                        } else {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            spacing: 10,
                            children: [
                              sectionTitle(context, 'Key Metrics'),
                              Wrap(
                                children: [
                                  MetricsCard(
                                    title: 'Revenue',
                                    value:
                                        "${state.customOccupancyEntity.custom!.totalRevenue} ETB",
                                  ),
                                  MetricsCard(
                                    title: "Active Bookings",
                                    value:
                                        "${state.customOccupancyEntity.custom!.totalReservations}",
                                  ),
                                  MetricsCard(
                                    title: 'Occupancy Rate',
                                    value:
                                        "${state.customOccupancyEntity.custom!.averageOccupancy}%",
                                  ),
                                ],
                              ),
                              Container(
                                height: 300,
                                width: double.infinity,
                                padding: const EdgeInsets.all(15),
                                child: AnalyticsChart(
                                  dailyOccupancy: state.customOccupancyEntity
                                      .custom!.dailyOccupancy!,
                                ),
                              ),
                              ReportDownload()
                            ],
                          );
                        }
                      }
                    }
                    return SizedBox.shrink();
                  },
                )
              ],
            ),
          ),
        ));
  }

  Future<DateTimeRange?> buildShowDateRangePicker(BuildContext context) {
    return showDateRangePicker(
        barrierLabel: "Custom",
        context: context,
        saveText: "Update",
        builder: (BuildContext context, Widget? child) {
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
            ),
            child:
                Material(borderRadius: BorderRadius.circular(20), child: child),
          );
        },
        initialDateRange:
            DateTimeRange(start: DateTime.now(), end: DateTime.now()),
        firstDate: DateTime(2020),
        lastDate: DateTime.now());
  }

  Text sectionTitle(BuildContext context, String title) {
    return Text(
      title,
      style: Theme.of(context)
          .textTheme
          .bodyMedium!
          .copyWith(fontWeight: FontWeight.w600, fontSize: 14),
    );
  }
}

class MetricsCard extends StatelessWidget {
  const MetricsCard({super.key, required this.title, required this.value});

  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Card(
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
              Text(title,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color:
                            ColorConstant.secondBtnColor.withValues(alpha: 0.5),
                      )),
              Text(value,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: ColorConstant.secondBtnColor.withValues(),
                      )),
            ],
          ),
        ),
      ),
    );
  }
}

class ReportDownload extends StatelessWidget {
  const ReportDownload({super.key});
  Text sectionTitle(BuildContext context, String title) {
    return Text(
      title,
      style: Theme.of(context)
          .textTheme
          .bodyMedium!
          .copyWith(fontWeight: FontWeight.w600, fontSize: 14),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AnalyticsBloc, AnalyticsState>(
      listener: (context, state) {},
      builder: (context, state) {
        return ListTile(
          title: sectionTitle(context, "Report"),
          subtitle: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Column(
              children: [
                Text(
                  "This is report of your property performance over time. you can download and review.",
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall!
                      .copyWith(fontSize: 12, fontWeight: FontWeight.w400),
                ),
                ElevatedButton(
                  onPressed: () =>
                      context.read<AnalyticsBloc>().add(DownloadReportEvent()),
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
              ],
            ),
          ),
        );
      },
    );
  }
}
