import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:minapp/core/error/failure.dart';
import 'package:minapp/core/utils/get_device_id.dart';
import 'package:minapp/features/auth/domain/entities/otp_response_entity.dart';
import 'package:minapp/features/host/features/profile/domain/usecases/get_otp_new_usecase.dart';
import 'package:minapp/features/host/features/profile/domain/usecases/get_otp_old_phone_usecase.dart';
import 'package:minapp/features/host/features/profile/domain/usecases/verify_new_otp_usecase.dart';
import 'package:minapp/features/host/features/profile/domain/usecases/verify_old_otp_usecase.dart';
import '../../../../../../../service_locator.dart';

part 'change_phone_event.dart';
part 'change_phone_state.dart';

class ChangePhoneBloc extends Bloc<ChangePhoneEvent, ChangePhoneState> {
  ChangePhoneBloc() : super(ChangePhoneInitial()) {
    on<GetOtpForOldPhoneEvent>((event, emit) async {
      emit(state.copyWith(oldPhone: event.oldPone));
      emit(GettingOtpOldPhone(state));
      Either response = await sl<GetOtpOldPhoneUseCase>().call();
      response.fold(
        (l) => emit(PhoneChangeErrorState(state, failure: l)),
        (r) => emit(GettingOtpOldPhoneSuccess(state, otpResponseEntity: r)),
      );
    });
    on<AddOldOtpEvent>(
      (event, emit) => emit(state.copyWith(oldOtp: event.otp)),
    );
    on<AddNewOtpEvent>(
      (event, emit) => emit(state.copyWith(newOtp: event.otp)),
    );
    on<VerifyOldOtpEvent>(
      (event, emit) async {
        emit(VerifyingOtpOld(state));
        String deviceId = await GetDeviceId().getId();
        Map<String, dynamic> data = {
          "otp": state.oldOtp,
          "device_id": deviceId
        };
        Either response = await sl<VerifyOldOtpUseCase>().call(data);
        response.fold(
          (l) => emit(PhoneChangeErrorState(state, failure: l)),
          (r) => emit(VerifyingOtpOldSuccess(state, message: r)),
        );
      },
    );
    on<GetOtpForNewPhoneEvent>(
      (event, emit) async {
        emit(state.copyWith(newPhone: event.newPhone));
        emit(GettingOtpNewPhone(state));
        String deviceId = await GetDeviceId().getId();
        Map<String, dynamic> data = {
          "phone_number": state.newPhone.substring(1),
          "device_id": deviceId
        };
        Either response = await sl<GetOtpForNewUseCase>().call(data);
        response.fold(
          (l) => emit(PhoneChangeErrorState(state, failure: l)),
          (r) => emit(GettingOtpNewPhoneSuccess(state, otpResponseEntity: r)),
        );
      },
    );
    on<VerifyNewOtpEvent>(
      (event, emit) async {
        emit(VerifyingOtpNew(state));
        String deviceId = await GetDeviceId().getId();
        Map<String, dynamic> data = {
          "otp": state.newOtp,
          "device_id": deviceId
        };
        Either response = await sl<VerifyNewOtpUseCase>().call(data);
        response.fold(
          (l) => emit(PhoneChangeErrorState(state, failure: l)),
          (r) => emit(VerifyingOtpNewSuccess(state, message: r)),
        );
      },
    );
  }
}
