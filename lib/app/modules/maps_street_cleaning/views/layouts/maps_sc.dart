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
import '../../controllers/maps_mc_sc_controller.dart';
import '../../controllers/maps_street_cleaning_controller.dart';

class MapsSc extends GetView<MapsStreetCleaningController> {
  final data;
  // final List vehicleName;
  // final List latLngNow;
  // final List vehicleProfile;
  MapsSc(
      {required this.data,
      // required this.vehicleName,
      // required this.latLngNow,
      // required this.vehicleProfile,
      super.key});

  final MapsMcScController mapsMcScController = Get.put(MapsMcScController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => FlutterMap(
        mapController: controller.mapController,
        options: MapOptions(
          center: controller.tracking.isNotEmpty
              ? LatLng(
                  mapsMcScController.mcTripsDetailList.last.latitude,
                  mapsMcScController.mcTripsDetailList.last.longitude,
                )
              : controller.routePoints[0],
          zoom: 15,
          interactionOptions: controller.tracking.isNotEmpty
              ? InteractionOptions(
                  cursorKeyboardRotationOptions:
                      CursorKeyboardRotationOptions.disabled(),
                )
              : const InteractionOptions(flags: InteractiveFlag.all),
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
                mapsMcScController.showSpeed(
                  context,
                  '${polylines[0].tag} Km/Jam',
                );
              },
            ),
          ] else ...[
            if (controller.justShowCar.isFalse)
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
                  alignment: Alignment.topCenter,
                  rotate: true,
                  width: 80,
                  height: 75,
                  point: LatLng(
                    mapsMcScController.mcTripsDetailList.last.latitude,
                    mapsMcScController.mcTripsDetailList.last.longitude,
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
                          height: 50,
                          width: 50,
                        ),
                      ),
                    ],
                  ),
                ),
                Marker(
                  alignment: Alignment.topCenter,
                  rotate: true,
                  width: 80,
                  height: 75,
                  point: LatLng(
                    mapsMcScController.mcTripsDetailList.first.latitude,
                    mapsMcScController.mcTripsDetailList.first.longitude,
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
                          height: 50,
                          width: 50,
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
                          mapsMcScController.showDurationStop(
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
                for (var element in data) ...[
                  if (data.last['detail_dailytask_id'] ==
                      element['detail_dailytask_id']) ...[
                    // start last index
                    Marker(
                      alignment: Alignment.topCenter,
                      rotate: true,
                      width: 200,
                      height: 45,
                      point: LatLng(
                        double.parse(
                              data.last['lat_start'],
                            ) -
                            0.00005,
                        double.parse(data.last['lng_start']),
                      ),
                      child: InkWell(
                        onTap: () {
                          controller.attachmentList.clear();
                          controller.getImage(data.last['trans_dtsc_id']);
                          controller.listElement.clear();
                          controller.detailVehicle.clear();

                          controller.mcOpenVehicleDetail(false);
                          controller.mcVehicleDetail.clear();

                          controller.gotoLocation(
                            double.parse(
                              data.last['lat_start'],
                            ),
                            double.parse(data.last['lng_start']),
                            17,
                          );

                          controller.listElement.add({
                            'lat': double.parse(
                              data.last['lat_start'],
                            ),
                            'lng': double.parse(data.last['lng_start']),
                            'taskName': data.last['task_name'],
                            'userAssigment':
                                '${data.last['location_start']} - ${data.last['location_end']}',
                            'status': data.last['status'],
                          });
                        },
                        child: Column(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5.0),
                                color: HexColor(
                                  data.last['status'] == '1'
                                      ? ColorWidget().green
                                      : data.last['colour_user'],
                                ),
                              ),
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 5.0),
                                child: Text(
                                  data.last['location_start'].length > 20
                                      ? '${data.last['location_start'].substring(0, 20)}...'
                                      : data.last['location_start'],
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
                              child: SvgPicture.asset(
                                'assets/icons/map-marker.svg',
                                width: 30.0,
                                height: 30.0,
                                color: HexColor(data.last['colour_user']),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    // finish last index
                    Marker(
                      alignment: Alignment.topCenter,
                      rotate: true,
                      width: 200,
                      height: 45,
                      point: LatLng(
                        double.parse(
                              data.last['lat_finish'],
                            ) -
                            0.00005,
                        double.parse(data.last['lng_finish']),
                      ),
                      child: InkWell(
                        onTap: () {
                          controller.attachmentList.clear();
                          controller.getImage(data.last['trans_dtsc_id']);
                          controller.listElement.clear();
                          controller.detailVehicle.clear();

                          controller.mcOpenVehicleDetail(false);
                          controller.mcVehicleDetail.clear();

                          controller.gotoLocation(
                            double.parse(
                              data.last['lat_finish'],
                            ),
                            double.parse(data.last['lng_finish']),
                            17,
                          );

                          controller.listElement.add({
                            'lat': double.parse(
                              data.last['lat_finish'],
                            ),
                            'lng': double.parse(data.last['lng_finish']),
                            'taskName': data.last['task_name'],
                            'userAssigment':
                                '${data.last['location_start']} - ${data.last['location_end']}',
                            'status': data.last['status'],
                          });
                        },
                        child: Column(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5.0),
                                color: HexColor(
                                  data.last['status'] == '1'
                                      ? ColorWidget().green
                                      : data.last['colour_user'],
                                ),
                              ),
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 5.0),
                                child: Text(
                                  data.last['location_end'].length > 20
                                      ? '${data.last['location_end'].substring(0, 20)}...'
                                      : data.last['location_end'],
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
                              child: SvgPicture.asset(
                                'assets/icons/map-marker.svg',
                                width: 30.0,
                                height: 30.0,
                                color: HexColor(data.last['colour_user']),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ] else ...[
                    Marker(
                      alignment: Alignment.topCenter,
                      rotate: true,
                      width: 200,
                      height: 45,
                      point: LatLng(
                        double.parse(
                              element['lat_start'],
                            ) -
                            0.00005,
                        double.parse(element['lng_start']),
                      ),
                      child: InkWell(
                        onTap: () {
                          controller.attachmentList.clear();
                          controller.getImage(element['trans_dtsc_id']);
                          controller.listElement.clear();
                          controller.detailVehicle.clear();

                          controller.mcOpenVehicleDetail(false);
                          controller.mcVehicleDetail.clear();

                          controller.gotoLocation(
                            double.parse(
                              element['lat_start'],
                            ),
                            double.parse(element['lng_start']),
                            17,
                          );

                          controller.listElement.add({
                            'lat': double.parse(
                              element['lat_start'],
                            ),
                            'lng': double.parse(element['lng_start']),
                            'taskName': element['task_name'],
                            'userAssigment':
                                '${element['location_start']} - ${element['location_end']}',
                            'status': element['status'],
                          });
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5.0),
                                color: HexColor(
                                  element['status'] == '1'
                                      ? ColorWidget().green
                                      : element['colour_user'],
                                ),
                              ),
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 5.0),
                                child: Text(
                                  element['location_start'].length > 20
                                      ? '${element['location_start'].substring(0, 20)}...'
                                      : element['location_start'],
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
                              child: SvgPicture.asset(
                                'assets/icons/map-marker.svg',
                                width: 30.0,
                                height: 30.0,
                                color: HexColor(element['colour_user']),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ]
                ],
              ],

              // mc vehicle
              if (mapsMcScController.mcVehicleStatusesList.isNotEmpty)
                for (var element in controller.tracking.isNotEmpty
                    ? mapsMcScController.mcVehicleStatusesList
                        .where(
                            (e) => e.vehicleId == controller.mcVehicleId.value)
                        .toList()
                    : mapsMcScController.mcVehicleStatusesList) ...[
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

// // vehicle
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
//               color: HexColor(ColorWidget().primarySC),
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
