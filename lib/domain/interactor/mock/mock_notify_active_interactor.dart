import 'package:dartz/dartz.dart';
import 'package:fripo/data/mock/mock_room.dart';
import 'package:fripo/domain/alias/request.dart';
import 'package:fripo/domain/entity/member_info.dart';
import 'package:fripo/domain/error/failure.dart';
import 'package:fripo/domain/use_case/notify_active_use_case.dart';

class MockNotifyActiveInteractor implements NotifyActiveUseCase {
  @override
  Response<void> call({required bool isActive}) async {
    final current = MockRoom.members[MockRoom.userMemberId];
    if (current == null) {
      return Left(Failure('Specified Member does not exist'));
    }
    MockRoom.members[MockRoom.userMemberId] = MemberInfo.copyWith(
      current,
      isActive: isActive,
    );
    return const Right(null);
  }
}
