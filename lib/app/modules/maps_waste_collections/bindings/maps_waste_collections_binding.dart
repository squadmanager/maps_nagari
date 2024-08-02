import 'package:get/get.dart';

import '../controllers/maps_waste_collections_controller.dart';

class MapsWasteCollectionsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MapsWasteCollectionsController>(
      () => MapsWasteCollectionsController(),
    );
  }
}
