import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:minapp/features/host/features/properties/domain/entities/city_entity.dart';
import 'package:minapp/features/host/features/properties/domain/usecases/get_cities_usecase.dart';
import 'package:minapp/service_locator.dart';

import '../../../../../../../core/utils/connectivity_service.dart';

part 'city_event.dart';
part 'city_state.dart';

class CityBloc extends Bloc<CityEvent, CityState> {
  CityBloc() : super(CityState()) {
    on<GetCitiesEvent>((event, emit) async {
      final hasConnection = await ConnectivityService.isConnected();
      if (!hasConnection) {
        emit(CityLoading());
        Either response = await sl<GetCitiesUsecase>().call();
        response.fold(
              (l) => emit(CityErrorState(message: l)),
              (r) => emit(state.copyWith(cities: r)),
        );
      }

    });
  }
}
