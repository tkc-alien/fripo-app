import 'package:fripo/domain/interactor/cancel_disconnected_event_interactor.dart';
import 'package:fripo/domain/interactor/cancel_join_room_interactor.dart';
import 'package:fripo/domain/interactor/get_connection_stream_interactor.dart';
import 'package:fripo/domain/interactor/mock/mock_get_room_data_interactor.dart';
import 'package:fripo/domain/interactor/notify_active_interactor.dart';
import 'package:fripo/domain/interactor/notify_ready_for_next_turn_interactor.dart';
import 'package:fripo/domain/interactor/register_disconnected_event_interactor.dart';
import 'package:fripo/domain/interactor/update_default_life_interactor.dart';
import 'package:fripo/domain/interactor/update_profile_interactor.dart';
import 'package:fripo/domain/interactor/upload_image_interactor.dart';
import 'package:fripo/domain/use_case/cancel_disconnected_event_use_case.dart';
import 'package:fripo/domain/use_case/cancel_join_room_use_case.dart';
import 'package:fripo/domain/use_case/get_connection_stream_use_case.dart';
import 'package:fripo/domain/use_case/notify_active_use_case.dart';
import 'package:fripo/domain/use_case/notify_ready_for_next_turn_use_case.dart';
import 'package:fripo/domain/use_case/register_disconnected_event_use_case.dart';
import 'package:fripo/domain/use_case/update_default_life_use_case.dart';
import 'package:get_it/get_it.dart';

