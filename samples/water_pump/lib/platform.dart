import 'dart:io';

enum OS { desktop, app, web }

OS checkPlatform() {
  try {
    if (["windows", "macos", "linux"].contains(Platform.operatingSystem)) {
      return OS.desktop;
    } else {
      return OS.app;
    }
  } catch (e) {
    return OS.web;
  }
}
