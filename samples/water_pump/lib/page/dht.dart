import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:water_pump/controller.dart';

class DHT extends StatelessWidget {
  const DHT({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<WaterPumpController>(
      builder: (context, waterPump, child) => Container(
          alignment: Alignment.center,
          height: 40,
          child: Row(
            children: [
              Expanded(child: Container()),
              const Text(
                "温度：",
                style: TextStyle(fontSize: 16, color: Colors.black),
              ),
              Text(
                "${waterPump.temperature ?? 0} ℃",
                style: const TextStyle(fontSize: 16),
              ),
              Expanded(child: Container()),
              const Text(
                "湿度：",
                style: TextStyle(fontSize: 16, color: Colors.black),
              ),
              Text(
                "${waterPump.humidity ?? 0} %",
                style: const TextStyle(fontSize: 16),
              ),
              Expanded(child: Container()),
            ],
          )),
    );
  }
}
