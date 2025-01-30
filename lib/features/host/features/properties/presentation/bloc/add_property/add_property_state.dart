part of 'add_property_bloc.dart';

class AddPropertyState extends Equatable {
  final int step;

  final String title;
  final String description;
  final List<String> amenities;
  final List<XFile> images;
  final String city;
  final String houseType;
  final String noRoom;
  final String price;
  final String unit;
  final String agentId;

  final double latitude;
  final double longitude;
  final String specificAddress;

  final AgentPEntity agentPEntity;
  final String token;
  final bool agentSelected;

  const AddPropertyState({
    this.step = 0,
    this.title = '',
    this.description = '',
    this.amenities = const [],
    this.images = const [],
    this.specificAddress = 'e.g Gurd Shola beside tele',
    this.city = 'Addis Ababa',
    this.houseType = '',
    this.noRoom = '',
    this.price = '',
    this.unit = 'ETB',
    this.agentId = '',
    this.latitude = 9.02497,
    this.longitude = 38.74689,
    this.token='',
    this.agentSelected=false,
    this.agentPEntity=const AgentPEntity()
  });

  @override
  List<Object> get props => [
    unit,
        houseType,
        title,
        description,
        amenities,
        city,
        noRoom,
        price,
        agentId,
        step,
        images,
        longitude,
        latitude,
        specificAddress,
    agentPEntity,
    agentSelected,
    token
      ];

  AddPropertyState copyWith({
    int? step,
    String? houseType,
    String? title,
    String? description,
    List<String>? amenities,
    String? city,
    String? noRoom,
    String? price,
    String? agentId,
    List<XFile>? images,
    double? latitude,
    double? longitude,
    String? specificAddress,
    AgentPEntity? agentPEntity,
    String? token,
    String? unit,
    bool? agentSelected,
  }) {
    return AddPropertyState(
        step: step ?? this.step,
        houseType: houseType ?? this.houseType,
        title: title ?? this.title,
        description: description ?? this.description,
        amenities: amenities ?? this.amenities,
        city: city ?? this.city,
        noRoom: noRoom ?? this.noRoom,
        price: price ?? this.price,
        agentId: agentId ?? this.agentId,
        images: images ?? this.images,
        latitude: latitude ?? this.latitude,
        longitude: longitude ?? this.longitude,
        specificAddress: specificAddress ?? this.specificAddress,
        agentPEntity: agentPEntity??this.agentPEntity,
      token: token??this.token,
      unit: unit??this.unit,
      agentSelected:agentSelected??this.agentSelected
    );
  }
}

class ImagePickerError extends AddPropertyState {
  final String message;

  ImagePickerError(AddPropertyState currentState, this.message)
      : super(
            step: currentState.step,
            title: currentState.title,
            description: currentState.description,
            amenities: currentState.amenities,
            images: currentState.images,
            city: currentState.city,
            houseType: currentState.houseType,
            noRoom: currentState.noRoom,
            price: currentState.price,
            unit: currentState.unit,
            agentId: currentState.agentId,
            latitude: currentState.latitude,
            longitude: currentState.longitude,
            specificAddress: currentState.specificAddress,
  );
  @override
  List<Object> get props => super.props + [message];
}
class AddNewPropertyLoading extends AddPropertyState {
  AddNewPropertyLoading(AddPropertyState currentState)
      : super(
            step: currentState.step,
            title: currentState.title,
            description: currentState.description,
            amenities: currentState.amenities,
            images: currentState.images,
            city: currentState.city,
            houseType: currentState.houseType,
            noRoom: currentState.noRoom,
            price: currentState.price,
            unit: currentState.unit,
            agentId: currentState.agentId,
            latitude: currentState.latitude,
            longitude: currentState.longitude,
            specificAddress: currentState.specificAddress,
      agentPEntity: currentState.agentPEntity,
      token: currentState.token,
      agentSelected: currentState.agentSelected
  );
}
class AddNewPropertySuccess extends AddPropertyState {
  final bool isAdded;
  const AddNewPropertySuccess(this.isAdded);
  @override
  List<Object> get props => [isAdded];
}
class AddNewPropertyErrorState extends AddPropertyState {
  final Failure failure;
  AddNewPropertyErrorState(AddPropertyState currentState, this.failure)
      : super(
            step: currentState.step,
            title: currentState.title,
            description: currentState.description,
            amenities: currentState.amenities,
            images: currentState.images,
            city: currentState.city,
            houseType: currentState.houseType,
            noRoom: currentState.noRoom,
            price: currentState.price,
            unit: currentState.unit,
            agentId: currentState.agentId,
            latitude: currentState.latitude,
            longitude: currentState.longitude,
      agentPEntity: currentState.agentPEntity,
      token: currentState.token,
      agentSelected: currentState.agentSelected,
            specificAddress: currentState.specificAddress);

