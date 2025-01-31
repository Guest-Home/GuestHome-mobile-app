
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:minapp/core/error/failure.dart';
import 'package:minapp/features/host/features/profile/domain/entities/platform_commission_entity.dart';
import 'package:minapp/features/host/features/profile/domain/usecases/deposit_usecase.dart';
import 'package:minapp/features/host/features/profile/domain/usecases/get_commision_usecase.dart';

import '../../../../../../../service_locator.dart';

part 'payment_setting_event.dart';
part 'payment_setting_state.dart';

class PaymentSettingBloc extends Bloc<PaymentSettingEvent, PaymentSettingState> {
  PaymentSettingBloc() : super(PaymentSettingInitial()) {
    on<AddPaymentMethodEvent>((event, emit) {
      emit(state.copyWith(paymentMethod: event.paymentMethod));
    });
    on<AddAmountEvent>((event, emit) {
      emit(state.copyWith(amount: event.amount));
    });
    on<MakePaymentEvent>((event, emit)async{
      emit(DepositPaymentLoading(state));
      Map<String,dynamic> data={
        "amount":double.parse(state.amount),
        "paymentMethods":state.paymentMethod.code
      };
      Either response= await sl<DepositUseCase>().call(data);
      response.fold((l) => emit(PaymentSettingError(failure: l)),(r) => emit(DepositPaymentSuccess(state)),);
    });

    on<GetPlatformCommissionEvent>((event, emit)async{
      emit(PlatformCommissionLoading());
      Either response= await sl<GetCommissionUseCase>().call();
      response.fold((l) => emit(PaymentSettingError(failure: l)), (r) => emit(PlatformCommissionLoaded(platformCommissionEntity: r)),);
    });
    on<IsAcceptingPaymentEvent>((event, emit) {
      emit(state.copyWith(isAcceptingPayment: !state.isAcceptingPayment));

    },);
  }
}
