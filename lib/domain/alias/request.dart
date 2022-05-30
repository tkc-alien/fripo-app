import 'package:dartz/dartz.dart';
import 'package:fripo/domain/error/failure.dart';

typedef Response<T> = Future<Either<Failure, T>>;
