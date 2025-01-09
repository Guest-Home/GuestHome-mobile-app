
import '../../domain/entities/occupancy_rate_entity.dart';

class OccupancyRateModel extends OccupancyRateEntity {
  const OccupancyRateModel({
    LastDaysModel? last7Days,
    LastDaysModel? last30Days,
    LastDaysModel? last60Days,
  }) : super(
    last7Days: last7Days,
    last30Days: last30Days,
    last60Days: last60Days,
  );

  factory OccupancyRateModel.fromJson(Map<String, dynamic> json) {
    return OccupancyRateModel(
      last7Days: json['last_7_days'] != null
          ? LastDaysModel.fromJson(json['last_7_days'])
          : null,
      last30Days: json['last_30_days'] != null
          ? LastDaysModel.fromJson(json['last_30_days'])
          : null,
      last60Days: json['last_60_days'] != null
          ? LastDaysModel.fromJson(json['last_60_days'])
          : null,
    );
  }

}

class LastDaysModel extends LastDaysEntity {
  const LastDaysModel({
    Map<String, double>? dailyOccupancy,
    double? averageOccupancy,
    int? totalRevenue,
    int? totalReservations,
  }) : super(
    dailyOccupancy: dailyOccupancy,
    averageOccupancy: averageOccupancy,
    totalRevenue: totalRevenue,
    totalReservations: totalReservations,
  );

  factory LastDaysModel.fromJson(Map<String, dynamic> json) {
    return LastDaysModel(
      dailyOccupancy: json['daily_occupancy'] != null
          ? Map<String, double>.from(json['daily_occupancy'])
          : null,
      averageOccupancy: (json['average_occupancy'] as num?)?.toDouble(),
      totalRevenue: json['total_revenue'] as int?,
      totalReservations: json['total_reservations'] as int?,
    );
  }
}
