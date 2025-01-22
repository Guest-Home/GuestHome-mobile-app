
import 'package:dartz/dartz.dart';
import 'package:minapp/features/host/features/analytics/domain/repositories/analytics_repository.dart';
import '../../../../../../core/error/failure.dart';
import '../../../../../../core/useCases/use_case.dart';
import '../../../../../../service_locator.dart';

class DownloadReportUseCase extends UseCase<Either<Failure,bool>,String>{
  @override
  Future<Either<Failure, bool>> call(String param)async{
    return await sl<AnalyticsRepository>().downloadReport(param);
  }

}