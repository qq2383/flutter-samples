import 'dart:convert';
import 'dart:io';
import 'dart:isolate';
import 'dart:math';

import '../controller.dart';

class Httpserver {
  String status = "Stop";

  static Future<void> start() async {
    var https = Httpserver();
    ReceivePort receivePort = ReceivePort();
    Isolate.spawn(https.init, receivePort.sendPort);
  }

  void stop() {
    _server.close();
    status = "Stop";
  }

  late HttpServer _server;
  double intValue = 1;

  Future<void> init(SendPort sendPort) async {
    try {
      _server = await HttpServer.bind(InternetAddress.anyIPv4, 9596);

      _server.listen((request) {
        String path0 = request.uri.path;
        String data = "";
        if (path0.endsWith('/g')) {
          if (intValue > 3.2) {
            intValue = 1;
          }
          var pump = createPump(intValue);
          data = jsonEncode(pump.toJson());
        } else if (path0.endsWith('/Running')) {
          status = "Running";
        } else {
          status = "Stop";
        }
        var response = request.response;
        if (data.isNotEmpty) {
          response.headers.contentType =
              ContentType("application", "json", charset: "utf-8");
          response.write(data);
        }
        response.close();
      });
    } catch (e) {
      print(e.toString());
    }
  }

  double random(double max, double min) {
    return Random().nextDouble() * (max - min) + min;
  }

  WaterPump createPump(double intValue) {
    var pump = WaterPump();
    pump.temperature = random(32, 25);
    pump.humidity = random(96, 60);
    if (status == "Running") {
      pump.mpaCurrent = random(intValue + 0.2, intValue);
      pump.maCurrent = random(0.28, 0);
    }
    pump.mpaMax = 1.78;
    pump.running = status;
    return pump;
  }
}
