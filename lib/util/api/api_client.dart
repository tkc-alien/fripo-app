import 'package:cloud_functions/cloud_functions.dart';
import 'package:dartz/dartz.dart';
import 'package:fripo/domain/error/failure.dart';

import '../../define/alias.dart';

class ApiClient {
  static final _instance = ApiClient._internal();

  factory ApiClient() => _instance;

  ApiClient._internal();

  final _functions = FirebaseFunctions.instance;

  Response<Json> call({
    required String endPoint,
    Json? parameters,
  }) async {
    try {
      final res = await _functions.httpsCallable(endPoint).call(parameters);
      return Right(res.data);
    } on FirebaseFunctionsException catch (e) {
      print('FirebaseFunctionsException: ${e.message}, ${e.code}');
      return Left(Failure(e.message ?? 'No Content'));
    } catch (e) {
      print('Exception(${e.runtimeType}): ${e.toString()}');
      return const Left(Failure('Unexpected Error'));
    }
  }
}
