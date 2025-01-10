import 'dart:isolate';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:minapp/features/host/features/properties/data/models/amenity_model.dart';
import 'package:minapp/features/host/features/properties/data/models/city_model.dart';
import 'package:minapp/features/host/features/properties/data/models/property_model.dart';
import 'package:minapp/features/host/features/properties/domain/usecases/create_property_usecase.dart';
import 'package:minapp/features/host/features/properties/domain/usecases/update_property_usecase.dart';

import '../../../../../../core/apiConstants/api_url.dart';
import '../../../../../../core/error/failure.dart';
import '../../../../../../core/network/dio_client.dart';
import '../../../../../../service_locator.dart';
import '../models/property_type_model.dart';

abstract class PropertyApiDataSource {
  Future<Either<Failure, List<PropertyModel>>> getProperties();
  Future<Either<Failure, List<PropertyTypeModel>>> getPropertiesType();
  Future<Either<Failure, List<AmenityModel>>> getAmenity();
  Future<Either<Failure, List<CityModel>>> getCities();
  Future<Either<Failure, bool>> createProperty(CreatePropertyParam param);
  Future<Either<Failure, bool>> deleteProperty(int id);
  Future<Either<Failure, bool>> updateProperty(UpdatePropertyParam param);
}

class PropertyApiDataSourceImpl implements PropertyApiDataSource {
  @override
  Future<Either<Failure, List<PropertyModel>>> getProperties() async {
    try {
      final response = await sl<DioClient>().get(ApiUrl.property);
      if (response.statusCode == 200) {
        final properties = await Isolate.run(
          () {
            return (response.data as List)
                .map((e) => PropertyModel.fromMap(e))
                .toList();
          },
        );
        return Right(properties);
      } else {
        return Left(ServerFailure(response.data['error']));
      }
    } on DioException catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<PropertyTypeModel>>> getPropertiesType() async {
    try {
      final response = await sl<DioClient>().get(ApiUrl.propertyType);
      if (response.statusCode == 200) {
        final propertyType = await Isolate.run(
          () {
            return (response.data['property_types'] as List)
                .map((e) => PropertyTypeModel.fromJson(e))
                .toList();
          },
        );
        return Right(propertyType);
      } else {
        return Left(ServerFailure(response.data['error']));
      }
    } on DioException catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<AmenityModel>>> getAmenity() async {
    try {
      final response = await sl<DioClient>().get(ApiUrl.amenities);
      if (response.statusCode == 200) {
        final amenities = await Isolate.run(
          () {
            return (response.data['amenities'] as List)
                .map((e) => AmenityModel.fromJson(e))
                .toList();
          },
        );
        return Right(amenities);
      } else {
        return Left(ServerFailure(response.data['error']));
      }
    } on DioException catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<CityModel>>> getCities() async {
    try {
      final response = await sl<DioClient>().get(ApiUrl.cities);
      if (response.statusCode == 200) {
        final cities = await Isolate.run(
          () {
            return (response.data['cities'] as List)
                .map((e) => CityModel.fromJson(e))
                .toList();
          },
        );
        return Right(cities);
      } else {
        return Left(ServerFailure(response.data['error']));
      }
    } on DioException catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> createProperty(
      CreatePropertyParam param) async {
    try {
      final response = await sl<DioClient>().post(ApiUrl.property,
          data: param.formData,
          options: Options(contentType: 'multipart/form-data'));
      if (response.statusCode == 201) {
        return Right(true);
      } else {
        return Left(ServerFailure(response.data['error']));
      }
    } on DioException catch (e) {
      print(e.message);
      return Left(ServerFailure(e.response!.statusMessage.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> deleteProperty(int id) async {
    try {
      await sl<DioClient>().delete(
        "${ApiUrl.property}$id/",
      );

      return Right(true);
    } on DioException catch (e) {
      return Left(ServerFailure(e.response!.statusMessage.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> updateProperty(UpdatePropertyParam param,)async{
    try {
      final response = await sl<DioClient>().put("${ApiUrl.property}${param.id}/",
          data: param.formData,
          options: Options(contentType: 'multipart/form-data'));
      if (response.statusCode == 200) {
        return Right(true);
      } else {
        return Left(ServerFailure(response.data['error']));
      }
    } on DioException catch (e) {
      return Left(ServerFailure(e.response!.statusMessage.toString()));
    }
  }
}
