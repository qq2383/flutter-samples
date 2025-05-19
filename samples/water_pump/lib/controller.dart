import 'dart:async';
import 'dart:convert';
import 'dart:isolate';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class WaterPump {
  String? date;
  double? temperature;
  double? humidity;
  double? mpaMax;
  double? mpaCurrent;
  double? maMax;
  double? maCurrent;
  String running;

  WaterPump({
    this.date = "",
    this.temperature = 0,
    this.humidity = 0,
    this.mpaMax = 3.2,
    this.mpaCurrent = 0,
    this.maMax = 0.28,
    this.maCurrent = 0,
    this.running = "Stop",
  });

  factory WaterPump.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'dt': String dt,
        'hum': String humidity,
        'tem': String temperature,
        'MPaMax': String mpaMax,
        'MPaCur': String mpaCurrent,
        'MaMax': String maMax,
        'MaCur': String maCurrent,
        'rs': String running,
      } =>
        WaterPump(
          date: dt,
          temperature: double.parse(temperature),
          humidity: double.parse(humidity),
          mpaMax: mpaConvert(mpaMax),
          mpaCurrent: mpaConvert(mpaCurrent),
          maMax: double.parse(maMax),
          maCurrent: double.parse(maCurrent),
          running: running,
        ),
      _ => throw const FormatException('Failed to load album.'),
    };
  }

  static double mpaConvert(String mpa) {
    double _mpa = double.parse(mpa);
    if (_mpa == 0) {
      _mpa = 0.5;
    }
    return (_mpa - 0.5) / 0.4;
  }

  Map<String, dynamic> toJson() {
    return {
      "dt": date,
      'tem': temperature?.toStringAsFixed(2),
      'hum': humidity?.toStringAsFixed(2),
      "MPaMax": mpaMax?.toStringAsFixed(2),
      "MPaCur": mpaCurrent?.toStringAsFixed(2),
      "MaMax": maMax?.toStringAsFixed(2),
      "MaCur": maCurrent?.toStringAsFixed(2),
      "rs": running,
    };
  }
}

class WaterPumpController with ChangeNotifier {
  final WaterPump _waterPump = WaterPump();

  get temperature => _waterPump.temperature;
  get humidity => _waterPump.humidity;

  get mpaMax => _waterPump.mpaMax;
  get mpaCurrent => _waterPump.mpaCurrent;

  get maMax => _waterPump.maMax;
  get maCurrent => _waterPump.maCurrent;

  get running => _waterPump.running;

  bool _isLoop = false;
  void start() {
    _isLoop = true;
    createIsolate();
  }

  void stop() {
    _isLoop = false;
  }

  Future<void> createIsolate() async {
    ReceivePort receivePort = ReceivePort();
    await Isolate.spawn(
      _request,
      receivePort.sendPort,
    );

    receivePort.listen((dynamic message) {
      if (message is WaterPump) {
        refresh(message);
      }
    });
  }

  void refresh(WaterPump waterPump) {
    bool isChanged = false;
    if (_waterPump.temperature != waterPump.temperature) {
      _waterPump.temperature = waterPump.temperature!;
      isChanged = true;
    }
    if (_waterPump.humidity != waterPump.humidity) {
      _waterPump.humidity = waterPump.humidity!;
      isChanged = true;
    }
    if (_waterPump.mpaMax != waterPump.mpaMax) {
      _waterPump.mpaMax = waterPump.mpaMax!;
      isChanged = true;
    }
    if (_waterPump.mpaCurrent != waterPump.mpaCurrent) {
      _waterPump.mpaCurrent = waterPump.mpaCurrent!;
      isChanged = true;
    }
    if (_waterPump.maMax != waterPump.maMax) {
      _waterPump.maMax = waterPump.maMax!;
      isChanged = true;
    }
    if (_waterPump.maCurrent != waterPump.maCurrent) {
      _waterPump.maCurrent = waterPump.maCurrent!;
      isChanged = true;
    }
    if (_waterPump.running != waterPump.running) {
      _waterPump.running = waterPump.running;
      isChanged = true;
    }
    if (isChanged) {
      notifyListeners();
    }
  }

  void _request(SendPort sendPort) {
    Duration periodic = const Duration(milliseconds: 500);
    Timer.periodic(periodic, (intervalTime) async {
      if (_isLoop) {
        var waterPump = await httpGet('/g');
        print(waterPump.toJson());
        sendPort.send(waterPump);
      } else {
        intervalTime.cancel();
      }
    });
  }

  Future<WaterPump> httpGet(path) async {
    var header = <String, String>{};
    header["auth"] = "a12bc3_Esp8266";
    try {
      var response = await http.post(Uri.parse('http://127.0.0.1:9596' + path),
          headers: header);
      if (response.statusCode == 200) {
        return WaterPump.fromJson(
            jsonDecode(response.body) as Map<String, dynamic>);
      }
    } catch (_) {}
    return WaterPump();
  }
}
