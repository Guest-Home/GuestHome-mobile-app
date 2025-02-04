
import 'package:minapp/features/host/features/profile/domain/entities/platform_commission_entity.dart';

class PlatformCommissionModel extends PlatformCommissionEntity {
  const PlatformCommissionModel({
   required super.currentCommissionRate,
    required super.commissionBreakdown,
    required super.recentCommissionHistory,
  });

  factory PlatformCommissionModel.fromMap(Map<String, dynamic> json) => PlatformCommissionModel(
    currentCommissionRate: json["current_commission_rate"],
    commissionBreakdown: CommissionBreakdownModel.fromMap(json["commission_breakdown"]),
    recentCommissionHistory: List<RecentCommissionHistoryModel>.from(json["recent_commission_history"].map((x) => RecentCommissionHistoryModel.fromMap(x))),
  );

}

class CommissionBreakdownModel extends CommissionBreakdownEntity {

  const CommissionBreakdownModel({
    required super.totalBooking,
    required super.commissionPaid,
  });

  factory CommissionBreakdownModel.fromMap(Map<String, dynamic> json) => CommissionBreakdownModel(
    totalBooking: json["total_booking"],
    commissionPaid: json["commission_paid"],
  );

}

class RecentCommissionHistoryModel extends RecentCommissionHistoryEntity {
  const RecentCommissionHistoryModel({
    required super.bookingId,
    required super.transactionDate,
    required super.amount,
  });

  factory RecentCommissionHistoryModel.fromMap(Map<String, dynamic> json) => RecentCommissionHistoryModel(
    bookingId: json["booking_id"],
    transactionDate: json["transaction_date"],
    amount: json["amount"],
  );

}
