
import 'package:equatable/equatable.dart';

class DepositTransactionEntity extends Equatable {
 final int? count;
final  dynamic next;
  final dynamic previous;
 final List<Result>? results;

  const DepositTransactionEntity({
    this.count,
    this.next,
    this.previous,
    this.results,
  });
 DepositTransactionEntity copyWith({
   List<Result>? results,
   dynamic next,
   int? count,
   String? previous,
}){
   return DepositTransactionEntity(
     results: results??this.results,
     count: count??this.count,
     previous: previous??this.previous,
     next: next??this.next
   );
 }

  @override
  List<Object?> get props =>[count,next,previous,results];
}

class Result extends Equatable {
 final String? amount;
 final String? transactionId;
 final String? status;
 final String? paymentMethod;
 final String? typeOfTransaction;
 final String? timeStamp;

  const Result({
    this.amount,
    this.transactionId,
    this.status,
    this.paymentMethod,
    this.typeOfTransaction,
    this.timeStamp,
  });

  @override
  List<Object?> get props =>[amount,transactionId,status,paymentMethod,typeOfTransaction,timeStamp];

}
