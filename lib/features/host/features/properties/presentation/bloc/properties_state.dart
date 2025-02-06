part of 'properties_bloc.dart';

class PropertiesState extends Equatable {
   const PropertiesState({this.properties=const []});
  final List<PropertyEntity> properties;

   PropertiesState copyWith({
     List<PropertyEntity>? properties
}){
     return PropertiesState(
       properties: properties??this.properties
     );
}

  @override
  List<Object> get props => [properties];
}

class PropertiesInitial extends PropertiesState {}

class PropertiesLoading extends PropertiesState {
  PropertiesLoading(PropertiesState currentState):super(
    properties: currentState.properties
  );
}

class NoInternetSate extends PropertiesState {}

class PropertyLoaded extends PropertiesState {
  PropertyLoaded(PropertiesState currentState):super(
      properties: currentState.properties
  );

}

class PropertiesError extends PropertiesState {
  final Failure failure;
   PropertiesError(PropertiesState currentState,{required this.failure}):super(
    properties: currentState.properties
  );
  @override
  List<Object> get props =>super.props+ [failure];
}
