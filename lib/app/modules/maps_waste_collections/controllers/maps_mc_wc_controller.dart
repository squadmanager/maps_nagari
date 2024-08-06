import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:latlong2/latlong.dart';
import 'package:maps_nagari/app/modules/maps_waste_collections/controllers/maps_waste_collections_controller.dart';
import 'package:maps_nagari/app/widgets/color_widget.dart';
import 'package:maps_nagari/app/widgets/warning_widget.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../../../data/models/mceasy/mc_trips_detail_model.dart';
import '../../../data/models/mceasy/mc_trips_model.dart';
import '../../../data/models/mceasy/mc_vehicle_model.dart';
import '../../../data/models/mceasy/mc_vehicle_statuses_model.dart';
import '../../../data/providers/mceasy/mc_provider.dart';
import '../../../widgets/default_dialog_widget.dart';

class MapsMcWcController extends GetxController {
  final MapsWasteCollectionsController mapsMonitoringC =
      Get.find<MapsWasteCollectionsController>();
  final TextEditingController filterDateC = TextEditingController();

  final mcVehicleList = List<DataMcVehicleModel>.empty().obs;
  var isLoadingMcVehicle = false.obs;

  final mcVehicleStatusesList = List<DataMcVehicleStatusesModel>.empty().obs;
  var isLoadingVehicleStatuses = false.obs;
  var isEmptyVehicleStatuses = false.obs;

  final mcTripList = List<SummaryTrip>.empty().obs;
  final mcTripsDetailList = List<DataMcTripsDetailModel>.empty().obs;

  var rangeDateView = ''.obs;
  var rangeDateFilterStart = ''.obs;
  var rangeDateFilterEnd = ''.obs;

  late Timer timer;

  late Animation<Color?> animation;
  late AnimationController controller;

  @override
  void onInit() {
    // streamVehicleStatuses = StreamController();
    // mcVehiclesStatuses();
    getMcVehiclesStatuses();

    super.onInit();
  }

  @override
  void onReady() {
    timer = Timer.periodic(
      const Duration(seconds: 20),
      (_) => getMcVehiclesStatuses(),
    );

    super.onReady();
  }

  // @override
  // void onClose() {
  //   // streamVehicleStatuses.close();
  //   timer.cancel();
  //   super.onClose();
  // }

  // mcVehiclesStatuses() async {
  //   await McProvider()
  //       .getVehicleStatuses(KeyConfiguration().keyMcEasy)
  //       .then((value) async {
  //     streamVehicleStatuses.add(value);
  //     return value;
  //   });
  // }

