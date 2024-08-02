import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:maps_nagari/app/modules/maps_street_cleaning/controllers/maps_street_cleaning_controller.dart';
import 'package:maps_nagari/app/widgets/card_no_elevation_widget.dart';
import 'package:maps_nagari/app/widgets/color_widget.dart';

import '../../../../widgets/input_widget.dart';

class SearchMapSc extends GetView<MapsStreetCleaningController> {
  const SearchMapSc({super.key});

  Widget _dataList(data) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: CardNoElevationWidget(
        onLongPress: () {},
        backgroundColor: HexColor(ColorWidget().white),
        borderRadiusCircular: 10.0,
        onTap: () async {
          Get.back();

          controller.listElement.clear();
          controller.detailVehicle.clear();

          controller.gotoLocation(
            double.parse(
              data['lat_start'],
            ),
            double.parse(data['lng_start']),
            18,
          );
        },
        title: '${data['location_start']} - ${data['location_end']}',
        widgetLeftTop: Container(),
        widgetLeft: Text(
          '${data['task_name']}',
          style: GoogleFonts.poppins(
            fontSize: 12.0,
            fontWeight: FontWeight.w500,
            color: HexColor(ColorWidget().black),
          ),
        ),
        widgetRight: Container(),
        widgetBottom: Container(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InputWidget(
              controllerText: controller.searchC,
              hintText: 'Enter Search...',
              messageError: 'Search Required',
              prefixIcon: SvgPicture.asset(
                'assets/icons/search.svg',
                color: HexColor(ColorWidget().grey),
                fit: BoxFit.scaleDown,
              ),
              obscureText: false,
              textRequired: true,
              onTap: () {},
              maxLines: null,
              paddingVertical: 0,
              onChange: controller.searchLocation,
            ),
            const SizedBox(
              height: 10.0,
            ),
            Divider(
              thickness: 1.0,
              color: HexColor(ColorWidget().grey),
            ),
            Text(
              'Select Location',
              style: GoogleFonts.poppins(
                fontSize: 15.0,
                fontWeight: FontWeight.w600,
                color: HexColor(ColorWidget().black),
              ),
            ),
            if (controller.listCpSearch.isNotEmpty &&
                controller.searchC.text.isNotEmpty) ...[
              for (int i = 0; i < controller.listCpSearch.length; i++)
                _dataList(controller.listCpSearch[i]),
            ] else if (controller.searchC.text.isEmpty) ...[
              for (int i = 0; i < controller.listCp.length; i++)
                _dataList(controller.listCp[i]),
            ],
          ],
        ),
      ),
    );
  }
}
