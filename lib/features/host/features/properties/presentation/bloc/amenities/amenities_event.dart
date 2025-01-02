part of 'amenities_bloc.dart';

sealed class AmenitiesEvent extends Equatable {
  const AmenitiesEvent();

  @override
  List<Object> get props => [];
}

class GetAmenityEvent extends AmenitiesEvent {}

class SelectAmenityEvent extends AmenitiesEvent {
  final AmenityEntity amenity;
  const SelectAmenityEvent({required this.amenity});
}
