part of 'add_property_bloc.dart';

final class AddPropertyInitial extends AddPropertyState {}

class AddPropertyState extends Equatable {
  final int step;

  final String title;
  final String description;
  final List<String> amenities;
  final List<XFile> images;
  final String address;
  final String city;
  final String houseType;
  final String noRoom;
  final String price;
  final String unit;
  final String agentId;

  final double latitude;
  final double longitude;

  const AddPropertyState({
    this.step = 0,
    this.title = '',
    this.description = '',
    this.amenities = const [],
    this.images = const [],
    this.address = 'e.g Gurd Shola beside tele',
    this.city = 'Addis Ababa',
    this.houseType = '',
    this.noRoom = '',
    this.price = '',
    this.unit = '',
    this.agentId = '',
    this.latitude = 0.0,
    this.longitude = 0.0,
  });

  @override
  List<Object> get props => [
        houseType,
        title,
        description,
        amenities,
        address,
        city,
        noRoom,
        price,
        agentId,
        step,
        images
      ];

  AddPropertyState copyWith(
      {int? step,
      String? houseType,
      String? title,
      String? description,
      List<String>? amenities,
      String? address,
      String? city,
      String? noRoom,
      String? price,
      String? agentId,
      List<XFile>? images}) {
    return AddPropertyState(
      step: step ?? this.step,
      houseType: houseType ?? this.houseType,
      title: title ?? this.title,
      description: description ?? this.description,
      amenities: amenities ?? this.amenities,
      address: address ?? this.address,
      city: city ?? this.city,
      noRoom: noRoom ?? this.noRoom,
      price: price ?? this.price,
      agentId: agentId ?? this.agentId,
      images: images ?? this.images,
    );
  }
}

class ImagePickerError extends AddPropertyState {
  final String message;
  final AddPropertyState state;

  ImagePickerError(this.state, this.message);
}
