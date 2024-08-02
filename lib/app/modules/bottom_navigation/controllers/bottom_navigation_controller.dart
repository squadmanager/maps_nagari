import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:maps_nagari/app/components/expired_session_c.dart';
import 'package:maps_nagari/app/modules/maps_street_cleaning/views/maps_street_cleaning_view.dart';
import 'package:maps_nagari/app/modules/maps_waste_collections/views/maps_waste_collections_view.dart';

class BottomNavigationController extends GetxController {
  var tabIndex = 0.obs;
  var dateTimeLogin = ''.obs;

  @override
  void onInit() {
    final box = GetStorage();

    if (box.read('dataUser') != null) {
      final data = box.read('dataUser') as Map<String, dynamic>;
      dateTimeLogin.value = data['dateTimeLogin'];
    }

    super.onInit();
  }

  @override
  void onReady() async {
    var dateLogin = DateFormat('yyyy-MM-dd').format(
      DateTime.parse(dateTimeLogin.value),
    );
    if (dateLogin.compareTo(DateFormat('yyyy-MM-dd').format(DateTime.now())) <
        0) {
      ExpiredSessionC().dialog();
    }

    super.onReady();
  }

  final pages = <Widget>[
    MapsWasteCollectionsView(),
    MapsStreetCleaningView(),
  ];

  Widget get currentPage => pages[tabIndex()];

  changePage(int index) {
    tabIndex.value = index;
  }
}