import 'domain/interactor/create_room_interactor.dart';
import 'domain/interactor/crop_image_interactor.dart';
import 'domain/interactor/end_turn_interactor.dart';
import 'domain/interactor/exit_room_interactor.dart';
import 'domain/interactor/get_random_theme_interactor.dart';
import 'domain/interactor/get_room_data_interactor.dart';
import 'domain/interactor/get_room_stream_interactor.dart';
import 'domain/interactor/get_user_data_interactor.dart';
import 'domain/interactor/join_room_interactor.dart';
import 'domain/interactor/mock/mock_create_room_interactor.dart';
import 'domain/interactor/mock/mock_end_turn_interactor.dart';
import 'domain/interactor/mock/mock_exit_room_interactor.dart';
import 'domain/interactor/mock/mock_get_random_theme_interactor.dart';
import 'domain/interactor/mock/mock_get_room_stream_interactor.dart';
import 'domain/interactor/mock/mock_get_user_data_interactor.dart';
import 'domain/interactor/mock/mock_join_room_interactor.dart';
import 'domain/interactor/mock/mock_register_user_interactor.dart';
import 'domain/interactor/mock/mock_send_answer_use_case.dart';
import 'domain/interactor/mock/mock_send_points_interactor.dart';
import 'domain/interactor/mock/mock_send_theme_interactor.dart';
import 'domain/interactor/mock/mock_start_room_interactor.dart';
import 'domain/interactor/mock/mock_update_profile_interactor.dart';
import 'domain/interactor/mock/mock_upload_image_interactor.dart';
import 'domain/interactor/pick_image_interactor.dart';
import 'domain/interactor/register_user_interactor.dart';
import 'domain/interactor/send_answer_interactor.dart';
import 'domain/interactor/send_points_interactor.dart';
import 'domain/interactor/send_theme_interactor.dart';
import 'domain/interactor/start_room_interactor.dart';
import 'domain/use_case/create_room_use_case.dart';
import 'domain/use_case/crop_image_use_case.dart';
import 'domain/use_case/end_turn_use_case.dart';
import 'domain/use_case/exit_room_use_case.dart';
import 'domain/use_case/get_random_theme_use_case.dart';
import 'domain/use_case/get_room_data_use_case.dart';
import 'domain/use_case/get_room_stream_use_case.dart';
import 'domain/use_case/get_user_data_use_case.dart';
import 'domain/use_case/join_room_use_case.dart';
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
    product: RegisterUserInteractor(),
    develop: RegisterUserInteractor(),
    mock: MockRegisterUserInteractor(),
  );

  register<GetUserDataUseCase>(
    product: GetUserDataInteractor(),
    develop: GetUserDataInteractor(),
    mock: MockGetUserDataInteractor(),
  );

  register<CreateRoomUseCase>(
    product: CreateRoomInteractor(),
    develop: CreateRoomInteractor(),
    mock: MockCreateRoomInteractor(),
  );

  register<JoinRoomUseCase>(
    product: JoinRoomInteractor(),
    develop: JoinRoomInteractor(),
    mock: MockJoinRoomInteractor(),
  );

  register<CancelJoinRoomUseCase>(
    product: CancelJoinRoomInteractor(),
    develop: CancelJoinRoomInteractor(),
    mock: null,
  );

  register<ExitRoomUseCase>(
    product: ExitRoomInteractor(),
    develop: ExitRoomInteractor(),
    mock: MockExitRoomInteractor(),
  );

  register<StartRoomUseCase>(
    product: StartRoomInteractor(),
    develop: StartRoomInteractor(),
    mock: MockStartRoomInteractor(),
  );

  register<UpdateDefaultLifeUseCase>(
    product: UpdateDefaultLifeInteractor(),
    develop: UpdateDefaultLifeInteractor(),
    mock: null,
  );

  register<GetRoomStreamUseCase>(
    product: GetRoomStreamInteractor(),
    develop: GetRoomStreamInteractor(),
    mock: MockGetRoomStreamInteractor(),
  );

  register<GetRoomDataUseCase>(
    product: GetRoomDataInteractor(),
    develop: GetRoomDataInteractor(),
    mock: MockGetRoomDataInteractor(),
  );

  register<GetConnectionStreamUseCase>(
    product: GetConnectionStreamInteractor(),
    develop: GetConnectionStreamInteractor(),
    mock: null,
  );

  register<RegisterDisconnectedEventUseCase>(
    product: RegisterDisconnectedEventInteractor(),
    develop: RegisterDisconnectedEventInteractor(),
    mock: null,
  );

  register<CancelDisconnectedEventUseCase>(
    product: CancelDisconnectedEventInteractor(),
    develop: CancelDisconnectedEventInteractor(),
    mock: null,
  );

  register<NotifyActiveUseCase>(
    product: NotifyActiveInteractor(),
    develop: NotifyActiveInteractor(),
    mock: null,
  );

  register<SendThemeUseCase>(
    product: SendThemeInteractor(),
    develop: SendThemeInteractor(),
    mock: MockSendThemeInteractor(),
  );

  register<GetRandomThemeUseCase>(
    product: GetRandomThemeInteractor(),
    develop: GetRandomThemeInteractor(),
    mock: MockGetRandomThemeInteractor(),
  );

  register<SendAnswerUseCase>(
    product: SendAnswerInteractor(),
    develop: SendAnswerInteractor(),
    mock: MockSendAnswerInteractor(),
  );

  register<SendPointsUseCase>(
    product: SendPointsInteractor(),
    develop: SendPointsInteractor(),
    mock: MockSendPointsInteractor(),
  );

  register<EndTurnUseCase>(
    product: EndTurnInteractor(),
    develop: EndTurnInteractor(),
    mock: MockEndTurnInteractor(),
  );

  register<NotifyReadyForNextTurnUseCase>(
    product: NotifyReadyForNextTurnInteractor(),
    develop: NotifyReadyForNextTurnInteractor(),
    mock: null,
  );

  register<PickImageUseCase>(
    product: PickImageInteractor(),
    develop: PickImageInteractor(),
    mock: PickImageInteractor(),
  );

  register<CropImageUseCase>(
    product: CropImageInteractor(),
    develop: CropImageInteractor(),
    mock: CropImageInteractor(),
  );

  register<UploadImageUseCase>(
    product: UploadImageInteractor(),
    develop: UploadImageInteractor(),
    mock: MockUploadImageInteractor(),
  );

  register<UpdateProfileUseCase>(
    product: UpdateProfileInteractor(),
    develop: UpdateProfileInteractor(),
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
