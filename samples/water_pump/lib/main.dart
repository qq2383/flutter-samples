import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:water_pump/controller.dart';
import 'package:water_pump/page/panel.dart';
import 'package:water_pump/page/setting.dart';
import 'package:water_pump/platform.dart';
import 'package:water_pump/server/server.dart';
import 'package:window_manager/window_manager.dart';

const String appTitle = '水泵控制';

Future<void> main() async {
  if (checkPlatform() == OS.desktop) {
    WidgetsFlutterBinding.ensureInitialized();
    await windowManager.ensureInitialized();

    var winSize = const Size(400, 700);
    WindowOptions windowOptions = WindowOptions(
        size: winSize,
        center: true,
        backgroundColor: Colors.transparent,
        skipTaskbar: false,
        titleBarStyle: TitleBarStyle.hidden,
        windowButtonVisibility: false,
        maximumSize: winSize,
        minimumSize: winSize);

    windowManager.waitUntilReadyToShow(windowOptions, () async {
      await windowManager.show();
      await windowManager.focus();
    });
  }

  Httpserver.start();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final controller = WaterPumpController();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    controller.start();

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => controller),
      ],
      child: MaterialApp.router(
        title: appTitle,
        theme: ThemeData(
          // colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        routerConfig: router(),
      ),
    );
  }

  GoRouter router() {
    return GoRouter(
      initialLocation: '/',
      routes: [
        GoRoute(path: '/', builder: (context, state) => const Panel(title: appTitle)),
        GoRoute(
          path: '/setting',
          builder: (context, state) => const Setting(),
        ),
      ],
    );
  }
}
