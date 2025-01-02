part of 'amenities_bloc.dart';

class AmenitiesState extends Equatable {
  final List<AmenityEntity> amenities;
  final List<AmenityEntity> selectedAmenity;

  const AmenitiesState(
      {this.amenities = const [], this.selectedAmenity = const []});

  AmenitiesState copyWith(
      {List<AmenityEntity>? amenities, List<AmenityEntity>? selectedAmenity}) {
    return AmenitiesState(
      amenities: amenities ?? this.amenities,
      selectedAmenity: selectedAmenity ?? this.selectedAmenity,
    );
  }

  @override
  List<Object> get props => [amenities, selectedAmenity];
}

class AmenityLoadingState extends AmenitiesState {}

class AmenityTypeError extends AmenitiesState {
  final String message;
  const AmenityTypeError({required this.message});
}
