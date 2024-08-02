import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:maps_nagari/app/modules/maps_street_cleaning/controllers/maps_street_cleaning_controller.dart';
import 'package:maps_nagari/app/modules/maps_waste_collections/controllers/maps_waste_collections_controller.dart';

import '../../../widgets/color_widget.dart';
import '../controllers/bottom_navigation_controller.dart';

class BottomNavigationView extends GetView<BottomNavigationController> {
  BottomNavigationView({Key? key}) : super(key: key);

  final MapsWasteCollectionsController mapsC =
      Get.put(MapsWasteCollectionsController());
  final MapsStreetCleaningController mapsScC =
      Get.put(MapsStreetCleaningController());

  // final MapsMcWcController mapsMcWcController =
  //     Get.put(MapsMcWcController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        backgroundColor: HexColor(ColorWidget().white),
        body: Stack(
          children: [
            controller.currentPage,
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                margin: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width / 2.5,
                    right: MediaQuery.of(context).size.width / 2.5,
                    bottom: 10.0),
                width: double.infinity,
                child: Container(
                  decoration: BoxDecoration(
                    color: HexColor(ColorWidget().white),
                    boxShadow: [
                      BoxShadow(
                        color: HexColor(ColorWidget().grey),
                        offset: const Offset(0.0, 1.0), //(x,y)
                        blurRadius: 6.0,
                      ),
                    ],
                    borderRadius: BorderRadius.circular(90.0),
                  ),
                  child: Material(
                    color: HexColor(ColorWidget().white),
                    borderRadius: BorderRadius.circular(90.0),
                    child: Padding(
                      padding: const EdgeInsets.all(7.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          InkWell(
                            borderRadius: BorderRadius.circular(50.0),
                            onTap: () {
                              controller.tabIndex(0);
                            },
                            child: Tooltip(
                              message: 'Waste Collections',
                              child: controller.tabIndex.value == 0
                                  ? SvgPicture.asset(
                                      'assets/icons/dragonfly.svg',
                                      width: 35,
                                      fit: BoxFit.contain,
                                    )
                                  : SvgPicture.asset(
                                      'assets/icons/dragonfly.svg',
                                      color: HexColor(ColorWidget().grey),
                                      width: 35,
                                      fit: BoxFit.contain,
                                    ),
                            ),
                          ),
                          InkWell(
                            borderRadius: BorderRadius.circular(50.0),
                            onTap: () {
                              controller.tabIndex(1);
                            },
                            child: Tooltip(
                              message: 'Street Cleaning',
                              child: controller.tabIndex.value == 1
                                  ? SvgPicture.asset(
                                      'assets/icons/road-sweeper-bottom-nav.svg',
                                      width: 35,
                                      fit: BoxFit.contain,
                                    )
                                  : SvgPicture.asset(
                                      'assets/icons/road-sweeper-bottom-nav.svg',
                                      color: HexColor(ColorWidget().grey),
                                      width: 35,
                                      fit: BoxFit.contain,
                                    ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
