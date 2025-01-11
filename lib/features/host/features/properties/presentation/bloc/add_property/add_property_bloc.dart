import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';
import 'package:minapp/core/error/failure.dart';
import 'package:minapp/core/utils/get_location.dart';
import 'package:minapp/features/host/features/properties/domain/usecases/create_property_usecase.dart';
import 'package:minapp/features/host/features/properties/domain/usecases/delete_property_usecase.dart';
import 'package:minapp/features/host/features/properties/domain/usecases/get_agent_usecase.dart';
import 'package:minapp/features/host/features/properties/domain/usecases/update_property_usecase.dart';
import 'package:minapp/service_locator.dart';

import '../../../../../../../core/utils/file_picker.dart';
import '../../../../../../../core/utils/get_token.dart';
import '../../../domain/entities/agent_entity.dart';

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
          final List<XFile>? images = await FilePicker().picMultipleImage();
          if (images != null && images.isNotEmpty) {
            final updatedAmenityList = List.of(state.images);
            updatedAmenityList.addAll(images);
            emit(state.copyWith(images: updatedAmenityList));
          } else {
            emit(ImagePickerError(state, 'No image selected.'));
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
          'sub_description': state.amenities.join(','),
          'specificAddress': state.specificAddress
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

    on<DeletePropertyEvent>(
      (event, emit) async {
        emit(DeletePropertyLoading(state));
        Either response = await sl<DeletePropertyUsecase>().call(event.id);
        response.fold(
          (l) => emit(AddNewPropertyErrorState(state, l)),
          (r) => emit(DeletePropertySuccess(isDeleted: r)),
        );
      },
    );
    on<UpdatePropertyEvent>(
      (event, emit) async {
        emit(UpdatePropertyLoading(state));
        final formMap = event.propertyEntity;
        if (state.images.isNotEmpty) {
          final imageMultipartFiles =
              await Future.wait(state.images.map((image) async {
            return await MultipartFile.fromFile(
              image.path,
            );
          }));
          formMap['image'] = imageMultipartFiles;
        }
        final FormData formData = FormData.fromMap(formMap);
        Either response = await sl<UpdatePropertyUseCase>()
            .call(UpdatePropertyParam(formData: formData, id: event.id));
        response.fold(
          (l) => emit(AddNewPropertyErrorState(state, l)),
          (r) => emit(UpdatePropertySuccess(isUpdate: r)),
        );
      },
    );

    on<GetAgentEvent>(
      (event, emit) async {
        emit(GetAgentLoading(state));
        Either response = await sl<GetAgentUsecase>().call(event.agentId);
        final token = await GetToken().getUserToken();
        response.fold(
          (l) => emit(AddNewPropertyErrorState(state, l)),
          (r) {
            emit(state.copyWith(agentPEntity: r, token: token));
          },
        );
      },
    );
    on<SelectAgentEvent>(
      (event, emit) => emit(state.copyWith(agentSelected: event.selected)),
    );
    on<RemoveSelectedAgentEvent>(
      (event, emit) => emit(state.copyWith(agentPEntity: const AgentPEntity())),
    );
  }
}
