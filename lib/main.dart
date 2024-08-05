import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:get_storage/get_storage.dart';
import 'package:maps_nagari/app/modules/login/controllers/auth_controller.dart';

import 'app/routes/app_pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: "AIzaSyDp7q9sY1HX7t8xYQvyLKcM-ynJBVauGb4",
        appId: "1:830274020180:web:a76c0f748eb07957f2dec1",
        messagingSenderId: "830274020180",
        projectId: "smart-trash-system-67583",
        authDomain: "smart-trash-system-67583.firebaseapp.com",
        databaseURL:
            "https://smart-trash-system-67583-default-rtdb.asia-southeast1.firebasedatabase.app",
        storageBucket: "smart-trash-system-67583.appspot.com",
      ),
    );
  } else {
    await Firebase.initializeApp();
  }
  // FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
  //   statusBarColor: HexColor(ColorWidget().white), // status bar color
  // ));

  await GetStorage.init();
  final authC = Get.put(AuthController());
  await initializeDateFormatting('id_ID', null).then(
    (_) => runApp(
      FutureBuilder(
        future: authC.autoLogin(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Obx(
              () => GetMaterialApp(
                  debugShowCheckedModeBanner: false,
                  title: "Nagari",
                  initialRoute: authC.isAuth.isTrue
                      ? Routes.BOTTOM_NAVIGATION
                      : Routes.LOGIN,
                  getPages: AppPages.routes,
                  theme: ThemeData.light(),
                  navigatorKey: Get.key),
            );
          }
          return const MaterialApp(
            home: Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            ),
          );
        },
      ),
    ),
  );
}
