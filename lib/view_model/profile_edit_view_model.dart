import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:fripo/domain/use_case/update_profile_use_case.dart';
import 'package:fripo/domain/use_case/upload_image_use_case.dart';
import 'package:provider/provider.dart';

import '../injector.dart';

class ProfileEditViewModel with ChangeNotifier {
  ProfileEditViewModel()
      : _uploadImageUseCase = sl(),
        _updateProfileUseCase = sl();

  final UploadImageUseCase _uploadImageUseCase;
  final UpdateProfileUseCase _updateProfileUseCase;

  Uint8List? _iconImage;
  String Function()? getName;

  Future<void> setIconImage(Uint8List data) async {
    _iconImage = data;
    notifyListeners();
  }

  Future<void> updateProfile() async {
    final name = getName?.call();
    String? iconUrl;
    if (_iconImage != null) {
      final result = await _uploadImageUseCase.call(image: _iconImage!);
      result.fold(
        (failure) {},
        (data) => iconUrl = data,
      );
    }
    await _updateProfileUseCase.call(name: name, iconUrl: iconUrl);
  }

  static ProfileEditViewModel read(BuildContext context) {
    return context.read();
  }

  static T select<T>(
    BuildContext context,
    T Function(ProfileEditViewModel vm) select,
  ) {
    return context.select(select);
  }
}

extension Getters on ProfileEditViewModel {
  Uint8List? get iconImage => _iconImage;
}
