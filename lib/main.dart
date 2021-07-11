
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

import 'app/config/ui_config.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  
  
  runApp(MyApp());
  OneSignal.shared.setLogLevel(OSLogLevel.verbose, OSLogLevel.none);

  OneSignal.shared.setAppId("f7799b9c-dbe7-4fc8-b582-5aa5c36089e4");


  OneSignal.shared.promptUserForPushNotificationPermission().then((accepted) async {
    print("Accepted permission: $accepted");
   
  });
      
}

class MyApp extends StatelessWidget {

  
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: UiConfig.appTheme,
      initialRoute: '/',
      getPages: UiConfig.routes,
    );
  }
}
