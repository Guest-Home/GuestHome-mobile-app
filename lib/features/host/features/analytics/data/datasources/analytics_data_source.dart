import 'dart:io';
import 'dart:isolate';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:minapp/features/host/features/analytics/data/models/custom_occupancy_rate_model.dart';
import 'package:minapp/features/host/features/analytics/data/models/occupancy_raate_model.dart';
import 'package:minapp/features/host/features/analytics/data/models/total_no_property_model.dart';
import 'package:path_provider/path_provider.dart';

import '../../../../../../core/apiConstants/api_url.dart';
import '../../../../../../core/error/failure.dart';
import '../../../../../../core/network/dio_client.dart';
import '../../../../../../service_locator.dart';

abstract class AnalyticsDataSource {
  Future<Either<Failure, OccupancyRateModel>> getOccupancyRate();
  Future<Either<Failure, TotalNumberOfPropertyModel>> getTotalProperty();
  Future<Either<Failure, CustomOccupancyRateModel>> getCustomOccupancyRate(
      Map<String, dynamic> dates);
  Future<Either<Failure,bool>> downloadReport(String dates);
  Future<Either<Failure,bool>> downloadReportCustom(Map<String,dynamic> dates);

}

class AnalyticsDataSourceImpl extends AnalyticsDataSource {
  @override
  Future<Either<Failure, OccupancyRateModel>> getOccupancyRate() async {
    try {
      final response = await sl<DioClient>().get(ApiUrl.occupancyRate);
      if (response.statusCode == 200) {
        final occupancyRate = await Isolate.run(
          () {
            return OccupancyRateModel.fromJson(response.data);
          },
        );
        return Right(occupancyRate);
      } else {
        return Left(ServerFailure(response.data['error']));
      }
    } on DioException catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, TotalNumberOfPropertyModel>> getTotalProperty() async {
    try {
      final response = await sl<DioClient>().get(ApiUrl.totalProperty);
      if (response.statusCode == 200) {
        final totalProperty = await Isolate.run(
          () {
            return TotalNumberOfPropertyModel.fromMap(response.data);
          },
        );
        return Right(totalProperty);
      } else {
        return Left(ServerFailure(response.data['error']));
      }
    } on DioException catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, CustomOccupancyRateModel>> getCustomOccupancyRate(
      Map<String, dynamic> dates) async {
    final startDate = dates['startDate'];
    final endDate = dates['endDate'];
    try {
      final response = await sl<DioClient>().get(
          "${ApiUrl.occupancyRate}?start_date=$startDate&end_date=$endDate");
      if (response.statusCode == 200) {
        final occupancyRate = await Isolate.run(
          () {
            return CustomOccupancyRateModel.fromMap(response.data);
          },
        );
        return Right(occupancyRate);
      } else {
        return Left(ServerFailure(response.data['error']));
      }
    } on DioException catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> downloadReport(String dates)async{
    try {
      final response = await sl<DioClient>().get(
          "${ApiUrl.downloadReport}?dateFilter=$dates",
        options: Options(
          responseType: ResponseType.bytes, // Get raw file bytes
        ),
      );
      if (response.statusCode == 200) {
        // Get the directory to save the file
        Directory? directory;
        // Get the appropriate directory
        if (Platform.isAndroid) {
          directory = Directory('/storage/emulated/0/Download');
        } else if (Platform.isIOS) {
          directory = await getApplicationDocumentsDirectory();
        }

        if (directory == null || !directory.existsSync()) {
          return Left(ServerFailure("Failed to access the Downloads directory"));
        }
        // Get the filename from the headers or default
        String fileName = 'downloaded_file.xlsx';
        final contentDisposition = response.headers['content-disposition']?.first;
        if (contentDisposition != null && contentDisposition.contains('filename=')) {
          final startIndex = contentDisposition.indexOf('filename=') + 9;
          fileName = contentDisposition.substring(startIndex).replaceAll('"', '');
        }
        final filePath = '${directory.path}/${dates}days-$fileName}';
        // Save the file
        final file = File(filePath);
        await file.writeAsBytes(response.data);

        return Right(true);
      } else {
        return Left(ServerFailure(response.data['error']));
      }
    } on DioException catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> downloadReportCustom(Map<String, dynamic> dates)async{
    final startDate = dates['startDate'];
    final endDate = dates['endDate'];
    try {
      final response = await sl<DioClient>().get(
          "${ApiUrl.downloadReport}?startDate=$startDate&endDate=$endDate",
        options: Options(
          responseType: ResponseType.bytes, // Get raw file bytes
        ),
      );
      if (response.statusCode == 200) {
        // Get the directory to save the file
        Directory? directory;
        // Get the appropriate directory
        if (Platform.isAndroid) {
          directory = Directory('/storage/emulated/0/Download');
        } else if (Platform.isIOS) {
          directory = await getApplicationDocumentsDirectory();
        }

        if (directory == null || !directory.existsSync()) {
          return Left(ServerFailure("Failed to access the Downloads directory"));
        }
        // Get the filename from the headers or default
        String fileName = 'downloaded_file.xlsx';
        final contentDisposition = response.headers['content-disposition']?.first;
        if (contentDisposition != null && contentDisposition.contains('filename=')) {
          final startIndex = contentDisposition.indexOf('filename=') + 9;
          fileName = contentDisposition.substring(startIndex).replaceAll('"', '');
        }
        final filePath = '${directory.path}/${startDate.toString()}-${endDate.toString()}days-$fileName}';
        // Save the file
        final file = File(filePath);
        await file.writeAsBytes(response.data);

        return Right(true);
      } else {
        return Left(ServerFailure(response.data['error']));
      }
    } on DioException catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
