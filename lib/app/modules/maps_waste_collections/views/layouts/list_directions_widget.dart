import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../../../widgets/card_no_elevation_widget.dart';
import '../../../../widgets/color_widget.dart';
import '../../../../widgets/elevated_button_widget.dart';
import '../../../../widgets/input_widget.dart';
import '../../../../widgets/modal_bottom_sheet_widget.dart';
import '../../../../widgets/snackbar_widget.dart';
import '../../controllers/maps_waste_collections_controller.dart';

class ListDirectionsWidget extends GetView<MapsWasteCollectionsController> {
  const ListDirectionsWidget({super.key});

  Widget _listTime(context) {
    return Form(
      key: controller.formKey.value,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Builder(
              builder: (context) => InputWidget(
                controllerText: controller.firstTimeC,
                hintText: 'First Time',
                messageError: 'First Time Required',
                prefixIcon: SvgPicture.asset(
                  'assets/icons/clock-eight.svg',
                  color: HexColor(ColorWidget().grey),
                  fit: BoxFit.scaleDown,
                ),
                obscureText: false,
                textRequired: true,
                onTap: () {
                  controller.pickedTimeFirstTime(context);
                },
                readOnly: true,
                maxLines: 1,
                paddingVertical: 0,
              ),
            ),
          ),
          const SizedBox(
            width: 5.0,
          ),
          Expanded(
            child: Builder(
              builder: (context) => InputWidget(
                controllerText: controller.lastTimeC,
                hintText: 'Last Time',
                messageError: 'Last Time Required',
                prefixIcon: SvgPicture.asset(
                  'assets/icons/clock-eight.svg',
                  color: HexColor(ColorWidget().grey),
                  fit: BoxFit.scaleDown,
                ),
                obscureText: false,
                textRequired: true,
                onTap: () {
                  controller.pickedTimeLastTime(context);
                },
                readOnly: true,
                maxLines: 1,
                paddingVertical: 0,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InputWidget(
            title: 'Date',
            controllerText: controller.filterDateC,
            hintText: 'Select Date',
            messageError: 'Date Required',
            prefixIcon: SvgPicture.asset(
              'assets/icons/calendar-alt.svg',
              color: HexColor(ColorWidget().grey),
              fit: BoxFit.scaleDown,
            ),
            readOnly: true,
            obscureText: false,
            textRequired: true,
            onTap: () => controller.dialogPickerFilterDate(context),
            maxLines: 1,
            paddingVertical: 0,
          ),
          const SizedBox(
            height: 10.0,
          ),
          Divider(
            thickness: 1.0,
            color: HexColor(ColorWidget().grey),
          ),
          Text(
            'Select Vehicle',
            style: GoogleFonts.poppins(
              fontSize: 15.0,
              fontWeight: FontWeight.w600,
              color: HexColor(ColorWidget().black),
            ),
          ),
          for (int i = 0; i < controller.vehicleName.length; i++) ...[
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: CardNoElevationWidget(
                onLongPress: () {},
                backgroundColor: HexColor(ColorWidget().background),
                borderRadiusCircular: 10.0,
                onTap: () {
                  Get.back();
                  ModalBottomSheetWidget().showModalWithoutDraggable(
                    context,
                    Get.width,
                    [
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 15.0,
                          right: 15.0,
                          top: 20.0,
                        ),
                        child: _listTime(context),
                      ),
                      Container(
                        margin: const EdgeInsets.only(
                          top: 40.0,
                          left: 15.0,
                          right: 15.0,
                          bottom: 10.0,
                        ),
                        width: double.infinity,
                        height: 48.0,
                        child: ElevatedButtonWidget(
                          onPress: () async {
                            if (controller.firstHourFilter.value >
                                controller.lastHourFilter.value) {
                              SnackbarWidget().getSnackbar(
                                  'Alert!',
                                  'First hour cannot be less than last hour',
                                  'error');
                            } else if (controller.firstHourFilter.value ==
                                    controller.lastHourFilter.value &&
                                controller.firstMinuteFilter.value >
                                    controller.lastMinuteFilter.value) {
                              SnackbarWidget().getSnackbar(
                                  'Alert!',
                                  'First minute cannot be less than last minute',
                                  'error');
                            } else if (controller.firstHourFilter.value ==
                                    controller.lastHourFilter.value &&
                                controller.firstMinuteFilter.value ==
                                    controller.lastMinuteFilter.value) {
                              SnackbarWidget().getSnackbar(
                                  'Alert!',
                                  'First minute cannot be same than last minute',
                                  'error');
                            } else {
                              controller.latLngFilter.clear();
                              controller.listElement.clear();
                              controller.tracking.clear();
                              controller.listLatLng.clear();
                              Get.back();
                              controller.submitDirections(
                                controller.formKey.value,
                                controller.vehicleName[i],
                              );
                            }
                          },
                          color:
                              HexColor(ColorWidget().primaryWasteCollections),
                          child: Text(
                            'Submit',
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w600,
                              fontSize: 18.0,
                              color: HexColor(ColorWidget().white),
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                },
                title: controller.vehicleName[i],
                widgetLeftTop: Container(),
                widgetLeft: Text(
                  'All Route Vehicle ${controller.vehicleName[i]}',
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
    );
  }
}
