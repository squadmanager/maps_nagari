import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:maps_nagari/app/modules/maps_street_cleaning/controllers/maps_street_cleaning_controller.dart';

import '../../../../widgets/card_no_elevation_widget.dart';
import '../../../../widgets/color_widget.dart';

class ListTeamSc extends GetView<MapsStreetCleaningController> {
  final data;
  const ListTeamSc({required this.data, super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Select Team ${controller.titleForm.value}',
              style: GoogleFonts.poppins(
                fontSize: 15.0,
                fontWeight: FontWeight.w600,
                color: HexColor(ColorWidget().black),
              ),
            ),
            for (var element in data) ...[
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: CardNoElevationWidget(
                  onLongPress: () {},
                  backgroundColor: HexColor(ColorWidget().background),
                  borderRadiusCircular: 10.0,
                  onTap: () {
                    controller.latLngFilter.clear();
                    controller.listElement.clear();
                    controller.tracking.clear();
                    controller.listLatLng.clear();
                    Get.back();

                    controller.submitFilterTeam(element.userId);
                  },
                  title: element.fullName,
                  widgetLeftTop: Container(),
                  widgetLeft: Text(
                    'All Route Team ${element.fullName}',
                    style: GoogleFonts.poppins(
                      fontSize: 12.0,
                      fontWeight: FontWeight.w500,
                      color: HexColor(ColorWidget().black),
                    ),
                  ),
                  widgetRight: Container(),
                  widgetBottom: Container(),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
