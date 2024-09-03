import 'package:fpdart/fpdart.dart';
import 'package:smart_refrigerator/src/core/errors/failure.dart';

abstract interface class UseCase<SuccessType, Params> {
  Future<Either<Failure, SuccessType>> call(Params params);
}
