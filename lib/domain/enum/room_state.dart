enum RoomState {
  preparing,
  onGame,
  result,
  errorByServerMaintenance,
  errorByData,
  errorByMemberNotEnough,
}

extension RoomStateExt on RoomState {
  static RoomState fromInt(int value) {
    final state = _map[value];
    if (state != null) {
      return state;
    } else {
      throw Exception();
    }
  }

  int toInt() {
    final key = _map.entries.singleWhere((e) => e.value == this).key;
    return key;
  }

  String? get errorMessage {
    switch (this) {
      case RoomState.errorByServerMaintenance:
        return 'サーバーメンテナンス中です。';
      case RoomState.errorByData:
        return 'サーバー上のデータに異常が発生しました。';
      case RoomState.errorByMemberNotEnough:
        return 'ルームの人数が不足しています。';
      default:
        return null;
    }
  }
}

const _map = {
  100: RoomState.preparing,
  200: RoomState.onGame,
  300: RoomState.result,
  -100: RoomState.errorByServerMaintenance,
  -200: RoomState.errorByData,
  -300: RoomState.errorByMemberNotEnough,
};
