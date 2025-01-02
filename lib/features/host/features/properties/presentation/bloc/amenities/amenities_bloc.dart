import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:minapp/features/host/features/properties/domain/entities/amenity_entity.dart';
import 'package:minapp/features/host/features/properties/domain/usecases/get_amenity_usecase.dart';
import 'package:minapp/service_locator.dart';

part 'amenities_event.dart';
part 'amenities_state.dart';

class AmenitiesBloc extends Bloc<AmenitiesEvent, AmenitiesState> {
  AmenitiesBloc() : super(AmenitiesState()) {
    on<GetAmenityEvent>((event, emit) async {
      emit(AmenityLoadingState());
      Either response = await sl<GetAmenityUsecase>().call();
      response.fold(
        (l) => emit(AmenityTypeError(message: l)),
        (r) => emit(state.copyWith(amenities: r)),
      );
    });
    on<SelectAmenityEvent>((event, emit) async {
      final updatedAmenityList = List.of(state.selectedAmenity);

      if (updatedAmenityList.contains(event.amenity)) {
        updatedAmenityList.remove(event.amenity);
      } else {
        updatedAmenityList.add(event.amenity);
      }

      // Emit the new state with the updated list
      emit(state.copyWith(selectedAmenity: updatedAmenityList));
    });
  }
}
