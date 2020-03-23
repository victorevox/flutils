import 'package:dartz/dartz.dart';

import '../architecture.dart';

abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}

class NoParams {
  @override
  int get hashCode => super.hashCode;

  @override
  bool operator ==(Object o) {
    return o is NoParams;
  }
}
