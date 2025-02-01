part of 'filter_bloc.dart';

abstract class FilterEvent {}

class AddPriceRange extends FilterEvent{
  final RangeValues prices;
  AddPriceRange({required this.prices});
}
class AddFilterCityEvent extends FilterEvent{
  final String city;
  AddFilterCityEvent({required this.city});
}

class AddHouseTypeEvent extends FilterEvent{
  final String houseType;
  AddHouseTypeEvent({required this.houseType});
}
class AddIsNearSearchEvent extends FilterEvent{
  final bool isNear;
  AddIsNearSearchEvent({required this.isNear});
}

class ResetEvent extends FilterEvent{}

class FilterPropertyEvent extends FilterEvent{}

class LoadMoreFilterPropertiesEvent extends FilterEvent {}