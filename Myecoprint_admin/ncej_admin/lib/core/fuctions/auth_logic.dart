import 'package:flutter/material.dart';

import 'package:ncej_admin/core/app_export.dart';

void toggleCamera(
  Function(bool) setIsCameraEnabled,
  bool isCameraEnabled,
  Function(Color) setCameraButtonColor,
  Color cameraButtonColor,
) {
  setIsCameraEnabled(!isCameraEnabled);
  setCameraButtonColor(isCameraEnabled ? appTheme.lightGreen500 : appTheme.gray400);
}

void toggleIconEye(
  Function(bool) setIsVisiblePassword,
  bool isVisiblePassword,
) {
  setIsVisiblePassword(!isVisiblePassword);
}
