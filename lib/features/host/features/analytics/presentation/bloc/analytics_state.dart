part of 'analytics_bloc.dart';

class AnalyticsState extends Equatable {
   AnalyticsState({
     this.selectedDate='7 Days',
     this.customStartDate='',
     this.customEndDate='',
     this.occupancyRateEntity=const OccupancyRateEntity()
});
  final List<String> occupancyDate=[
    '7 Days',
    '30 Days',
    '60 Days',
  ];
  final String selectedDate;
  final String customStartDate;
  final String customEndDate;
  final OccupancyRateEntity occupancyRateEntity;


  AnalyticsState copyWith({
    String? selectedDate,
    String? customStartDate,
    String? customEndDate,
    OccupancyRateEntity? occupancyRateEntity

}){
    return AnalyticsState(
      selectedDate: selectedDate??this.selectedDate,
      customStartDate: customStartDate??this.selectedDate,
      customEndDate: customEndDate??this.customEndDate,
      occupancyRateEntity: occupancyRateEntity??this.occupancyRateEntity
    );

  }

  @override
  List<Object> get props => [occupancyDate,selectedDate,customStartDate,customEndDate,occupancyRateEntity];
}
class AnalyticsInitial extends AnalyticsState {}


class OccupancyRateLoadingState extends AnalyticsState{}
class AnalyticsErrorState extends AnalyticsState{
  final Failure failure;
  AnalyticsErrorState({required this.failure});
}