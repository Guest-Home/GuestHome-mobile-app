
import 'package:dartz/dartz.dart';
import 'package:minapp/core/error/failure.dart';
import 'package:minapp/features/guest/features/HousType/data/models/g_property_model.dart';
import 'package:minapp/features/host/features/properties/domain/entities/property_entity.dart';
import 'package:minapp/features/search/domain/repositories/search_repository.dart';

import '../../../../service_locator.dart';
import '../../../host/features/properties/data/datasources/property_api_data_source.dart';

class SearchRepositoryImpl implements SearchRepository{
  @override
  Future<Either<Failure,GpropertyModel>> searchProperty(String name)async{
    return await sl<PropertyApiDataSource>().searchProperty(name);
  }

  @override
  Future<Either<Failure, List<PropertyEntity>>> hostSearchProperty(String name)async{
    return await sl<PropertyApiDataSource>().hostSearchProperty(name);
  }

}
