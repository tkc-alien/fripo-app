enum RoomState {
  preparing,
  onGame,
  result,
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
}

const _map = {
  100: RoomState.preparing,
  200: RoomState.onGame,
  300: RoomState.result,
};
