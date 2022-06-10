import 'package:fripo/domain/interactor/exit_room_interactor.dart';
import 'package:fripo/domain/interactor/get_room_stream_interactor.dart';
import 'package:fripo/domain/interactor/join_room_interactor.dart';
import 'package:fripo/domain/interactor/start_room_interactor.dart';
import 'package:get_it/get_it.dart';

import 'domain/interactor/create_room_interactor.dart';
import 'domain/interactor/crop_image_interactor.dart';
import 'domain/interactor/mock/mock_create_room_interactor.dart';
import 'domain/interactor/mock/mock_exit_room_interactor.dart';
import 'domain/interactor/mock/mock_get_random_theme_interactor.dart';
import 'domain/interactor/mock/mock_get_room_stream_interactor.dart';
import 'domain/interactor/mock/mock_join_room_interactor.dart';
import 'domain/interactor/mock/mock_notify_next_interactor.dart';
import 'domain/interactor/mock/mock_register_user_interactor.dart';
import 'domain/interactor/mock/mock_send_answer_use_case.dart';
import 'domain/interactor/mock/mock_send_points_interactor.dart';
import 'domain/interactor/mock/mock_send_theme_interactor.dart';
import 'domain/interactor/mock/mock_start_room_interactor.dart';
import 'domain/interactor/mock/mock_update_profile_interactor.dart';
import 'domain/interactor/mock/mock_upload_image_interactor.dart';
import 'domain/interactor/pick_image_interactor.dart';
import 'domain/interactor/register_user_interactor.dart';
import 'domain/use_case/create_room_use_case.dart';
import 'domain/use_case/crop_image_use_case.dart';
import 'domain/use_case/exit_room_use_case.dart';
import 'domain/use_case/get_random_theme_use_case.dart';
import 'domain/use_case/get_room_stream_use_case.dart';
import 'domain/use_case/join_room_use_case.dart';
import 'domain/use_case/notify_next_use_case.dart';
import 'domain/use_case/pick_image_use_case.dart';
import 'domain/use_case/register_user_use_case.dart';
import 'domain/use_case/send_answer_use_case.dart';
import 'domain/use_case/send_points_use_case.dart';
import 'domain/use_case/send_theme_use_case.dart';
import 'domain/use_case/start_room_use_case.dart';
import 'domain/use_case/update_profile_use_case.dart';
import 'domain/use_case/upload_image_use_case.dart';

/// ビルド環境
enum Env {
  product,
  develop,
  mock,
}

/// DI管理インスタンス
final sl = GetIt.instance;

/// DI注入
Result init([Env env = Env.develop]) {
  final notRegisteredUseCaseList = <String>[];

  /// DI登録処理
  void register<T extends Object>({
    required T? product,
    required T? develop,
    required T? mock,
  }) {
    switch (env) {
      case Env.product:
        if (product != null) {
          sl.registerSingleton<T>(product);
        } else {
          notRegisteredUseCaseList.add(T.toString());
        }
        break;
      case Env.develop:
        if (develop != null) {
          sl.registerSingleton<T>(develop);
        } else {
          notRegisteredUseCaseList.add(T.toString());
        }
        break;
      case Env.mock:
        if (mock != null) {
          sl.registerSingleton<T>(mock);
        } else {
          notRegisteredUseCaseList.add(T.toString());
        }
        break;
    }
  }

  // UseCases

  register<RegisterUserUseCase>(
    product: null,
    develop: RegisterUserInteractor(),
    mock: MockRegisterUserInteractor(),
  );

  register<CreateRoomUseCase>(
    product: null,
    develop: CreateRoomInteractor(),
    mock: MockCreateRoomInteractor(),
  );

  register<JoinRoomUseCase>(
    product: null,
    develop: JoinRoomInteractor(),
    mock: MockJoinRoomInteractor(),
  );

  register<ExitRoomUseCase>(
    product: null,
    develop: ExitRoomInteractor(),
    mock: MockExitRoomInteractor(),
  );

  register<StartRoomUseCase>(
    product: null,
    develop: StartRoomInteractor(),
    mock: MockStartRoomInteractor(),
  );

  register<GetRoomStreamUseCase>(
    product: null,
    develop: GetRoomStreamInteractor(),
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

  register<NotifyNextUseCase>(
    product: null,
    develop: null,
    mock: MockNotifyNextInteractor(),
  );

  register<PickImageUseCase>(
    product: null,
    develop: null,
    mock: PickImageInteractor(),
  );

  register<CropImageUseCase>(
    product: null,
    develop: null,
    mock: CropImageInteractor(),
  );

  register<UploadImageUseCase>(
    product: null,
    develop: null,
    mock: MockUploadImageInteractor(),
  );

  register<UpdateProfileUseCase>(
    product: null,
    develop: null,
    mock: MockUpdateProfileInteractor(),
  );

  return Result(
    env: env,
    notRegisteredUseCaseList: notRegisteredUseCaseList,
  );
}

/// DI注入結果オブジェクト
class Result {
  Result({
    required this.env,
    required this.notRegisteredUseCaseList,
  });

  final Env env;
  final List<String> notRegisteredUseCaseList;
}
