import 'dart:isolate';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:minapp/features/guest/features/HousType/data/models/guest_property_model.dart';
import 'package:minapp/features/host/features/properties/data/models/amenity_model.dart';
import 'package:minapp/features/host/features/properties/data/models/city_model.dart';
import 'package:minapp/features/host/features/properties/data/models/property_model.dart';
import 'package:minapp/features/host/features/properties/domain/usecases/create_property_usecase.dart';
import 'package:minapp/features/host/features/properties/domain/usecases/update_property_usecase.dart';
import '../../../../../../core/apiConstants/api_url.dart';
import '../../../../../../core/error/error_response.dart';
import '../../../../../../core/error/failure.dart';
import '../../../../../../core/network/dio_client.dart';
import '../../../../../../service_locator.dart';
import '../models/agent_model.dart';
import '../models/property_type_model.dart';

abstract class PropertyApiDataSource {
  Future<Either<Failure, List<PropertyModel>>> getProperties();
  Future<Either<Failure, List<PropertyTypeModel>>> getPropertiesType();
  Future<Either<Failure, List<AmenityModel>>> getAmenity();
  Future<Either<Failure, List<CityModel>>> getCities();
  Future<Either<Failure, bool>> createProperty(CreatePropertyParam param);
  Future<Either<Failure, bool>> deleteProperty(int id);
  Future<Either<Failure, bool>> updateProperty(UpdatePropertyParam param);
  Future<Either<Failure, AgentPModel>> getAgent(int id);
  Future<Either<Failure, GuestPropertyModel>> searchProperty(String name);
  Future<Either<Failure, List<PropertyModel>>> hostSearchProperty(String name);
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
      return Left(ErrorResponse().mapDioExceptionToFailure(e));
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
        return Left(ServerFailure(response.data['Error']));
      }
    } on DioException catch (e) {
      return Left(ErrorResponse().mapDioExceptionToFailure(e));
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
      return Left(ErrorResponse().mapDioExceptionToFailure(e));
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
      return Left(ErrorResponse().mapDioExceptionToFailure(e));
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
      return Left(ServerFailure(e.response!.statusMessage!));
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
  Future<Either<Failure, bool>> updateProperty(
    UpdatePropertyParam param,
  ) async {
    try {
      final response = await sl<DioClient>().put(
          "${ApiUrl.property}${param.id}/",
          data: param.formData,
          options: Options(contentType: 'multipart/form-data'));
      if (response.statusCode == 200) {
        return Right(true);
      } else {
        return Left(ServerFailure(response.data['error']));
      }
    } on DioException catch (e) {
      return Left(ServerFailure(e.response!.statusMessage!));
    }
  }

  @override
  Future<Either<Failure, AgentPModel>> getAgent(int id) async {
    try {
      final response = await sl<DioClient>().get("${ApiUrl.agent}$id/");
      if (response.statusCode == 200) {
        AgentPModel agent = await Isolate.run(
          () {
            return AgentPModel.fromMap(response.data);
          },
        );
        return Right(agent);
      } else {
        return Left(ServerFailure(response.data['error']));
      }
    } on DioException catch (e) {
      return Left(ServerFailure(e.response!.data['msg'].toString()));
    }
  }

  @override
  Future<Either<Failure, GuestPropertyModel>> searchProperty(String name) async {
    try {
      final response =name.contains(ApiUrl.baseUrl)?await sl<DioClient>().get(name.substring(ApiUrl.baseUrl.length)):
      await sl<DioClient>().get("${ApiUrl.searchProperties}?query=$name");
      if (response.statusCode == 200) {
        final properties = await Isolate.run(
          () {
            return GuestPropertyModel.fromMap(response.data);
          },
        );
        return Right(properties);
      } else {
        return Left(ServerFailure(response.data['error']));
      }
    } on DioException catch (e) {
      return Left(ErrorResponse().mapDioExceptionToFailure(e));
    }
  }

  @override
  Future<Either<Failure, List<PropertyModel>>> hostSearchProperty(
      String name) async {
    try {
      final response =
          await sl<DioClient>().get("${ApiUrl.hostHouseSearch}?query=$name");
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
      return Left(ErrorResponse().mapDioExceptionToFailure(e));
    }
  }
}
