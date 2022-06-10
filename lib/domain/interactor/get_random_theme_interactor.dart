import 'dart:convert';
import 'dart:math';

import 'package:dartz/dartz.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:fripo/define/alias.dart';
import 'package:fripo/domain/error/failure.dart';
import 'package:fripo/domain/use_case/get_random_theme_use_case.dart';

class GetRandomThemeInteractor implements GetRandomThemeUseCase {
  @override
  Response<String> call() async {
    try {
      final json = await rootBundle.loadString('assets/json/theme_list.json');
      final list = jsonDecode(json) as List<dynamic>;
      return Right(list[Random().nextInt(list.length)]);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }
}
