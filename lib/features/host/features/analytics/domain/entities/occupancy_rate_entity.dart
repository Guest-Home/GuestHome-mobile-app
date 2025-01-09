


import 'package:equatable/equatable.dart';

class OccupancyRateEntity extends Equatable {
  final LastDaysEntity? last7Days;
  final LastDaysEntity? last30Days;
  final LastDaysEntity? last60Days;

  const OccupancyRateEntity({
    this.last7Days,
    this.last30Days,
    this.last60Days,
  });

  @override
  List<Object?> get props =>[last7Days,last30Days,last60Days];

}

class LastDaysEntity extends Equatable {
  final Map<String, double>? dailyOccupancy;
  final double? averageOccupancy;
  final int? totalRevenue;
  final int? totalReservations;

  const LastDaysEntity({
    this.dailyOccupancy,
    this.averageOccupancy,
    this.totalRevenue,
    this.totalReservations,
  });

  @override
  List<Object?> get props =>[dailyOccupancy,averageOccupancy,totalReservations,totalRevenue];
}
