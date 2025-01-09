part of 'analytics_bloc.dart';

class AnalyticsState extends Equatable {
   AnalyticsState({
     this.selectedDate='7 Days',
     this.customStartDate='',
     this.customEndDate='',
     this.occupancyRateEntity=const OccupancyRateEntity(),
     this.customOccupancyEntity=const CustomOccupancyEntity()
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
  final CustomOccupancyEntity customOccupancyEntity;

  AnalyticsState copyWith({
    String? selectedDate,
    String? customStartDate,
    String? customEndDate,
    OccupancyRateEntity? occupancyRateEntity,
    CustomOccupancyEntity? customOccupancyEntity

}){
    return AnalyticsState(
      selectedDate: selectedDate??this.selectedDate,
      customStartDate: customStartDate??this.selectedDate,
      customEndDate: customEndDate??this.customEndDate,
      occupancyRateEntity: occupancyRateEntity??this.occupancyRateEntity,
      customOccupancyEntity: customOccupancyEntity??this.customOccupancyEntity
    );

  }

  @override
  List<Object> get props => [occupancyDate,selectedDate,customStartDate,customEndDate,occupancyRateEntity,customOccupancyEntity];
}
class AnalyticsInitial extends AnalyticsState {

}

class OccupancyRateLoadingState extends AnalyticsState{
}
class CustomOccupancyRateLoadingState extends AnalyticsState{
  CustomOccupancyRateLoadingState(AnalyticsState currentState):super(
      selectedDate: currentState.selectedDate,
      customEndDate: currentState.customEndDate,
      customStartDate: currentState.customStartDate,
      occupancyRateEntity: currentState.occupancyRateEntity,
      customOccupancyEntity: currentState.customOccupancyEntity
  );
}
class AnalyticsErrorState extends AnalyticsState{
  final Failure failure;
  AnalyticsErrorState({required this.failure,required AnalyticsState currentState}):super(
      selectedDate: currentState.selectedDate,
      customEndDate: currentState.customEndDate,
      customStartDate: currentState.customStartDate,
      occupancyRateEntity: currentState.occupancyRateEntity,
      customOccupancyEntity: currentState.customOccupancyEntity
  );
}