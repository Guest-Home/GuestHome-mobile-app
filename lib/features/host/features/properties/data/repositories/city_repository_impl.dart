import 'package:dartz/dartz.dart';
import 'package:minapp/core/error/failure.dart';
import 'package:minapp/features/host/features/properties/data/datasources/property_api_data_source.dart';
import 'package:minapp/features/host/features/properties/data/models/city_model.dart';
import 'package:minapp/features/host/features/properties/domain/repositories/city_repository.dart';
import 'package:minapp/service_locator.dart';

class CityRepositoryImpl implements CityRepository {
  @override
  Future<Either<Failure, List<CityModel>>> getCities() async {
    return await sl<PropertyApiDataSource>().getCities();
  }
}
