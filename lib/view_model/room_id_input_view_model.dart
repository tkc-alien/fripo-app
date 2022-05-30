import 'package:flutter/material.dart';
import 'package:fripo/define/app_const.dart';
import 'package:provider/provider.dart';

class RoomIdInputViewModel with ChangeNotifier {
  String? _roomId;

  bool Function()? validateFunc;

  void Function()? saveFunc;

  String? validateRoomId(String? input) {
    if (input == null || input.isEmpty) {
      return 'No content.';
    } else if (input.length != 5) {
      return 'Length not available.';
    } else if (!RegExp(AppConst.roomIdReg).hasMatch(input)) {
      return 'Invalid character used.';
    } else {
      return null;
    }
  }

  void setRoomId(String? value) {
    _roomId = value;
    notifyListeners();
  }

  static RoomIdInputViewModel read(BuildContext context) {
    return context.read();
  }

  static T select<T>(
    BuildContext context,
    T Function(RoomIdInputViewModel vm) select,
  ) {
    return context.select(select);
  }
}

extension Getters on RoomIdInputViewModel {
  String? get roomId => _roomId;
}
