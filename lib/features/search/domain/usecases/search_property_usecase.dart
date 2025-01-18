
import 'package:dartz/dartz.dart';
import 'package:minapp/core/error/failure.dart';
import 'package:minapp/core/useCases/use_case.dart';
import 'package:minapp/features/host/features/properties/domain/entities/property_entity.dart';
import 'package:minapp/features/search/domain/repositories/search_repository.dart';

import '../../../../service_locator.dart';

class SearchPropertyUseCase extends UseCase<Either<Failure,List<PropertyEntity>>,String>{
  @override
  Future<Either<Failure, List<PropertyEntity>>> call(String param)async{
    return await sl<SearchRepository>().searchProperty(param);
  }
}