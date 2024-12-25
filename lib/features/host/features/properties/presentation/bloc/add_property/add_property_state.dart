part of 'add_property_bloc.dart';

final class AddPropertyInitial extends AddPropertyState {}

class AddPropertyState extends Equatable {
  final int step;
  final String houseType;
  final String name;
  final String description;
  final List<String> amenities;
  final String address;
  final String city;
  final String noRoom;
  final String price;
  final String agentId;

  const AddPropertyState({
    this.step = 0,
    this.houseType = '',
    this.name = '',
    this.description = '',
    this.amenities = const [],
    this.address = '',
    this.city = '',
    this.noRoom = '',
    this.price = '',
    this.agentId = '',
  });

  @override
  List<Object> get props => [
        houseType,
        name,
        description,
        amenities,
        address,
        city,
        noRoom,
        price,
        agentId,
        step
      ];

  AddPropertyState copyWith({
    int? step,
    String? houseType,
    String? name,
    String? description,
    List<String>? amenities,
    String? address,
    String? city,
    String? noRoom,
    String? price,
    String? agentId,
  }) {
    return AddPropertyState(
      step: step ?? this.step,
      houseType: houseType ?? this.houseType,
      name: name ?? this.name,
      description: description ?? this.description,
      amenities: amenities ?? this.amenities,
      address: address ?? this.address,
      city: city ?? this.city,
      noRoom: noRoom ?? this.noRoom,
      price: price ?? this.price,
      agentId: agentId ?? this.agentId,
    );
  }
}
