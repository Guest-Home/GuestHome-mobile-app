import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';
import 'package:minapp/core/error/failure.dart';
import 'package:minapp/core/utils/get_location.dart';
import 'package:minapp/features/host/features/properties/domain/usecases/create_property_usecase.dart';
import 'package:minapp/service_locator.dart';

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
      (event, emit) => emit(state.copyWith(specificAddress: event.addressName)),
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
    on<GetLocationEvent>((event, emit) async {
      final loc = await GetLocation().gatePosition();
      emit(state.copyWith(latitude: loc.latitude, longitude: loc.longitude));
    });
    on<RemovePictureEvent>(
      (event, emit) {
        final updatedAmenityList = List.of(state.images);
        updatedAmenityList.removeAt(event.index);
        emit(state.copyWith(images: updatedAmenityList));
      },
    );

    on<ResetEvent>((event, emit) => emit(const AddPropertyState()));

    // create property
    on<AddNewPropertyEvent>(
      (event, emit) async {
        emit(AddNewPropertyLoading(state));

        final imageMultipartFiles =
            await Future.wait(state.images.map((image) async {
          return await MultipartFile.fromFile(
            image.path,
          );
        }));

        final FormData formData = FormData.fromMap({
          'title': state.title,
          'description': state.description,
          'city': state.city,
          'typeofHouse': state.houseType,
          'latitude': state.latitude,
          'longitude': state.longitude,
          'price': state.price,
          'unit': state.unit,
          if (state.agentId.isNotEmpty) 'agent': state.agentId,
          'image': imageMultipartFiles,
          'number_of_room': state.noRoom,
          'sub_description': state.amenities.toList(),
          'specificAddress':state.specificAddress

        });
        Either response = await sl<CreatePropertyUsecase>()
            .call(CreatePropertyParam(formData: formData));
        response.fold(
          (l) => emit(AddNewPropertyErrorState(state, l)),
          (r) {
            emit(AddNewPropertySuccess(r));
          },
        );
      },
    );
  }
}
