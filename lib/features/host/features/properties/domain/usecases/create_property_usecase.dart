import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:minapp/core/error/failure.dart';
import 'package:minapp/core/useCases/use_case.dart';
import 'package:minapp/features/host/features/properties/domain/repositories/property_repository.dart';
import 'package:minapp/service_locator.dart';

class CreatePropertyUsecase
    extends UseCase<Either<Failure, bool>, CreatePropertyParam> {
  @override
  Future<Either<Failure, bool>> call(CreatePropertyParam param) async {
    return await sl<PropertyRepository>().createProperty(param);
  }
}

class CreatePropertyParam extends Equatable {
  final FormData formData;

  const CreatePropertyParam({required this.formData});

  @override
  List<Object?> get props => [formData];
}
