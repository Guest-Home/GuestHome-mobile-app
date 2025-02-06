import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:minapp/core/error/failure.dart';
import 'package:minapp/features/host/features/properties/domain/usecases/get_properties_usecase.dart';
import 'package:minapp/service_locator.dart';

import '../../../../../../core/utils/connectivity_service.dart';
import '../../domain/entities/property_entity.dart';

part 'properties_event.dart';
part 'properties_state.dart';

class PropertiesBloc extends Bloc<PropertiesEvent, PropertiesState> {
  PropertiesBloc() : super(PropertiesInitial()) {
    on<GetPropertiesEvent>((event, emit) async {
      emit(PropertiesLoading(state));
      final hasConnection = await ConnectivityService.isConnected();
      if (!hasConnection) {
        Either response = await sl<GetPropertiesUsecase>().call();
        response.fold(
          (l) => emit(PropertiesError(state, failure: l)),
          (r) => emit(state.copyWith(properties: r)),
        );
      } else {
        emit(NoInternetSate());
      }
    });
  }
}
