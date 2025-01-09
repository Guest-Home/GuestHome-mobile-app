part of 'total_property_bloc.dart';

class TotalPropertyState extends Equatable {
  const TotalPropertyState({
    this.totalProperty=const TotalNumberOfPropertyEntity(totalNumberOfProperty: 0)
});
  final TotalNumberOfPropertyEntity totalProperty;

  TotalPropertyState copyWith(
  {
    TotalNumberOfPropertyEntity? totalProperty
}
      ){
    return TotalPropertyState(
      totalProperty: totalProperty??this.totalProperty

    );

  }
  @override
  List<Object?> get props =>[totalProperty];
}

final class TotalPropertyInitial extends TotalPropertyState {
  @override
  List<Object> get props => [];
}
class TotalPropertyLoadingState extends TotalPropertyState{}
class TotalPropertyErrorState extends TotalPropertyState{
  final Failure failure;
  const TotalPropertyErrorState({required this.failure});
}