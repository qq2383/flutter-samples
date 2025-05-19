import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../controller.dart';

class Pump extends StatefulWidget {
  const Pump({super.key});

  @override
  State<StatefulWidget> createState() {
    return _Pump();
  }
}

class _Pump extends State<Pump> {
  @override
  Widget build(BuildContext context) {
    return Consumer<WaterPumpController>(builder: (context, waterPump, child) {
      Color color = waterPump.running == "Running" ? Colors.green : Colors.red;
      return Column(
        children: [
          Container(
            alignment: Alignment.center,
            color: const Color.fromRGBO(0, 0, 0, 0.08),
            padding: const EdgeInsets.fromLTRB(20, 2, 10, 2),
            child: Row(
              children: [
                const Text(
                  "水泵",
                  style: TextStyle(fontSize: 18, color: Colors.black),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(10, 3, 10, 4),
                  margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                  color: color,
                  child: Text(
                    waterPump.running,
                    style: const TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
                Expanded(
                  child: Container(),
                ),
                Switch(
                  value: waterPump.running == "Running" ? true : false,
                  onChanged: (bool value) {
                    if (waterPump.running == "Running") {
                      waterPump.httpGet('/Stop');
                    } else {
                      waterPump.httpGet('/Running');
                    }
                  },
                )
              ],
            ),
          ),
          Container(height: 20,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
                child: Text("最大: ${waterPump.maMax} A", style: const TextStyle(fontSize: 18, color: Colors.red),),
              ),
              Text("当前: ${waterPump.maCurrent} A", style: const TextStyle(fontSize: 18, color: Colors.black),),
            ],
          ),
        ],
      );
    });
  }
}
