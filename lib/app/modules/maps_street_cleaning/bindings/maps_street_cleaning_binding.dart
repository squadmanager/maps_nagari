import 'package:get/get.dart';

import '../controllers/maps_street_cleaning_controller.dart';

class MapsStreetCleaningBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MapsStreetCleaningController>(
      () => MapsStreetCleaningController(),
    );
  }
}
