import 'package:get_it/get_it.dart';

import 'domain/error/interactor_not_registered_exception.dart';
import 'domain/interactor/mock/mock_create_room_interactor.dart';
import 'domain/interactor/mock/mock_exit_room_interactor.dart';
import 'domain/interactor/mock/mock_get_random_theme_interactor.dart';
import 'domain/interactor/mock/mock_get_room_stream_interactor.dart';
import 'domain/interactor/mock/mock_join_room_interactor.dart';
import 'domain/interactor/mock/mock_register_user_interactor.dart';
import 'domain/interactor/mock/mock_send_answer_use_case.dart';
import 'domain/interactor/mock/mock_send_points_interactor.dart';
import 'domain/interactor/mock/mock_send_theme_interactor.dart';
import 'domain/interactor/mock/mock_start_room_interactor.dart';
import 'domain/use_case/create_room_use_case.dart';
import 'domain/use_case/exit_room_use_case.dart';
import 'domain/use_case/get_random_theme_use_case.dart';
import 'domain/use_case/get_room_stream_use_case.dart';
import 'domain/use_case/join_room_use_case.dart';
import 'domain/use_case/register_user_use_case.dart';
import 'domain/use_case/send_answer_use_case.dart';
import 'domain/use_case/send_points_use_case.dart';
import 'domain/use_case/send_theme_use_case.dart';
import 'domain/use_case/start_room_use_case.dart';

/// ビルド環境
enum Env {
  product,
  develop,
  mock,
}

/// DI管理インスタンス
final sl = GetIt.instance;

/// DI注入
void init([Env env = Env.develop]) {
  /// DI登録処理
  void register<T extends Object>({
    required T? product,
    required T? develop,
    required T? mock,
  }) {
    sl.registerLazySingleton<T>(() {
      switch (env) {
        case Env.product:
          if (product != null) {
            return product;
          } else {
            throw InteractorNotRegisteredException();
          }
        case Env.develop:
          if (develop != null) {
            return develop;
          } else {
            throw InteractorNotRegisteredException();
          }
        case Env.mock:
          if (mock != null) {
            return mock;
          } else {
            throw InteractorNotRegisteredException();
          }
      }
    });
  }

  // UseCases

  register<RegisterUserUseCase>(
    product: null,
    develop: null,
    mock: MockRegisterUserInteractor(),
  );

  register<CreateRoomUseCase>(
    product: null,
    develop: null,
    mock: MockCreateRoomInteractor(),
  );

  register<JoinRoomUseCase>(
    product: null,
    develop: null,
    mock: MockJoinRoomInteractor(),
  );

  register<ExitRoomUseCase>(
    product: null,
    develop: null,
    mock: MockExitRoomInteractor(),
  );

  register<StartRoomUseCase>(
    product: null,
    develop: null,
    mock: MockStartRoomInteractor(),
  );

  register<GetRoomStreamUseCase>(
    product: null,
    develop: null,
    mock: MockGetRoomStreamInteractor(),
  );

  register<SendThemeUseCase>(
    product: null,
    develop: null,
    mock: MockSendThemeInteractor(),
  );

  register<GetRandomThemeUseCase>(
    product: null,
    develop: null,
    mock: MockGetRandomThemeInteractor(),
  );

  register<SendAnswerUseCase>(
    product: null,
    develop: null,
    mock: MockSendAnswerInteractor(),
  );

  register<SendPointsUseCase>(
    product: null,
    develop: null,
    mock: MockSendPointsInteractor(),
  );
}
