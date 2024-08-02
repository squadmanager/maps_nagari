import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:maps_nagari/app/modules/maps_street_cleaning/controllers/maps_street_cleaning_controller.dart';

import '../../../../widgets/color_widget.dart';
import '../../../../widgets/detail_widget.dart';

class LayDetailMcVehicleSc extends GetView<MapsStreetCleaningController> {
  final element;
  LayDetailMcVehicleSc({required this.element, super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Container(
        decoration: BoxDecoration(
          color: HexColor(ColorWidget().white),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Align(
                alignment: Alignment.topRight,
                child: InkWell(
                  onTap: () {
                    controller.mcOpenVehicleDetail(false);
                    controller.mcVehicleDetail.clear();
                  },
                  child: SvgPicture.asset(
                    'assets/icons/times-circle.svg',
                    color: HexColor(ColorWidget().red),
                    fit: BoxFit.scaleDown,
                  ),
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 10.0,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: DetailWidget(
                              title: 'License Plate',
                              isStatus: false,
                              textContent: element[0]['licensePlate'],
                            ),
                          ),
                          Expanded(
                            child: DetailWidget(
                              title: 'Name',
                              isStatus: false,
                              textContent: element[0]['hullNo'],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      Divider(
                        thickness: 1,
                        color: HexColor(ColorWidget().black),
                        height: 10,
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: DetailWidget(
                              title: 'Machine Status',
                              isStatus: false,
                              textContent:
                                  element[0]['engineOn'] ? 'Hidup' : 'Mati',
                            ),
                          ),
                          Expanded(
                            child: DetailWidget(
                              title: 'Status',
                              isStatus: true,
                              textContent: element[0]['motionStatus'] == 'M'
                                  ? 'Move'
                                  : element[0]['motionStatus'] == 'I'
                                      ? 'Idle'
                                      : 'Parking',
                              colorTextStatus: HexColor(ColorWidget().white),
                              colorBackgroundStatus:
                                  HexColor(element[0]['motionStatus'] == 'M'
                                      ? ColorWidget().green
                                      : element[0]['motionStatus'] == 'I'
                                          ? ColorWidget().yellow
                                          : ColorWidget().red),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: DetailWidget(
                              title: 'Mileage',
                              isStatus: false,
                              textContent: '${element[0]['sumDistance']} KM',
                            ),
                          ),
                          Expanded(
                            child: DetailWidget(
                              title: 'Traveling Time',
                              isStatus: false,
                              textContent: element[0]['sumDrivetimeFormatted'],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: DetailWidget(
                              title: 'Speed',
                              isStatus: false,
                              textContent: '${element[0]['speed']}',
                            ),
                          ),
                          Expanded(
                            child: DetailWidget(
                              title: 'IMEI',
                              isStatus: false,
                              textContent: element[0]['imei'],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      DetailWidget(
                        title: 'Last Location',
                        isStatus: false,
                        textContent: '${element[0]['address']}',
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        // height: double.infinity,
      ),
    );
  }
}
