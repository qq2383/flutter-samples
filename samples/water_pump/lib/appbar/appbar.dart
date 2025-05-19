import 'package:flutter/material.dart';
import 'package:water_pump/appbar/desktop.dart';
import 'package:water_pump/platform.dart';

AppBar appbar(title) {
  return checkPlatform() == OS.desktop
      ? DesktopAppbar(title)
      : AppBar(
          backgroundColor: const Color.fromRGBO(0, 0, 0, 0.7),
          title: Text(title, style: const TextStyle(color: Colors.white),),
        );
}
