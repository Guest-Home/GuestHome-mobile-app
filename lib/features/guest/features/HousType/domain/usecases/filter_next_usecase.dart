

import 'package:dartz/dartz.dart';
import 'package:minapp/core/error/failure.dart';
import 'package:minapp/core/useCases/use_case.dart';
import 'package:minapp/features/guest/features/HousType/domain/entities/g_property_entity.dart';
import 'package:minapp/features/guest/features/HousType/domain/repositories/house_repository.dart';

import '../../../../../../service_locator.dart';

class FilterNextUseCase extends UseCase<Either<Failure,GpropertyEntity>,Map<String,dynamic>>{
  @override
  Future<Either<Failure, GpropertyEntity>> call(Map<String, dynamic> param)async{
    return await sl<HouseRepository>().filterNextProperty(param);
  }


}