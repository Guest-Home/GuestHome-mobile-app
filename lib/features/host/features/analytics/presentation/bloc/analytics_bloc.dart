import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:minapp/core/error/failure.dart';
import 'package:minapp/features/host/features/analytics/domain/entities/custom_occupancy_rate_entity.dart';
import 'package:minapp/features/host/features/analytics/domain/entities/occupancy_rate_entity.dart';
import 'package:minapp/features/host/features/analytics/domain/usecases/download_report_custom_usecase.dart';
import 'package:minapp/features/host/features/analytics/domain/usecases/download_report_usecase.dart';
import 'package:minapp/features/host/features/analytics/domain/usecases/get_custom_occup_usecase.dart';
import 'package:minapp/features/host/features/analytics/domain/usecases/get_occupancy_rate_usecase.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../../../../../service_locator.dart';

part 'analytics_event.dart';
part 'analytics_state.dart';

class AnalyticsBloc extends Bloc<AnalyticsEvent, AnalyticsState> {
  AnalyticsBloc() : super(AnalyticsInitial()) {
    on<GetOccupancyRateEvent>((event, emit) async {
      emit(OccupancyRateLoadingState(state));
      Either response = await sl<GetOccupancyRateUseCase>().call();
      response.fold(
          (l) => emit(AnalyticsErrorState(
                failure: l,
                currentState: state,
              )),
          (r) => emit(state.copyWith(occupancyRateEntity: r)));
    });
    on<GetCustomOccupancyEvent>(
      (event, emit) async {
        emit(CustomOccupancyRateLoadingState(state));
        Map<String, dynamic> dates = {
          'startDate': state.customStartDate,
          'endDate': state.customEndDate,
        };

        Either response = await sl<GetCustomOccupancyUseCase>().call(dates);
        response.fold(
          (l) => emit(AnalyticsErrorState(failure: l, currentState: state)),
          (r) => emit(
              state.copyWith(customOccupancyEntity: r, selectedDate: "custom")),
        );
      },
    );
    on<ChangeOccupancyDateEvent>(
      (event, emit) => emit(state.copyWith(selectedDate: event.date)),
    );
    on<AddCustomDateEvent>(
      (event, emit) => emit(state.copyWith(
          customStartDate: event.startDate, customEndDate: event.endDate)),
    );

    on<DownloadReportEvent>(
      (event, emit) async {
        final hasPermission = await requestStoragePermission();
        if (hasPermission) {
          if (state.selectedDate == "custom") {
            emit(DownloadingLoadingState(state));
            Map<String, dynamic> dates = {
              'startDate': state.customStartDate,
              'endDate': state.customEndDate,
            };
            Either response =
                await sl<DownloadReportCustomUseCase>().call(dates);
            response.fold(
              (l) => emit(AnalyticsErrorState(failure: l, currentState: state)),
              (r) => emit(DownloadedState(state)),
            );
          } else {
            emit(DownloadingLoadingState(state));
            String date = getDate(state.selectedDate);
            Either response = await sl<DownloadReportUseCase>().call(date);
            response.fold(
              (l) => emit(AnalyticsErrorState(failure: l, currentState: state)),
              (r) => emit(DownloadedState(state)),
            );
          }
        } else {
          emit(AnalyticsErrorState(
              failure: UnknownFailure("Storage permission denied"),
              currentState: state));
        }
      },
    );
  }
  Future<bool> requestStoragePermission() async {
    final status = await Permission.storage.request();
    return status.isGranted;
  }

  String getDate(String date) {
    switch (date) {
      case '7 Days':
        return "7";
      case '30 Days':
        return "30";
      case '60 Days':
        return "60";
      default:
        return "7";
    }
  }
}
