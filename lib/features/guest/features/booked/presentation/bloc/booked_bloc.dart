import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:minapp/core/error/failure.dart';
import 'package:minapp/features/guest/features/booked/domain/entities/my_booking_entity.dart';
import 'package:minapp/features/guest/features/booked/domain/usecases/cancel_booking_usecase.dart';
import 'package:minapp/features/guest/features/booked/domain/usecases/get_my_booking_usecase.dart';

import '../../../../../../service_locator.dart';

part 'booked_event.dart';
part 'booked_state.dart';

class BookedBloc extends Bloc<BookedEvent, BookedState> {
  BookedBloc() : super(BookedInitial()) {
    on<GetMyBookingEvent>((event, emit)async {
      emit(MyBookingLoadingState(state));
      Either response= await sl<GetMyBookingUseCase>().call();
      response.fold((l) => emit(MyBookingErrorState(state,failure: l)), (r) => emit(
        state.copyWith(booking: r)
      ),);
    });

    on<CancelBookingEvent>((event, emit)async{
      emit(CancelBookingLoadingState());
      Either response=await sl<CancelBookingUseCase>().call(event.id);
      response.fold((l) => emit(CancelBookingErrorState(failure: l)), (r) => emit(CancelBookingSuccessState()),);
    },);
  }
}
