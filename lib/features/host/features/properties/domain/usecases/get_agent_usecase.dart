import 'package:dartz/dartz.dart';
import 'package:minapp/core/error/failure.dart';
import 'package:minapp/core/useCases/use_case.dart';
import 'package:minapp/features/host/features/properties/domain/entities/agent_entity.dart';
import 'package:minapp/features/host/features/properties/domain/repositories/property_repository.dart';

import '../../../../../../service_locator.dart';

class GetAgentUsecase extends UseCase<Either<Failure, AgentPEntity>, int> {
  @override
  Future<Either<Failure, AgentPEntity>> call(int param) async {
    return await sl<PropertyRepository>().getAgent(param);
  }
}
