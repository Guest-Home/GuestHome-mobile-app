import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../../../../core/utils/file_picker.dart';

part 'add_property_event.dart';
part 'add_property_state.dart';

class AddPropertyBloc extends Bloc<AddPropertyEvent, AddPropertyState> {
  AddPropertyBloc() : super(AddPropertyState()) {
    on<NextStepEvent>((event, emit) {
      if (state.step == 6) {
        emit(state.copyWith(step: 0));
      } else {
        emit(state.copyWith(step: state.step + 1));
      }
    });
    on<BackStepEvent>((event, emit) {
      emit(state.copyWith(step: state.step == 0 ? 0 : state.step - 1));
    });

    // add attributes
    on<AddHouseTypeEvent>((event, emit) {
      emit(state.copyWith(houseType: event.houseTYpe));
    });
    on<AddNameEvent>((event, emit) {
      emit(state.copyWith(title: event.name));
    });
    on<AddDescriptionEvent>((event, emit) {
      emit(state.copyWith(description: event.description));
    });
    on<AddAmenityEvent>(
      (event, emit) {
        final updatedAmenityList = List.of(state.amenities);
        if (updatedAmenityList.contains(event.amenityName)) {
          updatedAmenityList.remove(event.amenityName);
        } else {
          updatedAmenityList.add(event.amenityName);
        }

        // Emit the new state with the updated list
        emit(state.copyWith(amenities: updatedAmenityList));
      },
    );
    on<AddCityEvent>(
      (event, emit) => emit(state.copyWith(city: event.city)),
    );
    on<AddAdressNameEvent>(
      (event, emit) => emit(state.copyWith(address: event.addressName)),
    );
    on<AddRoomNumberEvent>((event, emit) => emit(
          state.copyWith(noRoom: event.roomNumber),
        ));
    on<AddPriceEvent>(
      (event, emit) => emit(state.copyWith(price: event.price)),
    );
    on<AdddAgentIdEvent>(
      (event, emit) => emit(state.copyWith(agentId: event.agentId)),
    );
    on<SelectPhotosEvent>(
      (event, emit) async {
        try {
          final XFile? image = await FilePicker().picImage();
          if (image != null) {
            final updatedAmenityList = List.of(state.images);
            updatedAmenityList.add(image);
            emit(state.copyWith(images: updatedAmenityList));
          } else {
            emit(ImagePickerError(state, 'No image seleced.'));
          }
        } catch (e) {
          emit(ImagePickerError(state, 'Failed to pick an image'));
        }
      },
    );

    on<RemovePictureEvent>(
      (event, emit) {
        final updatedAmenityList = List.of(state.images);
        updatedAmenityList.removeAt(event.index);
        emit(state.copyWith(images: updatedAmenityList));
      },
    );
  }
}
