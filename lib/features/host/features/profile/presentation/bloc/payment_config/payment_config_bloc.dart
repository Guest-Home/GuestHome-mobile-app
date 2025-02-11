import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

import '../../../../../../../service_locator.dart';
import '../../../domain/usecases/payment_config_usecase.dart';

part 'payment_config_event.dart';
part 'payment_config_state.dart';

class PaymentConfigBloc extends HydratedBloc<PaymentConfigEvent, PaymentConfigState> {
  PaymentConfigBloc() : super(PaymentConfigInitial(isAcceptingPayment: false)) {
    on<AcceptPaymentEvent>((event, emit)async {
      Map<String,dynamic> data={
        "is_required":event.isAccepting
      };
      Either response= await sl<PaymentConfigUseCase>().call(data);
      response.fold((l) => emit(state), (r) =>emit(state.copyWith(isAcceptingPayment: event.isAccepting)));

    });
  }

  @override
  PaymentConfigState? fromJson(Map<String, dynamic> json) {
    if (json.containsKey('isAcceptingPayment')) {
      final isAccepting =json['selectedLanguage'];
      if (isAccepting != null) {
        return PaymentConfigInitial(isAcceptingPayment: isAccepting);
      }
    }
    return null;
  }

  @override
  Map<String, dynamic>? toJson(PaymentConfigState state) {
    return  {"isAcceptingPayment":state.isAcceptingPayment};
  }
}
