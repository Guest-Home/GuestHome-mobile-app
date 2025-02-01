part of 'filter_bloc.dart';

class FilterState extends Equatable {

  final String category;
  final String city;
  final double latitude;
  final double longtiude;
  final int range;
  final RangeValues priceRange;
  final bool isNearSearch;

  final GpropertyEntity properties;

  const FilterState({
     this.category='',
     this.city='',
     this.latitude=0.0,
     this.longtiude=0.0,
    this.range=0,
    this.priceRange=const RangeValues(100, 5000),
    this.isNearSearch=false,
    this.properties=const GpropertyEntity()
});

  FilterState copyWith({
    String? category,
    String? city,
    double? latitude,
    double? longtiude,
    int? range,
    RangeValues? priceRange,
    bool? isNearSearch,
    GpropertyEntity? properties
  }){
    return FilterState(
      category: category??this.category,
      city: city??this.city,
      latitude: latitude??this.latitude,
      longtiude: longtiude??this.longtiude,
      range: range??this.range,
      priceRange: priceRange??this.priceRange,
      isNearSearch: isNearSearch??this.isNearSearch,
        properties: properties??this.properties
    );
  }

  @override
  List<Object?> get props =>[category,city,longtiude,latitude,range,priceRange,isNearSearch,properties];

}

final class FilterInitial extends FilterState {}
class FilterDataLoadingState extends FilterState{
  FilterDataLoadingState(FilterState currentState):super(
    isNearSearch: currentState.isNearSearch,
    priceRange: currentState.priceRange,
    range: currentState.range,
    longtiude: currentState.longtiude,
    latitude: currentState.latitude,
    city: currentState.city,
    category: currentState.category,
      properties: currentState.properties

  );
}
class FilterDataLoadedState extends FilterState{
   FilterDataLoadedState({required FilterState currentState}):super(
      isNearSearch: currentState.isNearSearch,
      priceRange: currentState.priceRange,
      range: currentState.range,
      longtiude: currentState.longtiude,
      latitude: currentState.latitude,
      city: currentState.city,
      category: currentState.category,
     properties: currentState.properties
  );
}
class FilterDataLoadingMoreState extends FilterState{
  FilterDataLoadingMoreState({required FilterState currentState}):super(
      isNearSearch: currentState.isNearSearch,
      priceRange: currentState.priceRange,
      range: currentState.range,
      longtiude: currentState.longtiude,
      latitude: currentState.latitude,
      city: currentState.city,
      category: currentState.category,
      properties: currentState.properties
  );
}

class FilterErrorState extends FilterState{
  final Failure failure;
    FilterErrorState({required FilterState currentState,required this.failure}):super(
       isNearSearch: currentState.isNearSearch,
       priceRange: currentState.priceRange,
       range: currentState.range,
       longtiude: currentState.longtiude,
       latitude: currentState.latitude,
       city: currentState.city,
       category: currentState.category,
        properties: currentState.properties

    );
}
