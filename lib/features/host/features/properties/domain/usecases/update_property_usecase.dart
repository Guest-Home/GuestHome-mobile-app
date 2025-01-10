

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:minapp/core/error/failure.dart';
import 'package:minapp/core/useCases/use_case.dart';
import 'package:minapp/features/host/features/properties/domain/repositories/property_repository.dart';

import '../../../../../../service_locator.dart';

class UpdatePropertyUseCase extends UseCase<Either<Failure,bool>,UpdatePropertyParam>{
  @override
  Future<Either<Failure, bool>> call(UpdatePropertyParam param)async{
    return await sl<PropertyRepository>().updateProperty(param);
  }

}

class UpdatePropertyParam extends Equatable {
  final FormData formData;
  final int id;

  const UpdatePropertyParam({required this.formData,required this.id});

  @override
  List<Object?> get props => [formData];
}