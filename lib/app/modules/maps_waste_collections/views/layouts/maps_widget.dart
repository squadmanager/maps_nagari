import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_compass/flutter_map_compass.dart';
import 'package:flutter_map_tappable_polyline/flutter_map_tappable_polyline.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:latlong2/latlong.dart';

import '../../../../widgets/color_widget.dart';
import '../../controllers/maps_mc_wc_controller.dart';
import '../../controllers/maps_waste_collections_controller.dart';

class MapsWidget extends GetView<MapsWasteCollectionsController> {
  final data;
  // final List vehicleName;
  // final List latLngNow;
  // final List vehicleProfile;
  MapsWidget(
      {required this.data,
      // required this.vehicleName,
      // required this.latLngNow,
      // required this.vehicleProfile,
      super.key});

  final MapsMcWcController mapsMcWcController = Get.put(MapsMcWcController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => FlutterMap(
        mapController: controller.mapController,
        options: MapOptions(
          interactionOptions: controller.tracking.isNotEmpty
              ? InteractionOptions(
                  cursorKeyboardRotationOptions:
                      CursorKeyboardRotationOptions.disabled(),
                )
              : const InteractionOptions(flags: InteractiveFlag.all),
          center: controller.tracking.isNotEmpty
              ? LatLng(
                  mapsMcWcController.mcTripsDetailList.last.latitude,
                  mapsMcWcController.mcTripsDetailList.last.longitude,
                )
              : controller.routePoints[0],
          zoom: 14,
          // onTap: (tapPosition, point) {
          //   controller.latClick.value = point.latitude;
          //   controller.longClick.value = point.longitude;
          // },
        ),
        children: [
          TileLayer(
            urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
            userAgentPackageName: 'com.example.app',
          ),
          if (controller.tracking.isNotEmpty) ...[
            PolylineLayer(
              polylineCulling: false,
              polylines: [
                Polyline(
                  points: controller.routePoints,
                  color: HexColor(ColorWidget().green),
                  strokeWidth: 5,
                ),
              ],
            ),
            TappablePolylineLayer(
              polylineCulling: false,
              polylines: [
                for (int i = 0; i < controller.mcRouteLine.length; i++) ...[
                  TaggedPolyline(
                    tag: '${controller.mcRouteLine[i]['speed']}',
                    points: [
                      for (var e in controller.mcRouteLine[i]['data'])
                        LatLng(e.latitude, e.longitude)
                    ],
                    color: controller.mcRouteLine[i]['color'],
                    strokeWidth: 5.0,
                  ),
                ],
              ],
              onTap: (polylines, tapPosition) {
                mapsMcWcController.showSpeed(
                  context,
                  '${polylines[0].tag} Km/Jam',
                );
              },
            ),
          ],
          MarkerLayer(
            markers: [
              // current location user
              Marker(
                rotate: true,
                width: 40,
                height: 40,
                point: LatLng(
                  controller.latCurrentLocation.value,
                  controller.lngCurrentLocation.value,
                ),
                child: Column(
                  children: [
                    Image.asset(
                      'assets/images/user-2.png',
                    ),
                  ],
                ),
              ),
              // end current location user
              if (controller.tracking.isNotEmpty) ...[
                // route tracking
                Marker(
                  alignment: Alignment.topRight,
                  rotate: true,
                  width: 40,
                  height: 60,
                  point: LatLng(
                    mapsMcWcController.mcTripsDetailList.last.latitude,
                    mapsMcWcController.mcTripsDetailList.last.longitude,
                  ),
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.0),
                          color: HexColor(ColorWidget().primary),
                        ),
                        child: Center(
                          child: Text(
                            'Start',
                            style: GoogleFonts.poppins(
                              fontSize: 12.0,
                              fontWeight: FontWeight.w500,
                              color: HexColor(ColorWidget().white),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 2.0),
                        child: SvgPicture.asset(
                          'assets/icons/windsock.svg',
                          color: HexColor(ColorWidget().primary),
                          height: 40,
                          width: 40,
                        ),
                      ),
                    ],
                  ),
                ),
                Marker(
                  alignment: Alignment.topRight,
                  rotate: true,
                  width: 40,
                  height: 60,
                  point: LatLng(
                    mapsMcWcController.mcTripsDetailList.first.latitude,
                    mapsMcWcController.mcTripsDetailList.first.longitude,
                  ),
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.0),
                          color: HexColor(ColorWidget().primary),
                        ),
                        child: Center(
                          child: Text(
                            'End',
                            style: GoogleFonts.poppins(
                              fontSize: 12.0,
                              fontWeight: FontWeight.w500,
                              color: HexColor(ColorWidget().white),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 2.0),
                        child: SvgPicture.asset(
                          'assets/icons/windsock.svg',
                          color: HexColor(ColorWidget().primary),
                          height: 40,
                          width: 40,
                        ),
                      ),
                    ],
                  ),
                ),

