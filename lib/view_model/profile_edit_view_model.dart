import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fripo/domain/use_case/crop_image_use_case.dart';
import 'package:fripo/domain/use_case/pick_image_use_case.dart';
import 'package:fripo/domain/use_case/update_profile_use_case.dart';
import 'package:fripo/domain/use_case/upload_image_use_case.dart';
import 'package:provider/provider.dart';

import '../injector.dart';

class ProfileEditViewModel with ChangeNotifier {
  ProfileEditViewModel()
      : _pickImageUseCase = sl(),
        _cropImageUseCase = sl(),
        _uploadImageUseCase = sl(),
        _updateProfileUseCase = sl();

  final PickImageUseCase _pickImageUseCase;
  final CropImageUseCase _cropImageUseCase;
  final UploadImageUseCase _uploadImageUseCase;
  final UpdateProfileUseCase _updateProfileUseCase;

  File? _iconFile;
  String Function()? getName;

  Future<void> selectIconImage() async {
    final result = await _pickImageUseCase.call();
    result.fold(
      (failure) => print(failure),
      (data) async {
        print('pick image succeed.');
        final result = await _cropImageUseCase.call(sourcePath: data.path);
        result.fold(
          (failure) => print(failure),
          (cropped) {
            _iconFile = cropped;
            notifyListeners();
          },
        );
      },
    );
  }

  Future<void> updateProfile() async {
    final name = getName?.call();
    String? iconUrl;
    if (_iconFile != null) {
      final result = await _uploadImageUseCase.call(image: _iconFile!);
      result.fold(
        (failure) => print(failure),
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
  File? get iconFile => _iconFile;
}
