import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:minapp/core/error/failure.dart';
import 'package:minapp/features/host/features/request/data/models/reservation_model.dart';
import 'package:minapp/features/host/features/request/domain/usecases/accept_reserv_usecase.dart';
import 'package:minapp/features/host/features/request/domain/usecases/get_reservation_usecase.dart';

import '../../../../../../service_locator.dart';
import '../../domain/usecases/reject_reserv_usecase.dart';

part 'request_event.dart';
part 'request_state.dart';

class RequestBloc extends Bloc<RequestEvent, RequestState> {
  RequestBloc() : super(RequestInitial()) {
    on<RequestEvent>((event, emit) {});

    on<GetReservationEvent>(
      (event, emit) async {
        emit(ReservationLoadingState(state));
        Either response = await sl<GetRservationUseCase>().call('');
        response.fold(
          (l) => emit(ReservationErrorState(state,failure: l)),
          (r) => emit(state.copyWith(reservation: r)),
        );
      },
    );

    on<AcceptReservationEvent>(
      (event, emit) async {
        emit(AcceptingReservationState(state));
        Map<String,dynamic> data={
          "room_number":event.roomNumber.toString(),
          "id":event.id
        };

        Either response = await sl<AcceptReservationUsecase>().call(data);
        response.fold(
          (l) => emit(ReservationErrorState(state,failure: l)),
          (r) => emit(AcceptedReservationState(state,isAccepted: r)),
        );
      },
    );
    on<RejectReservationEvent>(
      (event, emit) async {
        emit(RejectingReservationState(state));
        Either response = await sl<RejecctReservationUseCase>().call(event.id);
        response.fold(
          (l) => emit(ReservationErrorState(state,failure: l)),
          (r) => emit(RejectedReservationState(state, isRejected: r)),
        );
      },
    );
    on<LoadMoreReservationEvent>(_loadMoreProperties);

  }
  void _loadMoreProperties(LoadMoreReservationEvent event, Emitter<RequestState> emit) async {
    if (state is! ReservationLoadingMoreState && state.reservation.next!= null) {
      final currentReservation= state.reservation;

      emit(ReservationLoadingMoreState(state));
      final response = await sl<GetRservationUseCase>().call(currentReservation.next);
      response.fold(
            (l) => emit(ReservationErrorState(state, failure: l)),
            (r) {
          final updatedProperties = currentReservation.copyWith(
            results: [...currentReservation.results!, ...r.results!],
            next: r.next, // Will be null when no more pages
            count: r.count,
            previous: r.previous,
          );
          emit(state.copyWith(reservation: updatedProperties));
        },
      );
    }
  }
}
