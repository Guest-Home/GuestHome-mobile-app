import 'package:bloc/bloc.dart';

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
    on<BookEvent>((event, emit){
      print(state.firstName);
      print(state.lastName);
      print(state.phoneNumber);
      print(state.checkIn);
      print(state.checkOut);
      print(state.idType);

    });
  }
}
