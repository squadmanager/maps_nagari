import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:maps_nagari/app/modules/maps_waste_collections/controllers/maps_waste_collections_controller.dart';
import 'package:maps_nagari/app/widgets/color_widget.dart';
import 'package:maps_nagari/app/widgets/warning_widget.dart';

import '../../../../widgets/card_no_elevation_widget.dart';
import '../../../../widgets/input_widget.dart';
import '../../controllers/maps_mc_wc_controller.dart';

class LayListMcVehicle extends StatelessWidget {
  LayListMcVehicle({super.key});

  final MapsMcWcController controller = Get.put(MapsMcWcController());
  final MapsWasteCollectionsController mapsMonitoringC =
      Get.find<MapsWasteCollectionsController>();

  final _timePickerTheme = TimePickerThemeData(
    backgroundColor: Colors.blueGrey,
    hourMinuteShape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(8)),
      side: BorderSide(color: Colors.orange, width: 4),
    ),
    dayPeriodBorderSide: const BorderSide(color: Colors.orange, width: 4),
    dayPeriodColor: Colors.blueGrey.shade600,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(8)),
      side: BorderSide(color: Colors.orange, width: 4),
    ),
    dayPeriodTextColor: Colors.white,
    dayPeriodShape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(8)),
      side: BorderSide(color: Colors.orange, width: 4),
    ),
    hourMinuteColor: MaterialStateColor.resolveWith((states) =>
        states.contains(MaterialState.selected)
            ? Colors.orange
            : Colors.blueGrey.shade800),
    hourMinuteTextColor: MaterialStateColor.resolveWith((states) =>
        states.contains(MaterialState.selected) ? Colors.white : Colors.orange),
    dialHandColor: Colors.blueGrey.shade700,
    dialBackgroundColor: Colors.blueGrey.shade800,
    hourMinuteTextStyle:
        const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
    dayPeriodTextStyle:
        const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
    helpTextStyle: const TextStyle(
        fontSize: 12, fontWeight: FontWeight.bold, color: Colors.white),
    inputDecorationTheme: const InputDecorationTheme(
      border: InputBorder.none,
      contentPadding: EdgeInsets.all(0),
    ),
    dialTextColor: MaterialStateColor.resolveWith((states) =>
        states.contains(MaterialState.selected) ? Colors.orange : Colors.white),
    entryModeIconColor: Colors.orange,
  );

  Widget listTime(context) {
    return Form(
      key: mapsMonitoringC.formKey.value,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Theme(
              data: ThemeData(
                timePickerTheme: _timePickerTheme,
                textButtonTheme: TextButtonThemeData(
                  style: ButtonStyle(
                    foregroundColor: MaterialStateColor.resolveWith(
                        (states) => Colors.white),
                    backgroundColor: MaterialStateColor.resolveWith(
                        (states) => Colors.orange),
                    overlayColor: MaterialStateColor.resolveWith(
                        (states) => Colors.deepOrange),
                  ),
                ),
              ),
              child: Builder(
                builder: (context) => InputWidget(
                  controllerText: mapsMonitoringC.firstTimeC,
                  hintText: 'First Time',
                  messageError: 'Required First Time',
                  prefixIcon: SvgPicture.asset(
                    'assets/icons/clock-eight.svg',
                    color: HexColor(ColorWidget().grey),
                    fit: BoxFit.scaleDown,
                  ),
                  obscureText: false,
                  textRequired: true,
                  onTap: () {
                    mapsMonitoringC.pickedTimeFirstTime(context);
                  },
                  readOnly: true,
                  maxLines: 1,
                  paddingVertical: 0,
                ),
              ),
            ),
          ),
          const SizedBox(
            width: 5.0,
          ),
          Expanded(
            child: Theme(
              data: ThemeData(
                timePickerTheme: _timePickerTheme,
                textButtonTheme: TextButtonThemeData(
                  style: ButtonStyle(
                    foregroundColor: MaterialStateColor.resolveWith(
                        (states) => Colors.white),
                    backgroundColor: MaterialStateColor.resolveWith(
                        (states) => Colors.orange),
                    overlayColor: MaterialStateColor.resolveWith(
                        (states) => Colors.deepOrange),
                  ),
                ),
              ),
              child: Builder(
                builder: (context) => InputWidget(
                  controllerText: mapsMonitoringC.lastTimeC,
                  hintText: 'Last Time',
                  messageError: 'Required Last Time',
                  prefixIcon: SvgPicture.asset(
                    'assets/icons/clock-eight.svg',
                    color: HexColor(ColorWidget().grey),
                    fit: BoxFit.scaleDown,
                  ),
                  obscureText: false,
                  textRequired: true,
                  onTap: () {
                    mapsMonitoringC.pickedTimeLastTime(context);
                  },
                  readOnly: true,
                  maxLines: 1,
                  paddingVertical: 0,
                ),
              ),
            ),
          ),
        ],
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
            if (controller.isEmptyVehicleStatuses.isFalse)
              for (int i = 0;
                  i < controller.mcVehicleStatusesList.length;
                  i++) ...[
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: CardNoElevationWidget(
                    onLongPress: () {},
                    backgroundColor: HexColor(ColorWidget().background),
                    borderRadiusCircular: 10.0,
                    onTap: () {
                      if (controller.filterDateC.text == '') {
                        WarningWidget().dialog('Required Date');
                      } else {
                        if (mapsMonitoringC.firstHourFilter.value == 0 &&
                            mapsMonitoringC.lastHourFilter.value == 0) {
                          WarningWidget()
                              .dialog('Required First Time and Last Time');
                        } else {
                          mapsMonitoringC.latLngFilter.clear();
                          mapsMonitoringC.listElement.clear();
                          mapsMonitoringC.tracking.clear();
                          mapsMonitoringC.listLatLng.clear();
                          Get.back();
                          controller.submitDirections(
                            mapsMonitoringC.formKey.value,
                            controller.mcVehicleStatusesList[i].vehicleId,
                          );
                        }
                        // if (mapsMonitoringC.firstHourFilter.value >
                        //     mapsMonitoringC.lastHourFilter.value) {
                        //   SnackbarWidget().getSnackbar(
                        //       'alert'.tr, 'alertFirstHour'.tr, 'error');
                        // } else if (mapsMonitoringC.firstHourFilter.value ==
                        //         mapsMonitoringC.lastHourFilter.value &&
                        //     mapsMonitoringC.firstMinuteFilter.value >
                        //         mapsMonitoringC.lastMinuteFilter.value) {
                        //   SnackbarWidget().getSnackbar(
                        //       'alert'.tr, 'alertFirstMinute'.tr, 'error');
                        // } else if (mapsMonitoringC.firstHourFilter.value ==
                        //         mapsMonitoringC.lastHourFilter.value &&
                        //     mapsMonitoringC.firstMinuteFilter.value ==
                        //         mapsMonitoringC.lastMinuteFilter.value) {
                        //   SnackbarWidget().getSnackbar(
                        //       'alert'.tr, 'alertSameFirstMinute'.tr, 'error');
                        // } else {
                        // mapsMonitoringC.latLngFilter.clear();
                        // mapsMonitoringC.listElement.clear();
                        // mapsMonitoringC.tracking.clear();
                        // mapsMonitoringC.listLatLng.clear();
                        // Get.back();
                        // controller.submitDirections(
                        //   mapsMonitoringC.formKey.value,
                        //   controller.mcVehicleStatusesList[i].vehicleId,
                        // );
                        // }
                      }
                    },
                    title: controller.mcVehicleStatusesList[i].hullNo ?? '-',
                    widgetLeftTop: Container(),
                    widgetLeft: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          controller.mcVehicleStatusesList[i].licensePlate,
                          style: GoogleFonts.poppins(
                            fontSize: 14.0,
                            fontWeight: FontWeight.w500,
                            color: HexColor(ColorWidget().black),
                          ),
                        ),
                        const SizedBox(height: 5.0),
                        Text(
                          'All Route Vehicle ${controller.mcVehicleStatusesList[i].hullNo ?? '-'}',
                          style: GoogleFonts.poppins(
                            fontSize: 12.0,
                            fontWeight: FontWeight.w500,
                            color: HexColor(ColorWidget().black),
                          ),
                        ),
                      ],
                    ),
                    widgetRight: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.0),
                        color: HexColor(
                          controller.mcVehicleStatusesList[i].motionStatus ==
                                  'M'
                              ? ColorWidget().blue
                              : controller.mcVehicleStatusesList[i]
                                          .motionStatus ==
                                      'I'
                                  ? ColorWidget().yellow
                                  : ColorWidget().red,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          controller.mcVehicleStatusesList[i].motionStatus ==
                                  'M'
                              ? 'Move'
                              : controller.mcVehicleStatusesList[i]
                                          .motionStatus ==
                                      'I'
                                  ? 'Idle'
                                  : 'Parking',
                          style: GoogleFonts.poppins(
                            fontSize: 12.0,
                            fontWeight: FontWeight.w600,
                            color: HexColor(ColorWidget().white),
                          ),
                        ),
                      ),
                    ),
                    widgetBottom: Container(),
                  ),
                ),
              ]
            else
              Padding(
                padding: const EdgeInsets.only(top: 100.0),
                child: Center(
                  child: Text(
                    'Empty Data',
                    style: GoogleFonts.poppins(
                      fontSize: 15.0,
                      fontWeight: FontWeight.normal,
                      color: HexColor(ColorWidget().black),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
