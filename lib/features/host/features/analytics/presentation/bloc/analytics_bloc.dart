import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:minapp/core/error/failure.dart';
import 'package:minapp/features/host/features/analytics/domain/entities/occupancy_rate_entity.dart';
import 'package:minapp/features/host/features/analytics/domain/usecases/get_occupancy_rate_usecase.dart';

import '../../../../../../service_locator.dart';

part 'analytics_event.dart';
part 'analytics_state.dart';

class AnalyticsBloc extends Bloc<AnalyticsEvent, AnalyticsState> {
  AnalyticsBloc() : super(AnalyticsInitial()) {
    on<AnalyticsEvent>((event, emit) {});

    on<GetOccupancyRateEvent>((event, emit)async{
      emit(OccupancyRateLoadingState());
      Either response= await sl<GetOccupancyRateUseCase>().call();
      response.fold((l) =>emit(AnalyticsErrorState(failure: l)) , (r) => emit(state.copyWith(occupancyRateEntity: r)),);

    });
    on<ChangeOccupancyDateEvent>((event, emit) => emit(state.copyWith(selectedDate: event.date)),);
    on<AddCustomDateEvent>((event, emit) => emit(state.copyWith(customStartDate: event.startDate,customEndDate: event.endDate)),);
  }
}
