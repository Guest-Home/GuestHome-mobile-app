import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:minapp/core/error/failure.dart';
import 'package:minapp/core/utils/date_converter.dart';
import 'package:minapp/features/guest/features/HousType/domain/usecases/proprty_booking_usecase.dart';

import '../../../../../../../core/utils/connectivity_service.dart';
import '../../../../../../../service_locator.dart';

part 'booking_event.dart';
part 'booking_state.dart';

class BookingBloc extends Bloc<BookingEvent, BookingState> {
  BookingBloc() : super(BookingInitial()) {
    on<AddCheckInEvent>((event, emit) {
      emit(state.copyWith(checkIn: event.checkIn));
    });
    on<AddCheckOutEvent>((event, emit) {
      emit(state.copyWith(checkOut: event.checkOut));
    });
    on<AddIdEvent>((event, emit) {
      emit(state.copyWith(idType: event.id));
    });
    on<BookEvent>((event, emit)async{
      Map<String,dynamic> bookingData=
        {
          "house": event.id,
          "checkIn":DateConverter().formatDateRange(state.checkIn),
          "checkOut":DateConverter().formatDateRange(state.checkOut),
          "type_proof_of_identity":state.idType.name
      };
      final hasConnection = await ConnectivityService.isConnected();
      if (!hasConnection) {
        emit(BookingLoadingState(state));
        Either response=await sl<PropertyBookingUseCase>().call(bookingData);
        response.fold((l) => emit(BookingErrorState(state,failure: l)), (r) => emit(BookingSuccessState(state,booked: r)),);
      }else{
        emit(NoInternetBookingState(state));
      }

    });

   on<ResetBookingEvent>((event, emit) => emit(BookingInitial()),);
  }
}
