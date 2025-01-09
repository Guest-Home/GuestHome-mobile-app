import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:minapp/core/error/failure.dart';
import 'package:minapp/features/host/features/request/data/models/reservation_model.dart';
import 'package:minapp/features/host/features/request/domain/usecases/accept_reserv_usecase.dart';
import 'package:minapp/features/host/features/request/domain/usecases/get_reservation_usecase.dart';

import '../../../../../../service_locator.dart';
import '../../domain/usecases/reject-reserv_usecase.dart';

part 'request_event.dart';
part 'request_state.dart';

class RequestBloc extends Bloc<RequestEvent, RequestState> {
  RequestBloc() : super(RequestInitial()) {
    on<RequestEvent>((event, emit) {});

    on<GetReservationEvent>((event, emit)async{
      emit(ReservationLoadingState());
      Either response= await sl<GetRservationUseCase>().call();
      response.fold((l) =>emit(ReservationErrorState(failure: l)) , (r) => emit(ReservationLoadedState(reservation: r)),);
      
    },);

    on<AcceptReservationEvent>((event, emit)async{
      emit(AcceptingReservationState());
      Either response=await sl<AcceptReservationUsecase>().call(event.id);
      response.fold((l) =>emit(ReservationErrorState(failure: l)),(r) => emit(AcceptedReservationState(isAccepted: r)),);

    },);
    on<RejectReservationEvent>((event, emit)async{
      emit(RejectingReservationState());
      Either response=await sl<RejecctReservationUseCase>().call(event.id);
      response.fold((l) =>emit(ReservationErrorState(failure: l)),(r) => emit(RejectedReservationState(isRejected: r)),);
    },);

  }

}
