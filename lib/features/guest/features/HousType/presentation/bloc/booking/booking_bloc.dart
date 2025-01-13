import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:minapp/core/error/failure.dart';
import 'package:minapp/core/utils/date_converter.dart';
import 'package:minapp/features/guest/features/HousType/domain/usecases/proprty_booking_usecase.dart';

import '../../../../../../../service_locator.dart';

part 'booking_event.dart';
part 'booking_state.dart';

class BookingBloc extends Bloc<BookingEvent, BookingState> {
  BookingBloc() : super(BookingInitial()) {
    on<AddFirstNameEvent>((event, emit) {
      emit(state.copyWith(firstName: event.fName));
    });
    on<AddLastNameEvent>((event, emit) {
      emit(state.copyWith(lastName: event.lName));
    });
    on<AddPhoneEvent>((event, emit) {
      emit(state.copyWith(phoneNumber: event.phone));
    });
    on<AddCheckInEvent>((event, emit) {
      emit(state.copyWith(checkIn: event.checkIn));
    });
    on<AddCheckOutEvent>((event, emit) {
      emit(state.copyWith(checkOut: event.checkOut));
    });
    on<AddIdEvent>((event, emit) {
      emit(state.copyWith(idType: event.id));
    });
    on<AddCountryCodeEvent>((event, emit) {
      emit(state.copyWith(countryCode: event.code));
    });
    on<BookEvent>((event, emit)async{
      Map<String,dynamic> bookingData=
        {
          "house": event.id,
          "checkIn":DateConverter().formatDateRange(state.checkIn),
          "checkOut":DateConverter().formatDateRange(state.checkOut),
          "type_proof_of_identity":state.idType.name

      };
      emit(BookingLoadingState());
      Either response=await sl<PropertyBookingUseCase>().call(bookingData);
      response.fold((l) => emit(BookingErrorState(failure: l)), (r) => emit(BookingSuccessState(booked: r)),);
    });

   on<ResetBookingEvent>((event, emit) => emit(BookingInitial()),);
  }
}
