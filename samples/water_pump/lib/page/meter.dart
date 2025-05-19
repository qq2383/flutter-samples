import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:water_pump/page/dashboard.dart';

import '../controller.dart';
import 'hands.dart';

class Meter extends StatelessWidget {
  const Meter({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<WaterPumpController>(
      builder: (context, waterPump, child) {
        return SizedBox(
          width: MediaQuery
              .of(context)
              .size
              .width,
          height: 220,
          child: Stack(
            children: [
              Positioned(
                left: 35,
                top: 15,
                child: Anima(running: waterPump.running),
              ),
              Positioned(
                left: (MediaQuery
                    .of(context)
                    .size
                    .width - 300) / 2,
                top: 20,
                child: CustomPaint(
                  // size: MediaQuery.of(context).size,
                  size: const Size(300, 200),
                  painter: Dashboard(waterPump.mpaMax),
                ),
              ),
              Container(
                height: 110,
                alignment: Alignment.bottomCenter,
                child: Container(
                  padding: const EdgeInsets.fromLTRB(10, 4, 10, 4),
                  color: Colors.lightBlue,
                  child: Text(waterPump.mpaCurrent.toStringAsFixed(2),
                    style: const TextStyle(color: Colors.white),),
                ),
              ),
              Container(
                height: 150,
                alignment: Alignment.bottomCenter,
                // left: (MediaQuery.of(context).size.width - 100) / 2,
                // top: 130,
                child: const Text(
                  "单位：bar", style: TextStyle(color: Colors.black),),
              ),
              Positioned(
                left: (MediaQuery
                    .of(context)
                    .size
                    .width - 300) / 2,
                top: 20,
                child: CustomPaint(
                  // size: MediaQuery.of(context).size,
                  size: const Size(300, 200),
                  painter: Hands(waterPump.mpaCurrent),
                ),
              ),
            ],
          ),
        );
      }
    );
  }
}

class Anima extends StatefulWidget {
  const Anima({super.key, required this.running});

  final String running;

  @override
  State<StatefulWidget> createState() {
    return _Anima();
  }
}

class _Anima extends State<Anima> with TickerProviderStateMixin {
  late AnimationController _animatCtrl;

  @override
  void initState() {
    super.initState();
    _animatCtrl =
    AnimationController(duration: const Duration(seconds: 3), vsync: this)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _animatCtrl.reset();
          _animatCtrl.forward();
        }
      });
  }

  @override
  void dispose() {
    _animatCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Color color = Colors.red;
    if (widget.running == "Running") {
      _animatCtrl.forward();
      color = Colors.green;
    } else {
      _animatCtrl.stop();
      color = Colors.black26;
    }
    return RotationTransition(
      turns: _animatCtrl,
      child: Icon(
        Icons.support_outlined,
        color: color,
      ),
    );
  }

}
