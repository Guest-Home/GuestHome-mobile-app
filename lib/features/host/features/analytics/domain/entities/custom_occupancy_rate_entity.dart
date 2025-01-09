

import 'package:equatable/equatable.dart';

class CustomOccupancyEntity extends Equatable {
 final CustomEntity? custom;

  const CustomOccupancyEntity({
    this.custom,
  });

  @override
  List<Object?> get props =>[custom];
}

class CustomEntity extends Equatable {
  final Map<String, double>? dailyOccupancy;
  final double? averageOccupancy;
  final int? totalRevenue;
 final int? totalReservations;

  const CustomEntity({
    this.dailyOccupancy,
    this.averageOccupancy,
    this.totalRevenue,
    this.totalReservations,
  });

  @override
  List<Object?> get props =>[dailyOccupancy,averageOccupancy,totalRevenue,totalReservations];

}