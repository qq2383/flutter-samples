import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:water_pump/page/pump.dart';

import '../appbar/appbar.dart';
import 'dht.dart';
import 'meter.dart';
import 'pressure.dart';

class Panel extends StatelessWidget {
  final String title;

  const Panel({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar(title),
      body: Container(
        color: Colors.white70,
        child: Column(
          children: [
            const DHT(),
            const Pressure(),
            const Meter(),
            Container(
              height: 1,
              color: Colors.black26,
            ),
            const Pump(),
          ],
        ),
      ),
      floatingActionButtonLocation: CustomFloatPoint(FloatingActionButtonLocation.endDocked, -10, -60),
      floatingActionButton: SizedBox(
        width: 35,
        height: 35,
        child: FloatingActionButton(
          onPressed: () {
            context.go('/setting');
          },
          child: const Icon(Icons.settings),
        ),
      ),
    );
  }
}

class CustomFloatPoint extends FloatingActionButtonLocation {
  FloatingActionButtonLocation location;
  double offsetX;    // X方向的偏移量
  double offsetY;    // Y方向的偏移量
  CustomFloatPoint(this.location, this.offsetX, this.offsetY);

  @override
  Offset getOffset(ScaffoldPrelayoutGeometry scaffoldGeometry) {
    Offset offset = location.getOffset(scaffoldGeometry);
    return Offset(offset.dx + offsetX, offset.dy + offsetY);
  }

}
