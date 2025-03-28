import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:minapp/features/guest/features/booked/domain/usecases/make_payment_usecase.dart';

import '../../../../../../../core/common/enum/payment_medthod.dart';
import '../../../../../../../core/error/failure.dart';
import '../../../../../../../core/utils/connectivity_service.dart';
import '../../../../../../../service_locator.dart';

part 'guest_payment_event.dart';
part 'guest_payment_state.dart';

class GuestPaymentBloc extends Bloc<GuestPaymentEvent, GuestPaymentState> {
  GuestPaymentBloc() : super(GuestPaymentInitial()) {
    on<AddGuestPaymentMethodEvent>((event, emit) {
      emit(state.copyWith(paymentMethod: event.paymentMethod));
    });
    on<MakeReservationRestEvent>((event, emit) {
      emit(GuestPaymentInitial());
    });
    on<MakeReservationPaymentEvent>((event, emit) async{
      Map<String,dynamic> data={
        "paymentMethods":state.paymentMethod.code,
        if(event.phone.isNotEmpty)
        "phoneNumber":event.phone,
        'id':event.id
      };
      final hasConnection = await ConnectivityService.isConnected();
      if (!hasConnection) {
        emit(GuestReservationPaymentLoading());
        Either response= await sl<MakePaymentUseCase>().call(data);
        response.fold((l) => emit(GuestPaymentError(failure: l)), (r) => emit(GuestReservationPaymentSuccess()),);
      }else{
        emit(NoInternetGuestPayment());
      }

    });
  }
}
