abstract class UseCase<Type, Param> {
  Future<Type> call(Param param);
}

abstract class UseCaseWithOutProp<Type> {
  Future<Type> call();
}
