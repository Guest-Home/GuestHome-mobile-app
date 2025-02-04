

import '../../domain/entities/deposit_transaction_model.dart';

class DepositTransactionModel extends DepositTransactionEntity {
  const DepositTransactionModel({
    required super.count,
    required super.previous,
    required super.next,
    required super.results,
});
  factory DepositTransactionModel.fromMap(Map<String, dynamic> json) => DepositTransactionModel(
    count: json["count"],
    next: json["next"],
    previous: json["previous"],
    results: List<Result>.from(json["results"].map((x) => ResultModel.fromMap(x))),
  );

}

class ResultModel extends Result {

  const ResultModel({
    required super.amount,
    required super.transactionId,
    required super.status,
    required super.paymentMethod,
    required super.typeOfTransaction,
    required super.timeStamp,

  });

  factory ResultModel.fromMap(Map<String, dynamic> json) => ResultModel(
    amount: json["amount"],
    transactionId: json["transaction_id"],
    status: json["status"],
    paymentMethod: json["payment_method"],
    typeOfTransaction: json["type_of_transaction"],
    timeStamp:json["time_Stamp"],
  );

}
