import 'package:dartz/dartz.dart';
import 'package:minapp/core/error/failure.dart';
import 'package:minapp/features/guest/features/HousType/data/datasources/house_data_source.dart';
import 'package:minapp/features/guest/features/HousType/data/models/g_property_model.dart';
import 'package:minapp/features/guest/features/HousType/domain/entities/g_property_entity.dart';
import 'package:minapp/features/guest/features/HousType/domain/repositories/house_repository.dart';

import '../../../../../../service_locator.dart';

class HouseRepositoryImpl implements HouseRepository {
  @override
  Future<Either<Failure, GpropertyModel>> getPropertyByType(String name) async {
    return await sl<HouseDataSource>().getPropertyByType(name);
  }



  @override
  Future<Either<Failure, bool>> bookingProperty(Map<String, dynamic> bookData)async{
    return await sl<HouseDataSource>().bookingProperty(bookData);
  }

  @override
  Future<Either<Failure, GpropertyModel>> filterProperty(Map<String, dynamic> filterData)async{
    return await sl<HouseDataSource>().filterProperty(filterData);
  }

  @override
  Future<Either<Failure, GpropertyModel>> getPopularProperty(String? url)async{
      return await sl<HouseDataSource>().getPopularProperty(url);

  }

  @override
  Future<Either<Failure, GpropertyModel>> filterNextProperty(Map<String,dynamic> filterData) async{
    return await sl<HouseDataSource>().filterNextProperty(filterData);
  }
}
