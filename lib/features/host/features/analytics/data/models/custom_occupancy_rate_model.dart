
import 'package:minapp/features/host/features/analytics/domain/entities/custom_occupancy_rate_entity.dart';

class CustomOccupancyRateModel extends CustomOccupancyEntity {
  const CustomOccupancyRateModel({
    CustomModel? custom
  }):super(
    custom: custom
  );

  factory CustomOccupancyRateModel.fromMap(Map<String, dynamic> json) => CustomOccupancyRateModel(
    custom: CustomModel.fromMap(json["custom"]),
  );

}

class CustomModel extends CustomEntity {
  const CustomModel({
    Map<String, double>? dailyOccupancy,
    double? averageOccupancy,
    int? totalRevenue,
    int? totalReservations
  }):super(
    dailyOccupancy: dailyOccupancy,
    averageOccupancy: averageOccupancy,
    totalReservations: totalReservations,
      totalRevenue: totalRevenue
  );

  factory CustomModel.fromMap(Map<String, dynamic> json) => CustomModel(
    dailyOccupancy: Map.from(json["daily_occupancy"]).map((k, v) => MapEntry<String, double>(k, v.toDouble())),
    averageOccupancy: json["average_occupancy"].toDouble(),
    totalRevenue: json["total_revenue"],
    totalReservations: json["total_reservations"],
  );

}