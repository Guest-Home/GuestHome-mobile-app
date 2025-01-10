// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'add_property_bloc.dart';

sealed class AddPropertyEvent extends Equatable {
  const AddPropertyEvent();

  @override
  List<Object> get props => [];
}

class NextStepEvent extends AddPropertyEvent {
  const NextStepEvent();
}

class BackStepEvent extends AddPropertyEvent {
  const BackStepEvent();
}

class AddHouseTypeEvent extends AddPropertyEvent {
  final String houseTYpe;
  const AddHouseTypeEvent({
    required this.houseTYpe,
  });
}

class AddNameEvent extends AddPropertyEvent {
  final String name;
  const AddNameEvent({
    required this.name,
  });
}

class AddDescriptionEvent extends AddPropertyEvent {
  final String description;
  const AddDescriptionEvent({
    required this.description,
  });
}

class AddAmenityEvent extends AddPropertyEvent {
  final String amenityName;
  const AddAmenityEvent({
    required this.amenityName,
  });
}

class AddCityEvent extends AddPropertyEvent {
  final String city;
  const AddCityEvent({
    required this.city,
  });
}

class AddAdressNameEvent extends AddPropertyEvent {
  final String addressName;
  const AddAdressNameEvent({
    required this.addressName,
  });
}

class AddRoomNumberEvent extends AddPropertyEvent {
  final String roomNumber;
  const AddRoomNumberEvent({
    required this.roomNumber,
  });
}

class AddPriceEvent extends AddPropertyEvent {
  final String price;
  const AddPriceEvent({
    required this.price,
  });
}

class SelectPhotosEvent extends AddPropertyEvent {}

class RemovePictureEvent extends AddPropertyEvent {
  final int index;
  const RemovePictureEvent({
    required this.index,
  });
}

class AdddAgentIdEvent extends AddPropertyEvent {
  final String agentId;
  const AdddAgentIdEvent({
    required this.agentId,
  });
}

class GetLocationEvent extends AddPropertyEvent {}

class AddNewPropertyEvent extends AddPropertyEvent {}

class ResetEvent extends AddPropertyEvent {}

class DeletePropertyEvent extends AddPropertyEvent {
  final int id;
  const DeletePropertyEvent({required this.id});
}

class UpdatePropertyEvent extends AddPropertyEvent {
  final Map<String,dynamic> propertyEntity;
  final int id;
  const UpdatePropertyEvent({required this.propertyEntity,required this.id});
}