  @override
  List<Object> get props => super.props + [failure];
}
class UpdatePropertyErrorState extends AddPropertyState {
  final Failure failure;
  UpdatePropertyErrorState(AddPropertyState currentState, this.failure)
      : super(
            step: currentState.step,
            title: currentState.title,
            description: currentState.description,
            amenities: currentState.amenities,
            images: currentState.images,
            city: currentState.city,
            houseType: currentState.houseType,
            noRoom: currentState.noRoom,
            price: currentState.price,
            unit: currentState.unit,
            agentId: currentState.agentId,
            latitude: currentState.latitude,
            longitude: currentState.longitude,
      agentPEntity: currentState.agentPEntity,
      token: currentState.token,
      agentSelected: currentState.agentSelected,
            specificAddress: currentState.specificAddress);

  @override
  List<Object> get props => super.props + [failure];
}
class DeletePropertyLoading extends AddPropertyState {
  DeletePropertyLoading(AddPropertyState currentState)
      : super(
            step: currentState.step,
            title: currentState.title,
            description: currentState.description,
            amenities: currentState.amenities,
            images: currentState.images,
            city: currentState.city,
            houseType: currentState.houseType,
            noRoom: currentState.noRoom,
            price: currentState.price,
            unit: currentState.unit,
            agentId: currentState.agentId,
            latitude: currentState.latitude,
            longitude: currentState.longitude,
            specificAddress: currentState.specificAddress);
}
class DeletePropertySuccess extends AddPropertyState {
  final bool isDeleted;
  const DeletePropertySuccess({required this.isDeleted});
  @override
  List<Object> get props => [isDeleted];
}

class UpdatePropertyLoading extends AddPropertyState{
  UpdatePropertyLoading(AddPropertyState currentState)
      : super(
      step: currentState.step,
      title: currentState.title,
      description: currentState.description,
      amenities: currentState.amenities,
      images: currentState.images,
      city: currentState.city,
      houseType: currentState.houseType,
      noRoom: currentState.noRoom,
      price: currentState.price,
      unit: currentState.unit,
      agentId: currentState.agentId,
      latitude: currentState.latitude,
      longitude: currentState.longitude,
      specificAddress: currentState.specificAddress);
}
class UpdatePropertySuccess extends AddPropertyState {
  final bool isUpdate;
  const UpdatePropertySuccess({required this.isUpdate});
  @override
  List<Object> get props => [isUpdate];
}
class GetAgentLoading extends AddPropertyState{
  GetAgentLoading(AddPropertyState currentState)
      : super(
      step: currentState.step,
      title: currentState.title,
      description: currentState.description,
      amenities: currentState.amenities,
      images: currentState.images,
      city: currentState.city,
      houseType: currentState.houseType,
      noRoom: currentState.noRoom,
      price: currentState.price,
      unit: currentState.unit,
      agentId: currentState.agentId,
      latitude: currentState.latitude,
      longitude: currentState.longitude,
      specificAddress: currentState.specificAddress,
    agentPEntity: currentState.agentPEntity,
    token: currentState.token,
    agentSelected: currentState.agentSelected
  );
}
