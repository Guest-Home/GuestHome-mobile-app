import 'package:dartz/dartz.dart';
import 'package:minapp/core/error/failure.dart';
import 'package:minapp/core/useCases/use_case.dart';
import 'package:minapp/features/host/features/properties/domain/repositories/property_repository.dart';

import '../../../../../../service_locator.dart';

class DeletePropertyUsecase extends UseCase<Either<Failure, bool>, int> {
  @override
  Future<Either<Failure, bool>> call(int param) async {
    return await sl<PropertyRepository>().deleteProperty(param);
  }
}
