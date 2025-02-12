import '../../domain/entities/payment_config_entity.dart';

class PaymentConfigModel extends PaymentConfigEntity {
  const PaymentConfigModel({
    required super.id,
    required super.host,
    required super.isRequired,
  });

  factory PaymentConfigModel.fromMap(Map<String, dynamic> json) => PaymentConfigModel(
    id: json["id"],
    host: json["host"],
    isRequired: json["is_required"],
  );

}