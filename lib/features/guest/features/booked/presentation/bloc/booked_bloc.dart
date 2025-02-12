import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:minapp/core/error/failure.dart';
import 'package:minapp/features/guest/features/booked/domain/entities/my_booking_entity.dart';
import 'package:minapp/features/guest/features/booked/domain/usecases/cancel_booking_usecase.dart';
import 'package:minapp/features/guest/features/booked/domain/usecases/get_my_booking_usecase.dart';

import '../../../../../../core/utils/connectivity_service.dart';
import '../../../../../../service_locator.dart';

part 'booked_event.dart';
part 'booked_state.dart';

class BookedBloc extends Bloc<BookedEvent, BookedState> {
  BookedBloc() : super(BookedInitial()) {
    on<GetMyBookingEvent>((event, emit)async {
      emit(MyBookingLoadingState(state));
      final hasConnection = await ConnectivityService.isConnected();
      if (!hasConnection) {
      Either response= await sl<GetMyBookingUseCase>().call("");
      response.fold((l) => emit(MyBookingErrorState(state,failure: l)), (r) => emit(
        state.copyWith(booking: r)
      ),);
      } else {
        emit(NoInternetSate());
      }
    });
    on<BookedResetEvent>((event, emit)async {
      emit(BookedInitial());
    });

    on<CancelBookingEvent>((event, emit)async{
      final hasConnection = await ConnectivityService.isConnected();
      if (!hasConnection) {
        emit(CancelBookingLoadingState());
        Either response=await sl<CancelBookingUseCase>().call(event.id);
        response.fold((l) => emit(CancelBookingErrorState(failure: l)), (r) => emit(CancelBookingSuccessState()),);
      }else{
        emit(NoInternetSate());
      }

    },);

    on<LoadMoreBookedEvent>(_loadMoreProperties);

  }

  void _loadMoreProperties(LoadMoreBookedEvent event, Emitter<BookedState> emit) async {
    if (state is! MyBookingLoadingMoreState && state.booking.next != null) {
      final currentProperties = state.booking;

      emit(MyBookingLoadingMoreState(state));
      final response = await sl<GetMyBookingUseCase>().call(currentProperties.next!);
      response.fold(
            (l) => emit(MyBookingErrorState(state, failure: l)),
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
