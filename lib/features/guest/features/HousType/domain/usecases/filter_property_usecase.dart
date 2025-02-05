

import 'package:dartz/dartz.dart';
import 'package:minapp/core/error/failure.dart';
import 'package:minapp/core/useCases/use_case.dart';
import 'package:minapp/features/guest/features/HousType/domain/repositories/house_repository.dart';

import '../../../../../../service_locator.dart';
import '../entities/guest_property_entity.dart';

class FilterPropertyUseCase extends UseCase<Either<Failure,GuestPropertyEntity>,Map<String,dynamic>>{
  @override
  Future<Either<Failure, GuestPropertyEntity>> call(Map<String, dynamic> param)async{
    return await sl<HouseRepository>().filterProperty(param);
  }

}