import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';
import 'package:minapp/core/error/failure.dart';
import 'package:minapp/core/utils/file_picker.dart';
import 'package:minapp/core/utils/get_device_id.dart';
import 'package:minapp/features/auth/domain/entities/otp_response_entity.dart';
import 'package:minapp/features/auth/domain/usecases/create_customer_profile_usecase.dart';
import 'package:minapp/features/auth/domain/usecases/create_otp_usecase.dart';
import 'package:minapp/features/auth/domain/usecases/create_tg_otp_usecase.dart';
import 'package:minapp/features/auth/domain/usecases/verify_otp_usecase.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/utils/connectivity_service.dart';
import '../../../../service_locator.dart';
import '../../domain/entities/customer_profile_entity.dart';
import '../../domain/entities/verify_otp_entity.dart';
import '../../domain/usecases/verify_tg_otp_usecase.dart';
part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthState()) {
    on<AddPhoneNumberEvent>(
      (event, emit) async {
        emit(state.copyWith(phoneNumber: event.phoneNumber));
      },
    );
    on<AddTgUserNameEvent>(
      (event, emit) async {
        emit(state.copyWith(tgUserName: event.tgUserName));
      },
    );
    on<CountryCodeSelectorEvent>(
        (event, emit) => emit(state.copyWith(countryCode: event.countryCode)));
    on<CreateOtpEvent>(
      (event, emit) async {
        emit(state.copyWith(phoneNumber: event.phone));
        emit(CreatingOtpLoadingState(state));
        Either response = await sl<CreateOtpUsecase>()
            .call(CreateOtpParams(phoneNumber: event.phone));
        response.fold(
          (l) => emit(OtpErrorState(state, l)),
          (r) => emit(OtpCreatedLodedState(state, r)),
        );
      },
    );
    on<CreateTgOtpEvent>(
      (event, emit) async {
        final hasConnection = await ConnectivityService.isConnected();
        if (!hasConnection) {
          emit(CreatingOtpLoadingState(state));
          Map<String, dynamic> data = {'username': state.tgUserName};
          Either response = await sl<CreateTgOtpUsecase>().call(data);
          response.fold(
            (l) => emit(OtpErrorState(state, l)),
            (r) => emit(OtpCreatedLodedState(state, r)),
          );
        } else {
          emit(NoInternetSate());
        }
      },
    );

    on<AddOtpCodeEvent>(
      (event, emit) {
        emit(state.copyWith(otpText: event.otpCode));
      },
    );
    on<AddGenderEvent>(
        (event, emit) => emit(state.copyWith(gender: event.gender)));
    on<AddFullNameEvent>(
      (event, emit) => emit(state.copyWith(fullName: event.fullName)),
    );
    on<SelectPictureEvent>((event, emit) async {
      try {
        final XFile? image = await FilePicker().picImage();
        if (image != null) {
          emit(state.copyWith(profilePhoto: image));
        } else {
          emit(ImagePickerError(state, 'No image selected.'));
        }
      } catch (e) {
        emit(ImagePickerError(state, 'Failed to pick an image'));
      }
    });
    on<RemovePictureEvent>((event, emit) {
      emit(state.copyWith(profilePhoto: XFile('')));
    });
    on<VerifyOtpEvent>(
      (event, emit) async {
        String deviceId = await GetDeviceId().getId();
        emit(VerifyingOtpLoadingState(state));
        Either response = await sl<VerifyOtpUsecase>().call(VerifyOtpParams(
            phoneNumber: state.phoneNumber,
            otp: state.otpText,
            deviceId: deviceId));
        response.fold(
          (l) => emit(OtpErrorState(state, l)),
          (r) async {
            emit(VerifyedOtpLodedState(state, r));
            // store token
            await _storeTokens(r);
          },
        );
      },
    );
    on<VerifyTgOtpEvent>(
      (event, emit) async {
        String deviceId = await GetDeviceId().getId();
        emit(VerifyingOtpLoadingState(state));
        Map<String, dynamic> data = {
          "username": state.tgUserName,
          "otp": state.otpText,
          "device_id": deviceId
        };
        Either response = await sl<VerifyTgOtpUsecase>().call(data);
        response.fold(
          (l) => emit(OtpErrorState(state, l)),
          (r) async {
            emit(VerifyedOtpLodedState(state, r));
            // store token
            await _storeTokens(r);
          },
        );
      },
    );

    on<CreateCustomerProfileEvent>((event, emit) async {
      emit(CreatingCustomerProfileLoadingState(state));
      List<String> names = state.fullName.trim().split(' ');
      Either response = await sl<CreateCustomerProfileUsecase>().call(
          CreateCustomerParams(
              firstName: names.first,
              lastName: names.last,
              gender: state.gender.name,
              image: state.profilePhoto!,
              typeOfCustomer: 'Guest'));
      response.fold(
        (l) => emit(OtpErrorState(state, l)),
        (r) => emit(CreatedCustomerProfileLodedState(state, r)),
      );
    });
  }

  Future<void> _storeTokens(VerifyOtpEntity verifyOpt) async {
    final sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setBool('isLogin', true);
    await sharedPreferences.setString('access', verifyOpt.access);
    await sharedPreferences.setString('refresh', verifyOpt.refresh);
  }
}
