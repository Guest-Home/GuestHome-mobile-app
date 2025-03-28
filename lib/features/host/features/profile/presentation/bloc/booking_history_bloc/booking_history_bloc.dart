import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:minapp/core/error/failure.dart';
import 'package:minapp/features/guest/features/booked/domain/usecases/get_Booking_History_useCase.dart';

import '../../../../../../../core/utils/connectivity_service.dart';
import '../../../../../../../service_locator.dart';
import '../../../../../../guest/features/booked/domain/entities/my_booking_entity.dart';

part 'booking_history_event.dart';
part 'booking_history_state.dart';

class BookingHistoryBloc extends Bloc<BookingHistoryEvent, BookingHistoryState> {
  BookingHistoryBloc() : super(BookingHistoryInitial()) {

    on<GetBookingHistoryEvent>((event, emit)async {
      emit(BookingHistoryLoadingState(state));
      final hasConnection = await ConnectivityService.isConnected();
      if (!hasConnection) {
        Either response= await sl<GetBookingHistoryUsecase>().call("");
        response.fold((l) => emit(BookingHistoryError(state,failure: l)),
              (r) => emit(
              state.copyWith(booking: r)
          ),);
      } else {
        emit(NoInternetSate());
      }
    });
    on<LoadMoreBookedEvent>(_loadMoreProperties);
  }

  void _loadMoreProperties(LoadMoreBookedEvent event, Emitter<BookingHistoryState> emit) async {
    if (state is! BookingHistoryLoadingMoreState && state.booking.next != null) {
      final currentProperties = state.booking;

      emit(BookingHistoryLoadingMoreState(state));
      final response = await sl<GetBookingHistoryUsecase>().call(currentProperties.next!);
      response.fold(
            (l) => emit(BookingHistoryError(state, failure: l)),
            (r) {
          final updatedProperties = currentProperties.copyWith(
            results: [...currentProperties.results!, ...r.results!],
            next: r.next, // Will be null when no more pages
            count: r.count,
            previous: r.previous,
          );
          emit(state.copyWith(booking: updatedProperties));
        },
      );
    }
  }
}
