import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:minapp/core/error/failure.dart';
import 'package:minapp/features/host/features/profile/domain/entities/payment_config_entity.dart';
import 'package:minapp/features/host/features/profile/domain/usecases/get_payment_config_usecase.dart';

import '../../../../../../../service_locator.dart';
import '../../../domain/usecases/payment_config_usecase.dart';

part 'payment_config_event.dart';
part 'payment_config_state.dart';

class PaymentConfigBloc extends Bloc<PaymentConfigEvent, PaymentConfigState> {
  PaymentConfigBloc() : super(PaymentConfigInitial()) {
    on<AcceptPaymentEvent>((event, emit)async {
      Map<String,dynamic> data={
        "is_required":event.isAccepting
      };
      emit(state.copyWith(isAcceptingPayment: event.isAccepting));
      Either response= await sl<PaymentConfigUseCase>().call(data);
      response.fold((l) => emit(state.copyWith(isAcceptingPayment: state.isAcceptingPayment)),
              (r) =>emit(PaymentConfigUpdatedState()));

    });
   on<GetPaymentConfigEvent>((event, emit)async{
     emit(PaymentConfigLoadingState());
     Either response=await sl<GetPaymentConfigUseCase>().call();
     response.fold((l) => emit(PaymentConfigFailureState(failure: l)),
           (r){
             emit(state.copyWith(paymentConfigEntity: r));
             emit(state.copyWith(isAcceptingPayment: state.paymentConfigEntity.isRequired));
           });

   },);
  }

  // @override
  // PaymentConfigState? fromJson(Map<String, dynamic> json) {
  //   if (json.containsKey('isAcceptingPayment')) {
  //     final isAccepting =json['selectedLanguage'];
  //     if (isAccepting != null) {
  //       return PaymentConfigInitial(isAcceptingPayment: isAccepting);
  //     }
  //   }
  //   return null;
  // }
  //
  // @override
  // Map<String, dynamic>? toJson(PaymentConfigState state) {
  //   return  {"isAcceptingPayment":state.isAcceptingPayment};
  // }
}
