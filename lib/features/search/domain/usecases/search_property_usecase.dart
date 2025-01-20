
import 'package:dartz/dartz.dart';
import 'package:minapp/core/error/failure.dart';
import 'package:minapp/core/useCases/use_case.dart';
import 'package:minapp/features/guest/features/HousType/domain/entities/g_property_entity.dart';
import 'package:minapp/features/search/domain/repositories/search_repository.dart';

import '../../../../service_locator.dart';

class SearchPropertyUseCase extends UseCase<Either<Failure,GpropertyEntity>,String>{
  @override
  Future<Either<Failure,GpropertyEntity>> call(String param)async{
    return await sl<SearchRepository>().searchProperty(param);
  }
}