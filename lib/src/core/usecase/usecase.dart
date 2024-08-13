import 'package:fpdart/fpdart.dart';
import 'package:smart_aquarium/src/core/errors/failure.dart';

abstract interface class UseCase<SuccessType, Params> {
  Future<Either<Failure, SuccessType>> call(Params params);
}
