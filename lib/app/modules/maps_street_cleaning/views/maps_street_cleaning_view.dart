import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:maps_nagari/app/modules/maps_street_cleaning/controllers/maps_mc_sc_controller.dart';
import 'package:maps_nagari/app/modules/maps_street_cleaning/views/layouts/detail_vehicle_sc.dart';
import 'package:maps_nagari/app/modules/maps_street_cleaning/views/layouts/lay_detail_mc_vehicle_sc.dart';

import '../../../widgets/color_widget.dart';
import '../../../widgets/input_widget.dart';
import '../../../widgets/modal_bottom_sheet_widget.dart';
import '../../login/controllers/auth_controller.dart';
import '../controllers/maps_street_cleaning_controller.dart';
import 'layouts/detail_pin_sc.dart';
import 'layouts/lay_card_mc_vehicle_directions_sc.dart';
import 'layouts/lay_info_detail_sc.dart';
import 'layouts/lay_list_mc_vehicle_sc.dart';
import 'layouts/list_location_sc.dart';
import 'layouts/list_team_sc.dart';
import 'layouts/search_map_sc.dart';

class MapsStreetCleaningView extends GetView<MapsStreetCleaningController> {
  MapsStreetCleaningView({Key? key}) : super(key: key);
  final MapsMcScController mapsMcScController = Get.put(MapsMcScController());
  final AuthController authC = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
      ),
      child: WillPopScope(
        onWillPop: () async {
          Get.back(result: controller.isBackValue.value);
          return true;
        },
        child: Obx(
          () => Scaffold(
            body: controller.isLoading.isTrue
                ? const Center(
                    child: CupertinoActivityIndicator(),
                  )
                : Stack(
                    children: [
                      const ListLocationSc(),
                      Container(
                        alignment: Alignment.topLeft,
                        child: Container(
                          margin: const EdgeInsets.only(left: 20.0, top: 40.0),
                          width: 40,
                          height: 40,
                          child: ElevatedButton(
                            onPressed: () => authC.logout(),
                            style: ElevatedButton.styleFrom(
                              shape: const CircleBorder(),
                              padding: const EdgeInsets.all(5),
                              backgroundColor: HexColor(ColorWidget().red),
                            ),
                            child: Tooltip(
                              message: 'Sign Out',
                              child: SvgPicture.asset(
                                'assets/icons/signout.svg',
                                color: HexColor(ColorWidget().white),
                                fit: BoxFit.scaleDown,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        alignment: Alignment.topLeft,
                        child: Column(
                          children: [
                            Container(
                              margin:
                                  const EdgeInsets.only(left: 20.0, top: 150.0),
                              width: 40,
                              height: 40,
                              child: ElevatedButton(
                                onPressed: () => controller.mcShowInfo(true),
                                style: ElevatedButton.styleFrom(
                                  shape: const CircleBorder(),
                                  padding: const EdgeInsets.all(5),
                                  backgroundColor:
                                      HexColor(ColorWidget().primarySC),
                                ),
                                child: Tooltip(
                                  message: 'Info',
                                  child: SvgPicture.asset(
                                    'assets/icons/info-circle.svg',
                                    color: HexColor(ColorWidget().white),
                                    fit: BoxFit.scaleDown,
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              margin:
                                  const EdgeInsets.only(top: 50.0, left: 20.0),
                              width: 40,
                              height: 40,
                              child: ElevatedButton(
                                onPressed: () {
                                  controller
                                      .changeFilterTypeForm('road_sweeper');
                                },
                                style: ElevatedButton.styleFrom(
                                  shape: const CircleBorder(),
                                  padding: const EdgeInsets.all(5),
                                  backgroundColor:
                                      HexColor(ColorWidget().primarySC),
                                ),
                                child: Tooltip(
                                  message: 'Task Road Sweeper',
                                  child: Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: SvgPicture.asset(
                                      'assets/icons/road-sweeper.svg',
                                      color: HexColor(ColorWidget().white),
                                      fit: BoxFit.scaleDown,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              margin:
                                  const EdgeInsets.only(top: 10.0, left: 20.0),
                              width: 40,
                              height: 40,
                              child: ElevatedButton(
                                onPressed: () {
                                  controller
                                      .changeFilterTypeForm('manual_sweeper');
                                },
                                style: ElevatedButton.styleFrom(
                                  shape: const CircleBorder(),
                                  padding: const EdgeInsets.all(5),
                                  backgroundColor:
                                      HexColor(ColorWidget().primarySC),
                                ),
                                child: Tooltip(
                                  message: 'Task Manual Sweeper',
                                  child: Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: SvgPicture.asset(
                                      'assets/icons/manual-sweeper.svg',
                                      color: HexColor(ColorWidget().white),
                                      fit: BoxFit.scaleDown,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        alignment: Alignment.topRight,
                        child: Column(
                          children: [
                            Container(
                              margin: const EdgeInsets.only(
                                  top: 150.0, right: 20.0),
                              width: 40,
                              height: 40,
                              child: ElevatedButton(
                                onPressed: () {
                                  ModalBottomSheetWidget().showModal(
                                    context,
                                    0.9,
                                    0.0,
                                    0.9,
                                    const SearchMapSc(),
                                    Container(),
                                    Container(),
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  shape: const CircleBorder(),
                                  padding: const EdgeInsets.all(5),
                                  backgroundColor:
                                      HexColor(ColorWidget().primarySC),
                                ),
                                child: Tooltip(
                                  message: 'Search Collection Point',
                                  child: SvgPicture.asset(
                                    'assets/icons/search.svg',
                                    color: HexColor(ColorWidget().white),
                                    fit: BoxFit.scaleDown,
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              margin:
                                  const EdgeInsets.only(top: 10.0, right: 20.0),
                              width: 40,
                              height: 40,
                              child: ElevatedButton(
                                onPressed: () => controller.zoomInOut('in'),
                                style: ElevatedButton.styleFrom(
                                  shape: const CircleBorder(),
                                  padding: const EdgeInsets.all(5),
                                  backgroundColor:
                                      HexColor(ColorWidget().primarySC),
                                ),
                                child: Tooltip(
                                  message: 'Zoom In',
                                  child: SvgPicture.asset(
                                    'assets/icons/plus-circle.svg',
                                    color: HexColor(ColorWidget().white),
                                    fit: BoxFit.scaleDown,
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              margin:
                                  const EdgeInsets.only(top: 10.0, right: 20.0),
                              width: 40,
                              height: 40,
                              child: ElevatedButton(
                                onPressed: () => controller.zoomInOut('out'),
                                style: ElevatedButton.styleFrom(
                                  shape: const CircleBorder(),
                                  padding: const EdgeInsets.all(5),
                                  backgroundColor:
                                      HexColor(ColorWidget().primarySC),
                                ),
                                child: Tooltip(
                                  message: 'Zoom Out',
                                  child: SvgPicture.asset(
                                    'assets/icons/minus-circle.svg',
                                    color: HexColor(ColorWidget().white),
                                    fit: BoxFit.scaleDown,
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              margin:
                                  const EdgeInsets.only(top: 10.0, right: 20.0),
                              width: 40,
                              height: 40,
                              child: ElevatedButton(
                                onPressed: () {
                                  controller.refreshData();
                                },
                                style: ElevatedButton.styleFrom(
                                  shape: const CircleBorder(),
                                  padding: const EdgeInsets.all(5),
                                  backgroundColor:
                                      HexColor(ColorWidget().primarySC),
                                ),
                                child: Tooltip(
                                  message: 'Refresh',
                                  child: SvgPicture.asset(
                                    'assets/icons/refresh.svg',
                                    color: HexColor(ColorWidget().white),
                                    fit: BoxFit.scaleDown,
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              margin:
                                  const EdgeInsets.only(top: 10.0, right: 20.0),
                              width: 40,
                              height: 40,
                              child: ElevatedButton(
                                onPressed: () {
                                  ModalBottomSheetWidget().showModal(
                                    context,
                                    0.8,
                                    0.0,
                                    0.8,
                                    // const ListDirectionsSc(),
                                    LayListMcVehicleSc(),
                                    Container(),
                                    Container(),
                                    widgetTop: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 15.0),
                                      child: Column(
                                        children: [
                                          InputWidget(
                                            title: 'Travel History',
                                            controllerText:
                                                mapsMcScController.filterDateC,
                                            hintText: 'Enter Date Range',
                                            messageError: 'Date Range Required',
                                            prefixIcon: SvgPicture.asset(
                                              'assets/icons/calendar-alt.svg',
                                              color:
                                                  HexColor(ColorWidget().grey),
                                              fit: BoxFit.scaleDown,
                                            ),
                                            readOnly: true,
                                            obscureText: false,
                                            textRequired: true,
                                            onTap: () => mapsMcScController
                                                .dialogPickerFilterDate(
                                                    context),
                                            maxLines: 1,
                                            paddingVertical: 0,
                                          ),
                                          const SizedBox(
                                            height: 10.0,
                                          ),
                                          LayListMcVehicleSc()
                                              .listTime(context),
                                          const SizedBox(
                                            height: 10.0,
                                          ),
                                          Divider(
                                            thickness: 1.0,
                                            color: HexColor(ColorWidget().grey),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  shape: const CircleBorder(),
                                  padding: const EdgeInsets.all(5),
                                  backgroundColor:
                                      HexColor(ColorWidget().primarySC),
                                ),
                                child: Tooltip(
                                  message: 'Trip Vehicles',
                                  child: SvgPicture.asset(
                                    'assets/icons/directions.svg',
                                    color: HexColor(ColorWidget().white),
                                    fit: BoxFit.scaleDown,
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              margin:
                                  const EdgeInsets.only(top: 10.0, right: 20.0),
                              width: 40,
                              height: 40,
                              child: ElevatedButton(
                                onPressed: () {
                                  controller.justShowCar.value == true
                                      ? controller.justShowCar.value = false
                                      : controller.justShowCar.value = true;
                                },
                                style: ElevatedButton.styleFrom(
                                  shape: const CircleBorder(),
                                  padding: const EdgeInsets.all(5),
                                  backgroundColor:
                                      HexColor(ColorWidget().primarySC),
                                ),
                                child: Tooltip(
                                  message: 'Show Vehicles',
                                  child: SvgPicture.asset(
                                    'assets/icons/car.svg',
                                    color: HexColor(ColorWidget().white),
                                    fit: BoxFit.scaleDown,
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              margin:
                                  const EdgeInsets.only(top: 10.0, right: 20.0),
                              width: 40,
                              height: 40,
                              child: ElevatedButton(
                                onPressed: () {
                                  ModalBottomSheetWidget().showModal(
                                    context,
                                    0.6,
                                    0.0,
                                    0.6,
                                    ListTeamSc(
                                      data: controller.typeForm.value ==
                                              'road_sweeper'
                                          ? controller.taskGroupTeamsRs
                                          : controller.taskGroupTeamsMs,
                                    ),
                                    Container(),
                                    Container(),
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  shape: const CircleBorder(),
                                  padding: const EdgeInsets.all(5),
                                  backgroundColor:
                                      HexColor(ColorWidget().primarySC),
                                ),
                                child: Tooltip(
                                  message: 'Filter Route Team',
                                  child: SvgPicture.asset(
                                    'assets/icons/filter.svg',
                                    color: HexColor(ColorWidget().white),
                                    fit: BoxFit.scaleDown,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      // card detail vehicle directions
                      if (controller.mcVehicleTripData.isNotEmpty) ...[
                        if (controller.mcMinimizeTripData.isTrue)
                          Container(
                            alignment: Alignment.topLeft,
                            child: Container(
                              width: 180,
                              height: 30,
                              margin: const EdgeInsets.only(
                                left: 80.0,
                                top: 10.0,
                                bottom: 10.0,
                              ),
                              child: const McVehicleDirectionsMinimizeSc(),
                            ),
                          )
                        else
                          Container(
                            alignment:
                                MediaQuery.of(context).size.height < 1000.0
                                    ? Alignment.centerLeft
                                    : Alignment.bottomCenter,
                            child: Container(
                              height:
                                  MediaQuery.of(context).size.height < 1000.0
                                      ? MediaQuery.of(context).size.height
                                      : MediaQuery.of(context).size.height / 3,
                              width: MediaQuery.of(context).size.height < 1000.0
                                  ? MediaQuery.of(context).size.width / 3
                                  : MediaQuery.of(context).size.width,
                              margin: const EdgeInsets.only(
                                left: 80.0,
                                top: 10.0,
                                bottom: 10.0,
                              ),
                              child: LayCardMcVehicleDirectionsSc(
                                element: controller.mcVehicleTripData,
                              ),
                            ),
                          ),
                      ],

                      if (controller.listElement.isNotEmpty) ...[
                        if (controller.isDevice.value == 'phone') ...[
                          Container(
                            alignment:
                                MediaQuery.of(context).size.height < 500.0
                                    ? Alignment.centerLeft
                                    : Alignment.bottomCenter,
                            child: Container(
                              height: MediaQuery.of(context).size.height < 500.0
                                  ? MediaQuery.of(context).size.height
                                  : MediaQuery.of(context).size.height / 2,
                              width: MediaQuery.of(context).size.height < 500.0
                                  ? MediaQuery.of(context).size.width / 3
                                  : MediaQuery.of(context).size.width,
                              margin: const EdgeInsets.symmetric(
                                horizontal: 20.0,
                                vertical: 10.0,
                              ),
                              child: DetailPinSc(
                                element: controller.listElement,
                              ),
                            ),
                          ),
                        ] else ...[
                          Container(
                            alignment:
                                MediaQuery.of(context).size.height < 1000.0
                                    ? Alignment.centerLeft
                                    : Alignment.bottomCenter,
                            child: Container(
                              height:
                                  MediaQuery.of(context).size.height < 1000.0
                                      ? MediaQuery.of(context).size.height
                                      : MediaQuery.of(context).size.height / 3,
                              width: MediaQuery.of(context).size.height < 1000.0
                                  ? MediaQuery.of(context).size.width / 3
                                  : MediaQuery.of(context).size.width,
                              margin: const EdgeInsets.only(
                                left: 80.0,
                                top: 10.0,
                                bottom: 10.0,
                              ),
                              child: DetailPinSc(
                                element: controller.listElement,
                              ),
                            ),
                          ),
                        ]
                      ],

                      // detail vehicle
                      if (controller.detailVehicle.isNotEmpty) ...[
                        if (controller.isDevice.value == 'phone') ...[
                          Container(
                            alignment:
                                MediaQuery.of(context).size.height < 500.0
                                    ? Alignment.centerLeft
                                    : Alignment.bottomCenter,
                            child: Container(
                              height: MediaQuery.of(context).size.height < 500.0
                                  ? MediaQuery.of(context).size.height
                                  : MediaQuery.of(context).size.height / 2,
                              width: MediaQuery.of(context).size.height < 500.0
                                  ? MediaQuery.of(context).size.width / 3
                                  : MediaQuery.of(context).size.width,
                              margin: const EdgeInsets.symmetric(
                                horizontal: 20.0,
                                vertical: 10.0,
                              ),
                              child: DetailVehicleSc(
                                element: controller.detailVehicle,
                              ),
                            ),
                          ),
                        ] else ...[
                          Container(
                            alignment:
                                MediaQuery.of(context).size.height < 1000.0
                                    ? Alignment.centerLeft
                                    : Alignment.bottomCenter,
                            child: Container(
                              height:
                                  MediaQuery.of(context).size.height < 1000.0
                                      ? MediaQuery.of(context).size.height
                                      : MediaQuery.of(context).size.height / 3,
                              width: MediaQuery.of(context).size.height < 1000.0
                                  ? MediaQuery.of(context).size.width / 3
                                  : MediaQuery.of(context).size.width,
                              margin: const EdgeInsets.only(
                                left: 80.0,
                                top: 10.0,
                                bottom: 10.0,
                              ),
                              child: DetailVehicleSc(
                                element: controller.detailVehicle,
                              ),
                            ),
                          ),
                        ],
                      ],

                      // detail mc vehicle
                      if (controller.mcVehicleDetail.isNotEmpty) ...[
                        if (controller.isDevice.value == 'phone') ...[
                          Container(
                            alignment:
                                MediaQuery.of(context).size.height < 500.0
                                    ? Alignment.centerLeft
                                    : Alignment.bottomCenter,
                            child: Container(
                              height: MediaQuery.of(context).size.height < 500.0
                                  ? MediaQuery.of(context).size.height
                                  : MediaQuery.of(context).size.height / 2,
                              width: MediaQuery.of(context).size.height < 500.0
                                  ? MediaQuery.of(context).size.width / 3
                                  : MediaQuery.of(context).size.width,
                              margin: const EdgeInsets.symmetric(
                                horizontal: 20.0,
                                vertical: 10.0,
                              ),
                              child: LayDetailMcVehicleSc(
                                element: controller.mcVehicleDetail,
                              ),
                            ),
                          ),
                        ] else ...[
                          Container(
                            alignment:
                                MediaQuery.of(context).size.height < 1000.0
                                    ? Alignment.centerLeft
                                    : Alignment.bottomCenter,
                            child: Container(
                              height:
                                  MediaQuery.of(context).size.height < 1000.0
                                      ? MediaQuery.of(context).size.height
                                      : MediaQuery.of(context).size.height / 3,
                              width: MediaQuery.of(context).size.height < 1000.0
                                  ? MediaQuery.of(context).size.width / 3
                                  : MediaQuery.of(context).size.width,
                              margin: const EdgeInsets.only(
                                left: 80.0,
                                top: 10.0,
                                bottom: 10.0,
                              ),
                              child: LayDetailMcVehicleSc(
                                element: controller.mcVehicleDetail,
                              ),
                            ),
                          ),
                        ],
                      ],

                      // info vehicle
                      if (controller.mcVehicleTripData.isNotEmpty) ...[
                        if (controller.mcShowInfo.isTrue) ...[
                          Container(
                            alignment: Alignment.topLeft,
                            child: Container(
                              width: 450,
                              height: 450,
                              margin: const EdgeInsets.only(
                                left: 80.0,
                                top: 10.0,
                                bottom: 10.0,
                              ),
                              child: const InfoDetailVehicleSc(),
                            ),
                          )
                        ]
                      ] else if (controller.mcShowInfo.isTrue) ...[
                        Container(
                          alignment: Alignment.topLeft,
                          child: Container(
                            width: 450,
                            height: 250,
                            margin: const EdgeInsets.only(
                              left: 80.0,
                              top: 10.0,
                              bottom: 10.0,
                            ),
                            child: const LayInfoDetailSc(),
                          ),
                        )
                      ]
                    ],
                  ),
            floatingActionButton: controller.listElement.isNotEmpty ||
                    controller.mcVehicleTripData.isNotEmpty ||
                    controller.mcVehicleDetail.isNotEmpty
                ? Container()
                : Align(
                    alignment: Alignment.bottomLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 40.0),
                      child: FloatingActionButton(
                        tooltip: 'Back to center',
                        onPressed: () {
                          controller.listElement.clear();
                          controller.animateMapMove(
                              controller.routePoints[0], 15);
                        },
                        backgroundColor: HexColor(ColorWidget().primarySC),
                        child: SvgPicture.asset(
                          'assets/icons/map-pin-alt.svg',
                          color: HexColor(ColorWidget().white),
                          fit: BoxFit.scaleDown,
                        ),
                      ),
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}
