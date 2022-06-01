import 'package:fripo/domain/interactor/mock/mock_exit_room_interactor.dart';
import 'package:fripo/domain/interactor/mock/mock_get_random_theme_interactor.dart';
import 'package:fripo/domain/interactor/mock/mock_register_user_interactor.dart';
import 'package:fripo/domain/interactor/mock/mock_send_answer_use_case.dart';
import 'package:fripo/domain/interactor/mock/mock_send_theme_interactor.dart';
import 'package:fripo/domain/interactor/mock/mock_start_room_interactor.dart';
import 'package:fripo/domain/use_case/exit_room_use_case.dart';
import 'package:fripo/domain/use_case/get_random_theme_use_case.dart';
import 'package:fripo/domain/use_case/register_user_use_case.dart';
import 'package:fripo/domain/use_case/send_answer_use_case.dart';
import 'package:fripo/domain/use_case/send_points_use_case.dart';
import 'package:fripo/domain/use_case/send_theme_use_case.dart';
import 'package:fripo/domain/use_case/start_room_use_case.dart';
import 'package:get_it/get_it.dart';

import 'domain/interactor/mock/mock_create_room_interactor.dart';
import 'domain/interactor/mock/mock_get_room_stream_interactor.dart';
import 'domain/interactor/mock/mock_join_room_interactor.dart';
import 'domain/interactor/mock/mock_send_points_interactor.dart';
import 'domain/use_case/create_room_use_case.dart';
import 'domain/use_case/get_room_stream_use_case.dart';
import 'domain/use_case/join_room_use_case.dart';

enum Env {
  product,
  develop,
  mock,
}

final sl = GetIt.instance;

void init([Env env = Env.develop]) {
  sl.registerLazySingleton<RegisterUserUseCase>(() {
    switch (env) {
      case Env.product:
        throw Exception();
      case Env.develop:
        throw Exception();
      case Env.mock:
        return MockRegisterUserInteractor();
    }
  });

  sl.registerLazySingleton<CreateRoomUseCase>(() {
    switch (env) {
      case Env.product:
        throw Exception();
      case Env.develop:
        throw Exception();
      case Env.mock:
        return MockCreateRoomInteractor();
    }
  });

  sl.registerLazySingleton<JoinRoomUseCase>(() {
    switch (env) {
      case Env.product:
        throw Exception();
      case Env.develop:
        throw Exception();
      case Env.mock:
        return MockJoinRoomInteractor();
    }
  });

  sl.registerLazySingleton<ExitRoomUseCase>(() {
    switch (env) {
      case Env.product:
        throw Exception();
      case Env.develop:
        throw Exception();
      case Env.mock:
        return MockExitRoomInteractor();
    }
  });

  sl.registerLazySingleton<StartRoomUseCase>(() {
    switch (env) {
      case Env.product:
        throw Exception();
      case Env.develop:
        throw Exception();
      case Env.mock:
        return MockStartRoomInteractor();
    }
  });

  sl.registerLazySingleton<GetRoomStreamUseCase>(() {
    switch (env) {
      case Env.product:
        throw Exception();
      case Env.develop:
        throw Exception();
      case Env.mock:
        return MockGetRoomStreamInteractor();
    }
  });

  sl.registerLazySingleton<SendThemeUseCase>(() {
    switch (env) {
      case Env.product:
        throw Exception();
      case Env.develop:
        throw Exception();
      case Env.mock:
        return MockSendThemeInteractor();
    }
  });

  sl.registerLazySingleton<GetRandomThemeUseCase>(() {
    switch (env) {
      case Env.product:
        throw Exception();
      case Env.develop:
        throw Exception();
      case Env.mock:
        return MockGetRandomThemeInteractor();
    }
  });

  sl.registerLazySingleton<SendAnswerUseCase>(() {
    switch (env) {
      case Env.product:
        throw Exception();
      case Env.develop:
        throw Exception();
      case Env.mock:
        return MockSendAnswerInteractor();
    }
  });

  sl.registerLazySingleton<SendPointsUseCase>(() {
    switch (env) {
      case Env.product:
        throw Exception();
      case Env.develop:
        throw Exception();
      case Env.mock:
        return MockSendPointsInteractor();
    }
  });
}
