part of 'analytics_bloc.dart';

abstract class AnalyticsEvent extends Equatable {
  const AnalyticsEvent();

  @override
  List<Object> get props => [];
}

class ChangeOccupancyDateEvent extends AnalyticsEvent{
  final String date;
  const ChangeOccupancyDateEvent({required this.date});
}

class AddCustomDateEvent extends AnalyticsEvent{
  final String startDate;
  final String endDate;
  const AddCustomDateEvent({required this.startDate,required this.endDate});
}

class GetOccupancyRateEvent extends AnalyticsEvent{}
class GetCustomOccupancyEvent extends AnalyticsEvent{}
class DownloadReportEvent extends AnalyticsEvent{}