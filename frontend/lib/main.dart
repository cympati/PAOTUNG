import 'package:flutter/material.dart';
import 'package:paotung_frontend/constants/manifest.dart';
import 'package:paotung_frontend/constants/route.dart';
import '../../../core/data/services/providers/providers.dart';
import 'core/data/services/notification_service.dart';
import 'package:timezone/data/latest.dart' as tz;


void main() {
  runApp(const App());
}

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {

  void initState() {
    super.initState();
    NotificationApi.init(initScheduled: true);
    GetNotification.getData();
    tz.initializeTimeZones();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: ManifestConstant.appName,
      theme: ThemeData(
          fontFamily: 'Poppins',
          scaffoldBackgroundColor: const Color(0xFFFFFFFF)),
      debugShowCheckedModeBanner: false,
      routes: RouteConstant.route(),
      initialRoute: "/",
    );
  }
}


