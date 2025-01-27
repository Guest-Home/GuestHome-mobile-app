import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:minapp/features/host/features/properties/domain/usecases/get_property_type_usecase.dart';
import 'package:minapp/service_locator.dart';
import '../../../../../../../core/utils/connectivity_service.dart';
import '../../../domain/entities/property_type_entity.dart';
part 'property_type_event.dart';
part 'property_type_state.dart';

class PropertyTypeBloc extends Bloc<PropertyTypeEvent, PropertyTypeState> {
  PropertyTypeBloc() : super(PropertyTypeState()) {
    on<GetPropertyTypesEvent>((event, emit) async {
      emit(PropertyTypeLoadingState());
      final hasConnection = await ConnectivityService.isConnected();
      if (!hasConnection) {
        Either response = await sl<GetPropertyTypeUsecase>().call();
        response.fold(
          (l) => emit(PropertyTypeError(message: l)),
          (r) => emit(state.copyWith(propertyTypes: r)),
        );
      } else {
        emit(NoInternetSate());
      }
    });
    on<SelectPropertyType>(
      (event, emit) =>
          emit(state.copyWith(selectedPropertyType: event.propertyType)),
    );
  }
}
