
import 'package:flutter/material.dart';

enum BookingStatus {
  approved("Approved",Colors.green),
  pending("Waiting for Approval", Colors.orange),
  rejected("Rejected", Colors.red);

  final String status;
  final Color backgroundColor;

  const BookingStatus(this.status, this.backgroundColor);
}