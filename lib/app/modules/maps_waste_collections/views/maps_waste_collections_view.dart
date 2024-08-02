import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:maps_nagari/app/modules/login/controllers/auth_controller.dart';
import 'package:maps_nagari/app/modules/maps_waste_collections/views/layouts/lay_info_detail.dart';
import 'package:maps_nagari/app/modules/maps_waste_collections/views/layouts/search_map_widget.dart';

import '../../../widgets/color_widget.dart';
import '../../../widgets/input_widget.dart';
import '../../../widgets/modal_bottom_sheet_widget.dart';
import '../controllers/maps_mc_wc_controller.dart';
import '../controllers/maps_waste_collections_controller.dart';
import 'layouts/detail_pin_widget.dart';
import 'layouts/detail_vehicle_widget.dart';
import 'layouts/lay_card_mc_vehicle_directions.dart';
import 'layouts/lay_detail_mc_vehicle.dart';
import 'layouts/lay_list_mc_vehicle.dart';
import 'layouts/list_location_widget.dart';

class MapsWasteCollectionsView extends GetView<MapsWasteCollectionsController> {
  MapsWasteCollectionsView({Key? key}) : super(key: key);

  final MapsMcWcController mapsMcWcController = Get.put(MapsMcWcController());
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
                      const ListLocationWidget(),
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
                                  backgroundColor: HexColor(
                                      ColorWidget().primaryWasteCollections),
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
                                  controller.changeFilterTypeForm('dragonfly');
                                },
                                style: ElevatedButton.styleFrom(
                                  shape: const CircleBorder(),
                                  padding: const EdgeInsets.all(5),
                                  backgroundColor: HexColor(
                                      ColorWidget().primaryWasteCollections),
                                ),
                                child: Tooltip(
                                  message: 'Task Dragonfly',
                                  child: Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: SvgPicture.asset(
                                      'assets/icons/3-wheel-1.svg',
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
                                  controller.changeFilterTypeForm('compactor');
                                },
                                style: ElevatedButton.styleFrom(
                                  shape: const CircleBorder(),
                                  padding: const EdgeInsets.all(5),
                                  backgroundColor: HexColor(
                                      ColorWidget().primaryWasteCollections),
                                ),
                                child: Tooltip(
                                  message: 'Task Compactor',
                                  child: Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: SvgPicture.asset(
                                      'assets/icons/garbage-truck.svg',
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
                                  controller.changeFilterTypeForm('pruning');
                                },
                                style: ElevatedButton.styleFrom(
                                  shape: const CircleBorder(),
                                  padding: const EdgeInsets.all(5),
                                  backgroundColor: HexColor(
                                      ColorWidget().primaryWasteCollections),
                                ),
                                child: Tooltip(
                                  message: 'Task Pruning',
                                  child: Padding(
                                    padding: const EdgeInsets.all(2.0),
                                    child: SvgPicture.asset(
                                      'assets/icons/task-pruning.svg',
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
                                    const SearchMapWidget(),
                                    Container(),
                                    Container(),
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  shape: const CircleBorder(),
                                  padding: const EdgeInsets.all(5),
                                  backgroundColor: HexColor(
                                      ColorWidget().primaryWasteCollections),
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
                                  backgroundColor: HexColor(
                                      ColorWidget().primaryWasteCollections),
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
                                  backgroundColor: HexColor(
                                      ColorWidget().primaryWasteCollections),
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
                                  backgroundColor: HexColor(
                                      ColorWidget().primaryWasteCollections),
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
                                    // const ListDirectionsWidget(),
                                    LayListMcVehicle(),
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
                                                mapsMcWcController.filterDateC,
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
                                            onTap: () => mapsMcWcController
                                                .dialogPickerFilterDate(
                                                    context),
                                            maxLines: 1,
                                            paddingVertical: 0,
                                          ),
                                          const SizedBox(
                                            height: 10.0,
                                          ),
                                          LayListMcVehicle().listTime(context),
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
                                  backgroundColor: HexColor(
                                      ColorWidget().primaryWasteCollections),
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
                                  backgroundColor: HexColor(
                                      ColorWidget().primaryWasteCollections),
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
                              child: const McVehicleDirectionsMinimize(),
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
                              child: LayCardMcVehicleDirections(
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
                              child: DetailPinWidget(
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
                              child: DetailPinWidget(
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
                              child: DetailVehicleWidget(
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
                              child: DetailVehicleWidget(
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
                              child: LayDetailMcVehicle(
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
                              child: LayDetailMcVehicle(
                                element: controller.mcVehicleDetail,
                              ),
                            ),
                          ),
                        ]
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
                              child: const InfoDetailVehicle(),
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
                            child: const LayInfoDetail(),
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
                        backgroundColor:
                            HexColor(ColorWidget().primaryWasteCollections),
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