  Future<void> showDurationStop(context, duration) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: HexColor(ColorWidget().white),
          title: Text(
            'Stop Duration',
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.w600,
              color: HexColor(ColorWidget().black),
            ),
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                  '$duration',
                  style: GoogleFonts.poppins(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w600,
                    color: HexColor(ColorWidget().black),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> showSpeed(context, speed) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: HexColor(ColorWidget().white),
          title: Text(
            'Speed',
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.w600,
              color: HexColor(ColorWidget().black),
            ),
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                  '$speed',
                  style: GoogleFonts.poppins(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w600,
                    color: HexColor(ColorWidget().black),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> getMcVehiclesStatuses() async {
    // isLoadingVehicleStatuses(true);
    try {
      var data = await McProvider().getVehicleStatuses();

      mcVehicleStatusesList.value = data.where((element) {
        return element.vehicleGroups
                .where((vg) =>
                    vg == mapsMonitoringC.gpsGroup.value &&
                    element.licensePlate.contains('- CAM') == false)
                .isNotEmpty
            ? true
            : false;
      }).toList();

      if (mcVehicleStatusesList.isNotEmpty) {
        isEmptyVehicleStatuses.value = false;
      } else {
        isEmptyVehicleStatuses.value = true;
      }

      if (mapsMonitoringC.mcOpenVehicleDetail.isTrue) {
        for (var i = 0; i < mcVehicleStatusesList.length; i++) {
          for (var e in mapsMonitoringC.mcVehicleDetail) {
            if (e['vehicleId'] == mcVehicleStatusesList[i].vehicleId) {
              mapsMonitoringC.gotoLocation(
                mcVehicleStatusesList[i].latitude,
                mcVehicleStatusesList[i].longitude,
                18,
              );
              mapsMonitoringC.mcVehicleDetail.clear();
              mapsMonitoringC.mcVehicleDetail.add({
                'vehicleId': mcVehicleStatusesList[i].vehicleId,
                'licensePlate': mcVehicleStatusesList[i].licensePlate,
                'hullNo': mcVehicleStatusesList[i].hullNo,
                'engineOn': mcVehicleStatusesList[i].engineOn,
                'address': mcVehicleStatusesList[i].address,
                'speed': mcVehicleStatusesList[i].speed,
                'motionStatus': mcVehicleStatusesList[i].motionStatus,
                'imei': mcVehicleStatusesList[i].imei,
                'sumDistance': mcVehicleStatusesList[i].sumDistance,
                'sumDrivetimeFormatted':
                    mcVehicleStatusesList[i].sumDrivetimeFormatted,
              });
            }
          }
        }
      }

      isLoadingVehicleStatuses(false);
    } catch (e) {
      isLoadingVehicleStatuses(false);
    }
  }

  Future<void> submitDirections(form, vehicleId) async {
    final isValid = form.currentState.validate();
    if (!isValid) {
      return;
    }

    var startDate =
        '${rangeDateFilterStart.value}T${mapsMonitoringC.firstTimeC.text}:00.000Z';
    var endDate =
        '${rangeDateFilterEnd.value}T${mapsMonitoringC.lastTimeC.text}:00.000Z';

    mapsMonitoringC.mcVehicleId.value = vehicleId;

    mapsMonitoringC.isLoading(true);

    mapsMonitoringC.latLngStopVehicle.clear();
    mapsMonitoringC.latLngFilter.clear();
    mapsMonitoringC.routePoints.clear();
    mapsMonitoringC.mcRouteLine.clear();
    mapsMonitoringC.mcVehicleTripData.clear();
    // var dataTrip = await McProvider().getTrips(vehicleId, startDate, endDate);
    // mcTripList.value = dataTrip.summaryTrips;

    // print('${dataTrip} data trip ==========');
    // try {
    var dataTrip = await McProvider().getTrips(vehicleId, startDate, endDate);
    mcTripList.value = dataTrip.summaryTrips;

    var vehicleDetail = await McProvider().getVehicleDetail(vehicleId);

    mapsMonitoringC.mcVehicleTripData.add({
      'licensePlate': vehicleDetail.licensePlate,
      'hullNo': vehicleDetail.hullNo,
      'imei': vehicleDetail.imei,
      'totalTrip': dataTrip.totalTrip,
      'totalMovingTripDuration': dataTrip.totalMovingTripDuration,
      'totalMovingTripDistance': dataTrip.totalMovingTripDistance,
      'totalHourStart': dataTrip.totalHourStart,
      'totalHourStop': dataTrip.totalHourStop,
    });

    // mcTripList.where((p0) => p0.startLat == p0.stopLat)

    for (var i = 0; i < mcTripList.length; i++) {
      mapsMonitoringC.latLngStopVehicle.add({
        'lat': mcTripList[i].startLat,
        'lng': mcTripList[i].startLong,
        'totalHourStop': mcTripList[i].totalHourStop,
      });
    }

    var dataTripDetail =
        await McProvider().getTripsDetail(vehicleId, startDate, endDate);
    mcTripsDetailList.value = dataTripDetail;

    if (mcTripsDetailList.isEmpty) {
      mapsMonitoringC.refreshData();
      mapsMonitoringC.isLoading(false);
      WarningWidget().dialog('There are no vehicle routes');

      return;
    }

    int chunkSize = 2;
    for (var i = 0; i < mcTripsDetailList.length; i += chunkSize) {
      if (mcTripsDetailList[i].speed <= 15) {
        mapsMonitoringC.mcRouteLine.add({
          'speed': mcTripsDetailList[i].speed,
          'color': HexColor(ColorWidget().green),
          'data': mcTripsDetailList.sublist(
              i,
              i + chunkSize > mcTripsDetailList.length
                  ? mcTripsDetailList.length
                  : i + chunkSize),
        });
      } else if (mcTripsDetailList[i].speed > 15 &&
          mcTripsDetailList[i].speed <= 30) {
        mapsMonitoringC.mcRouteLine.add({
          'speed': mcTripsDetailList[i].speed,
          'color': HexColor(ColorWidget().yellow),
          'data': mcTripsDetailList.sublist(
              i,
              i + chunkSize > mcTripsDetailList.length
                  ? mcTripsDetailList.length
                  : i + chunkSize),
        });
      } else if (mcTripsDetailList[i].speed > 30 &&
          mcTripsDetailList[i].speed <= 40) {
        mapsMonitoringC.mcRouteLine.add({
          'speed': mcTripsDetailList[i].speed,
          'color': HexColor(ColorWidget().orange),
          'data': mcTripsDetailList.sublist(
              i,
              i + chunkSize > mcTripsDetailList.length
                  ? mcTripsDetailList.length
                  : i + chunkSize),
        });
      } else if (mcTripsDetailList[i].speed > 40 &&
          mcTripsDetailList[i].speed <= 70) {
        mapsMonitoringC.mcRouteLine.add({
          'speed': mcTripsDetailList[i].speed,
          'color': HexColor(ColorWidget().red),
          'data': mcTripsDetailList.sublist(
              i,
              i + chunkSize > mcTripsDetailList.length
                  ? mcTripsDetailList.length
                  : i + chunkSize),
        });
      } else if (mcTripsDetailList[i].speed > 70) {
        mapsMonitoringC.mcRouteLine.add({
          'speed': mcTripsDetailList[i].speed,
          'color': HexColor(ColorWidget().blackRed),
          'data': mcTripsDetailList.sublist(
              i,
              i + chunkSize > mcTripsDetailList.length
                  ? mcTripsDetailList.length
                  : i + chunkSize),
        });
      }
    }

    for (var i = 0; i < mcTripsDetailList.length; i++) {
      mapsMonitoringC.latLngFilter.add({
        'datetime': mcTripsDetailList[i].lastReceive,
        'lng': mcTripsDetailList[i].longitude,
        'lat': mcTripsDetailList[i].latitude,
      });

      mapsMonitoringC.routePoints.add(
        LatLng(
          mcTripsDetailList[i].latitude,
          mcTripsDetailList[i].longitude,
        ),
      );
      mapsMonitoringC.tracking.add(mcTripsDetailList[i].licensePlate);
    }

    mapsMonitoringC.animateMapMove(
        LatLng(
            mcTripsDetailList.last.latitude, mcTripsDetailList.last.longitude),
        15);

    mapsMonitoringC.isLoading(false);
    // } catch (e) {
    //   print('${e.toString()} error =======');
    //   mapsMonitoringC.isLoading(false);
    // }
  }

  void onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    if (args.value is PickerDateRange) {
      rangeDateView.value =
          '${DateFormat("d MMMM y", "id_ID").format(args.value.startDate)} - ${DateFormat("d MMMM y", "id_ID").format(args.value.endDate ?? args.value.startDate)}';
      rangeDateFilterStart.value =
          DateFormat('yyyy-MM-dd').format(args.value.startDate);
      rangeDateFilterEnd.value = DateFormat('yyyy-MM-dd')
          .format(args.value.endDate ?? args.value.startDate);
    }
  }

  Widget getDateFilter() {
    return SizedBox(
      height: 350,
      width: 500,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10.0),
        child: SfDateRangePicker(
          onSelectionChanged: onSelectionChanged,
          selectionMode: DateRangePickerSelectionMode.range,
          initialSelectedRange: null,
          backgroundColor: HexColor(ColorWidget().white),
          selectionColor: HexColor(ColorWidget().primary),
        ),
      ),
    );
  }

  void dialogPickerFilterDate(context) {
    DefaultDialogWidget().getDefaultDialog(
      context,
      'Select Range Date',
      getDateFilter(),
      () {
        rangeDateFilterStart.value;
        rangeDateFilterEnd.value;
        rangeDateView.value;
        filterDateC.text = rangeDateView.value;
        Get.back();
      },
      'Submit',
      HexColor(ColorWidget().primary),
      HexColor(ColorWidget().white),
      () {
        rangeDateFilterStart.value = '';
        rangeDateFilterEnd.value = '';
        rangeDateView.value = '';
        filterDateC.text = rangeDateView.value;
        Get.back();
      },
      'Cancel',
    );
  }
}
