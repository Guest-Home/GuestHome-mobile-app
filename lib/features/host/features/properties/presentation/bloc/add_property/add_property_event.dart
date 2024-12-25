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
