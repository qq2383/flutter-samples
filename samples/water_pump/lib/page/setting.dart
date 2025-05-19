import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:water_pump/controller.dart';

class Setting extends StatefulWidget {
  const Setting({super.key});

  @override
  State<StatefulWidget> createState() => _Setting();
}

class _Setting extends State<Setting> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
            backgroundColor: const Color.fromRGBO(238, 238, 238, 1.0),
            foregroundColor: Colors.black,
            title: Row(
              children: [
                IconButton(
                  padding: const EdgeInsets.all(2),
                  splashRadius: 20,
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () {
                    context.go('/');
                  },
                ),
                const Text("设置")
              ],
            )),
        body:
            Consumer<WaterPumpController>(builder: (builder, waterPump, child) {
          var mpaController =
              TextEditingController(text: waterPump.mpaMax.toStringAsFixed(2));
          var maController =
              TextEditingController(text: waterPump.maMax.toStringAsFixed(2));
          return Center(
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                Container(
                  width: 200,
                  color: Colors.grey,
                  padding: const EdgeInsets.all(8),
                  child: const Text(
                    "水压最大值：",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                SizedBox(
                  width: 200,
                  child: TextField(
                    keyboardType: TextInputType.number,
                    controller: mpaController,
                    maxLines: 1,
                    decoration: const InputDecoration(
                        filled: true,
                        fillColor: Color.fromRGBO(235, 235, 235, 1.0),
                        suffixText: "bar"),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  width: 200,
                  color: Colors.grey,
                  padding: const EdgeInsets.all(8),
                  child: const Text(
                    "电流最大值：",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                SizedBox(
                  width: 200,
                  child: TextField(
                    keyboardType: TextInputType.number,
                    controller: maController,
                    maxLines: 1,
                    decoration: const InputDecoration(
                        filled: true,
                        fillColor: Color.fromRGBO(235, 235, 235, 1.0),
                        suffixText: "A"),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: () {},
                  child: const Text(
                    "提交",
                    // style: TextStyle(color: Colors.white),
                  ),
                )
              ],
            ),
          );
        }),
      ),
    );
  }
}
