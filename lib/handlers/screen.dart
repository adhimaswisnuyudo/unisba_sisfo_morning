import 'dart:ui';

import 'package:flutter/material.dart';

class DeviceScreen {
  double getDeviceWidth() {
    return MediaQueryData.fromWindow(window).size.width;
  }

  double getDeviceHeight() {
    return MediaQueryData.fromWindow(window).size.height;
  }
}
