
import 'package:equatable/equatable.dart';

class TotalNumberOfPropertyEntity extends Equatable {
  final int totalNumberOfProperty;

  const TotalNumberOfPropertyEntity({
    required this.totalNumberOfProperty,
  });

  @override
  List<Object?> get props =>[totalNumberOfProperty];
}