                if (controller.latLngStopVehicle.isNotEmpty) ...[
                  for (int i = 0; i < controller.latLngStopVehicle.length; i++)
                    Marker(
                      rotate: true,
                      width: 30,
                      height: 30,
                      point: LatLng(
                        controller.latLngStopVehicle[i]['lat'],
                        controller.latLngStopVehicle[i]['lng'],
                      ),
                      child: InkWell(
                        onTap: () {
                          mapsMcWcController.showDurationStop(
                            context,
                            controller.latLngStopVehicle[i]['totalHourStop'],
                          );
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: HexColor(ColorWidget().red),
                          ),
                          child: Center(
                            child: SvgPicture.asset(
                              'assets/icons/stop-circle.svg',
                              color: HexColor(ColorWidget().white),
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              ],
              // collection point
              if (controller.justShowCar.isFalse) ...[
                for (int i = 0; i < data.length; i++) ...[
                  Marker(
                    rotate: true,
                    width: 90,
                    height: 60,
                    point: LatLng(
                      double.parse(
                        data[i]['latitude'],
                      ),
                      double.parse(data[i]['longititude']),
                    ),
                    child: InkWell(
                      onTap: () {
                        controller.attachmentList.clear();
                        controller.getImage(data[i]['trans_dta_id']);
                        controller.listElement.clear();
                        controller.detailVehicle.clear();

                        controller.mcOpenVehicleDetail(false);
                        controller.mcVehicleDetail.clear();

                        controller.gotoLocation(
                          double.parse(
                            data[i]['latitude'],
                          ),
                          double.parse(data[i]['longititude']),
                          18,
                        );

                        controller.listElement.add({
                          'lat': double.parse(
                            data[i]['latitude'],
                          ),
                          'lng': double.parse(data[i]['longititude']),
                          'userAssigment': data[i]['user_assigment'],
                          'locationTask': data[i]['location_task'],
                          'status': data[i]['status'],
                        });
                      },
                      child: Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5.0),
                              color: HexColor(
                                data[i]['status'] == '1'
                                    ? ColorWidget().green
                                    : data[i]['colour_user'],
                              ),
                            ),
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 5.0),
                              child: Text(
                                data[i]['location_task'].length > 25
                                    ? '${data[i]['location_task'].substring(0, 25)}...'
                                    : data[i]['location_task'],
                                style: GoogleFonts.poppins(
                                  fontSize: 8.0,
                                  fontWeight: FontWeight.bold,
                                  color: HexColor(ColorWidget().white),
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 2.0,
                          ),
                          Center(
                            child: Image.asset(
                              controller.typeForm.value == 'dragonfly'
                                  ? 'assets/images/cp_dragonfly.png'
                                  : controller.typeForm.value == 'compactor'
                                      ? 'assets/images/cp_compactor.png'
                                      : 'assets/images/cp_pruning.png',
                              width: 30.0,
                              height: 30.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ],

              // mc vehicle
              if (mapsMcWcController.mcVehicleStatusesList.isNotEmpty)
                for (var element in controller.tracking.isNotEmpty
                    ? mapsMcWcController.mcVehicleStatusesList
                        .where(
                            (e) => e.vehicleId == controller.mcVehicleId.value)
                        .toList()
                    : mapsMcWcController.mcVehicleStatusesList) ...[
                  Marker(
                    alignment: Alignment.topCenter,
                    rotate: true,
                    width: 80,
                    height: 75,
                    point: LatLng(
                      element.latitude,
                      element.longitude,
                    ),
                    child: InkWell(
                      onTap: () {
                        controller.attachmentList.clear();
                        controller.listElement.clear();
                        controller.detailVehicle.clear();

                        controller.mcOpenVehicleDetail(true);
                        controller.mcVehicleDetail.clear();
                        controller.gotoLocation(
                          element.latitude,
                          element.longitude,
                          18,
                        );
                        controller.mcVehicleDetail.add({
                          'vehicleId': element.vehicleId,
                          'licensePlate': element.licensePlate,
                          'hullNo': element.hullNo,
                          'engineOn': element.engineOn,
                          'address': element.address,
                          'speed': element.speed,
                          'motionStatus': element.motionStatus,
                          'imei': element.imei,
                          'sumDistance': element.sumDistance,
                          'sumDrivetimeFormatted':
                              element.sumDrivetimeFormatted,
                        });
                      },
                      child: Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5.0),
                              color: HexColor(
                                element.motionStatus == 'M'
                                    ? ColorWidget().blue
                                    : element.motionStatus == 'I'
                                        ? ColorWidget().yellow
                                        : ColorWidget().red,
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Text(
                                element.licensePlate.length > 10
                                    ? '${element.licensePlate.substring(0, 10)}...'
                                    : element.licensePlate,
                                style: GoogleFonts.poppins(
                                  fontSize: 10.0,
                                  fontWeight: FontWeight.w500,
                                  color: HexColor(
                                    ColorWidget().white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 5.0),
                            child: Image.asset(
                              element.motionStatus == 'M'
                                  ? 'assets/images/pin-map-car-blue.png'
                                  : element.motionStatus == 'I'
                                      ? 'assets/images/pin-map-car-yellow.png'
                                      : 'assets/images/pin-map-car-red.png',
                              height: 40,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],

              // end mc vehicle
            ],
          ),
          const MapCompass.cupertino(
            hideIfRotatedNorth: false,
            padding: EdgeInsets.only(top: 40.0, right: 18.0),
            animationCurve: Curves.easeInOut,
          ),
        ],
      ),
    );
  }
}

//  // vehicle
// for (int i = 0; i < vehicleName.length; i++) ...[
//   Marker(
//     rotate: true,
//     width: 50,
//     height: 90,
//     point: LatLng(
//       latLngNow[i]['lat'],
//       latLngNow[i]['lng'],
//     ),
//     child: InkWell(
//       onTap: () {
//         controller.listElement.clear();
//         controller.detailVehicle.clear();

//         controller.gotoLocation(
//           latLngNow[i]['lat'],
//           latLngNow[i]['lng'],
//           18,
//         );

//         controller.detailVehicle.add({
//           'images': vehicleProfile[i]['images'],
//           'name': vehicleProfile[i]['name'],
//           'nopol': vehicleProfile[i]['nopol'],
//         });
//       },
//       child: Column(
//         children: [
//           Container(
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(5.0),
//               color:
//                   HexColor(ColorWidget().primaryWasteCollections),
//             ),
//             child: Padding(
//               padding:
//                   const EdgeInsets.symmetric(horizontal: 5.0),
//               child: Text(
//                 vehicleProfile[i]['name'].length > 10
//                     ? '${vehicleProfile[i]['name'].substring(0, 10)}...'
//                     : vehicleProfile[i]['name'],
//                 style: GoogleFonts.poppins(
//                   fontSize: 8.0,
//                   fontWeight: FontWeight.bold,
//                   color: HexColor(ColorWidget().white),
//                 ),
//                 textAlign: TextAlign.center,
//               ),
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.only(top: 2.0),
//             child: Image.network(
//               '${vehicleProfile[i]['images']}',
//             ),
//           ),
//         ],
//       ),
//     ),
//   ),
// ],
