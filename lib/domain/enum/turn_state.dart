enum TurnState {
  themeSetting,
  answering,
  marking,
  result,
  done,
  errorByRoomError,
  errorByParentDisconnected,
}

extension TurnStateExt on TurnState {
  static TurnState fromInt(int value) {
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
  100: TurnState.themeSetting,
  200: TurnState.answering,
  300: TurnState.marking,
  400: TurnState.result,
  500: TurnState.done,
  -100: TurnState.errorByRoomError,
  -200: TurnState.errorByParentDisconnected,
};
