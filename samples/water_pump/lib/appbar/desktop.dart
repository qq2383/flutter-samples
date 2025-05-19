import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';

class DesktopAppbar extends AppBar {
  DesktopAppbar(title, {super.key})
      : super(
            backgroundColor: const Color.fromRGBO(255, 255, 255, 1.0),
            title: Row(
              children: [
                Expanded(
                  child: DragToMoveArea(child: Text(title)),
                ),
                WindowCaptionButton.minimize(onPressed: () {
                  windowManager.minimize();
                }),
                WindowCaptionButton.close(onPressed: () {
                  windowManager.close();
                }),
              ],
            ),
            flexibleSpace: DragToMoveArea(child: Container()),
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(1.0),
              child: Container(
                color: Colors.black26,
                height: 0.5,
              ),
            ));
}
