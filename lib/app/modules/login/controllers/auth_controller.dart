import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:maps_nagari/app/data/providers/auth_provider.dart';
import 'package:maps_nagari/app/modules/bottom_navigation/controllers/bottom_navigation_controller.dart';
import 'package:maps_nagari/app/modules/maps_street_cleaning/controllers/maps_mc_sc_controller.dart';
import 'package:maps_nagari/app/modules/maps_street_cleaning/controllers/maps_street_cleaning_controller.dart';
import 'package:maps_nagari/app/modules/maps_waste_collections/controllers/maps_waste_collections_controller.dart';
import 'package:maps_nagari/app/routes/app_pages.dart';

class AuthController extends GetxController {
  var isAuth = false.obs;
  var token = ''.obs;

  Future<void> autoLogin() async {
    await GetStorage.init();
    final box = GetStorage();

    if (box.read('dataUser') != null) {
      final data = box.read('dataUser') as Map<String, dynamic>;
      token.value = data['token'];
      isAuth.value = true;
    }
  }

  void logout() async {
    await GetStorage.init();
    final box = GetStorage();
    if (box.read('dataUser') != null) {
      final data = box.read('dataUser') as Map<String, dynamic>;
      token.value = data['token'];
      AuthProvider().logout(token.value).then((value) {
        if (value['status']) {}
      });
      box.erase();
    }
    Get.delete<BottomNavigationController>();
    Get.delete<MapsMcScController>();
    Get.delete<MapsMcScController>();
    Get.delete<MapsWasteCollectionsController>();
    Get.delete<MapsStreetCleaningController>();
    Get.offAllNamed(Routes.LOGIN);
    isAuth.value = false;
  }
}
