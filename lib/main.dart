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
        apiKey: "AIzaSyCemfI9ouMyOvwE1DGGVFImzUEH8Nq5q48",
        appId: "1:426682836908:web:df5205cd0afa3a269c7c09",
        messagingSenderId: "426682836908",
        projectId: "apps-rekso-ratan-indonesia",
        authDomain: "apps-rekso-ratan-indonesia.firebaseapp.com",
        databaseURL:
            "https://apps-rekso-ratan-indonesia-default-rtdb.asia-southeast1.firebasedatabase.app",
        storageBucket: "apps-rekso-ratan-indonesia.appspot.com",
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
                  title: "Rekso",
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
