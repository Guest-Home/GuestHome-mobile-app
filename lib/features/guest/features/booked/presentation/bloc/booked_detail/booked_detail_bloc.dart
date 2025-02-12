import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:minapp/core/error/failure.dart';
import 'package:minapp/features/guest/features/booked/domain/entities/my_booking_detail.dart';
import 'package:minapp/features/guest/features/booked/domain/usecases/get_booking_detail_usecase.dart';

import '../../../../../../../core/utils/connectivity_service.dart';
import '../../../../../../../service_locator.dart';

part 'booked_detail_event.dart';
part 'booked_detail_state.dart';

class BookedDetailBloc extends Bloc<BookedDetailEvent, BookedDetailState> {
  BookedDetailBloc() : super(BookedDetailInitial()) {
    on<GetBookedDetail>((event, emit) async{
       emit(BookedDetailLoading());
       final hasConnection = await ConnectivityService.isConnected();
       if (!hasConnection) {
         Either response= await sl<GetBookingDetailUseCase>().call(event.id);
         response.fold((l) => emit(BookedDetailError(failure: l)),(r) => emit(BookedDetailLoaded(booked: r)),);
       }else{
         emit(NoInternetBookedDetailSate());
       }

    });
  }
}
