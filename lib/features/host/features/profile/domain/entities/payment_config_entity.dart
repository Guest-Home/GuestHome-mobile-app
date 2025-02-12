import 'package:equatable/equatable.dart';

class PaymentConfigEntity extends Equatable{
  final int? id;
  final int? host;
  final bool? isRequired;

  const PaymentConfigEntity({
    this.id,
    this.host,
    this.isRequired,
  });

  @override
  List<Object?> get props =>[id,host,isRequired];

}