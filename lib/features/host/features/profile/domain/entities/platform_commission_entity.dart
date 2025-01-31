
import 'package:equatable/equatable.dart';

class PlatformCommissionEntity extends Equatable {
  final String? currentCommissionRate;
  final CommissionBreakdownEntity? commissionBreakdown;
  final List<RecentCommissionHistoryEntity>? recentCommissionHistory;

  const PlatformCommissionEntity({
    this.currentCommissionRate,
    this.commissionBreakdown,
    this.recentCommissionHistory,
  });

  @override
  List<Object?> get props =>[currentCommissionRate,commissionBreakdown,recentCommissionHistory];
}

class CommissionBreakdownEntity extends Equatable {
  final int? totalBooking;
  final String? commissionPaid;

  const CommissionBreakdownEntity({
    this.totalBooking,
    this.commissionPaid,
  });

  @override

  List<Object?> get props =>[totalBooking,commissionPaid];
}

class RecentCommissionHistoryEntity extends Equatable{
  final int? bookingId;
  final String? transactionDate;
  final String? amount;

  const RecentCommissionHistoryEntity({
    this.bookingId,
    this.transactionDate,
    this.amount,
  });

  @override
  List<Object?> get props =>[bookingId,transactionDate,amount];
}
