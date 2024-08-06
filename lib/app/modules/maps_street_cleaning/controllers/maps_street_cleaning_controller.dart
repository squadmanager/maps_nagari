import 'dart:async';
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:latlong2/latlong.dart';
import 'package:maps_nagari/app/data/models/task_group_teams_ms_model.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../../../components/expired_session_c.dart';
import '../../../data/models/attachment_sc_model.dart';
import '../../../data/models/daily_task_ms_model.dart';
import '../../../data/models/daily_task_rs_model.dart';
import '../../../data/models/task_group_teams_rs_model.dart';
import '../../../data/providers/attachment_sc_provider.dart';
import '../../../data/providers/daily_task_ms_provider.dart';
import '../../../data/providers/daily_task_rs_provider.dart';
import '../../../data/providers/directions_provider.dart';
import '../../../data/providers/firebase_provider.dart';
import '../../../data/providers/monitoring_sc_provider.dart';
import '../../../widgets/color_widget.dart';
import '../../../widgets/default_dialog_widget.dart';
import '../../../widgets/snackbar_widget.dart';
import '../../../widgets/time_covert_widget.dart';
import '../../../widgets/warning_widget.dart';

class MapsStreetCleaningController extends GetxController
    with GetTickerProviderStateMixin {
  final formKey = GlobalKey<FormState>().obs;
  final TextEditingController filterDateC = TextEditingController();
  final TextEditingController firstTimeC = TextEditingController();
  final TextEditingController lastTimeC = TextEditingController();
  final TextEditingController searchC = TextEditingController();
  MapController mapController = MapController();
  late PageController pageCarouselController;

  final attachmentList = List<DataAttachmentScModel>.empty().obs;
  List<LatLng> routePoints = [const LatLng(-0.9722283291919985, 116.70915419634736)].obs;
  List<Marker> markers = List.empty();
  List listLatLng = [].obs;
  List latLngFilter = [].obs;
  final dailyTask = List<DataDailyTaskRsModel>.empty().obs;
  final dailyTaskMs = List<DataDailyTaskMsModel>.empty().obs;

  final taskGroupTeamsMs = List<DataTaskGroupTeamsMsModel>.empty().obs;
  final taskGroupTeamsRs = List<DataTaskGroupTeamsRsModel>.empty().obs;

  var isBackValue = ''.obs;

  var fullName = ''.obs;
  var role = ''.obs;
  var roleString = ''.obs;
  var token = ''.obs;
  var gpsGroup = ''.obs;

  var isLoading = false.obs;
  var isLoadingGroupTeams = false.obs;
  var isLoadingImage = false.obs;

  var listElement = [].obs;
  var typeForm = ''.obs;
  var titleForm = ''.obs;

  var isDevice = ''.obs;

  var singleDateView = ''.obs;
  var singleDateFilter = ''.obs;

  // directions
  var vehicleName = [].obs;
  var latLngNow = [].obs;
  var allTracking = [].obs;
  var tracking = [].obs;

  // vehicle
  var vehicleProfile = [].obs;
  var detailVehicle = [].obs;
  var justShowCar = false.obs;

  var firstHourFilter = 0.obs;
  var firstMinuteFilter = 0.obs;
  var lastHourFilter = 0.obs;
  var lastMinuteFilter = 0.obs;

  var userIdTeam = 0.obs;

  var latCurrentLocation = 0.0.obs;
  var lngCurrentLocation = 0.0.obs;

  // search
  var listCp = [].obs;
  var listCpSearch = [].obs;

  List latLngStopVehicle = [].obs;

  var mcVehicleStatuses = [].obs;
  var mcVehicleTrips = [].obs;
  var mcVehicleTripsDetail = [].obs;
  var mcVehicleDetail = [].obs;
  var mcOpenVehicleDetail = false.obs;
  var mcVehicleTripData = [].obs;
  var mcRouteLine = [].obs;
  var mcVehicleId = 0.obs;
  var mcMinimizeTripData = false.obs;
  var mcShowInfo = false.obs;

  late Timer timer;

  @override
  void onInit() {
    final box = GetStorage();

    if (box.read('dataUser') != null) {
      final data = box.read('dataUser') as Map<String, dynamic>;
      fullName.value = data['fullName'];
      role.value = data['role'];
      token.value = data['token'];
      gpsGroup.value = data['gpsGroup'];
    }

    if (role.value == '0') {
      roleString.value = 'Administrator';
    }

    typeForm.value = 'road_sweeper';
    // titleForm.value = Get.arguments['titleForm'];

    DateTime dateTimeNow = DateTime.now();
    singleDateFilter.value = DateFormat('yyyy-MM-dd').format(dateTimeNow);
    singleDateView.value = DateFormat("d MMMM y", "id_ID").format(dateTimeNow);
    filterDateC.text = singleDateView.value;

    pageCarouselController = PageController(viewportFraction: 0.9);

    getDeviceType();
    getDirectionRoute();
    getTaskGroupTeams();

    searchLocation('');

    super.onInit();
  }

  @override
  void onReady() {
    timer = Timer.periodic(
      const Duration(seconds: 10),
      (Timer t) => getCurrentLocation(),
    );
  }

  @override
  void onClose() {
    timer.cancel();
    super.onClose();
  }

  searchLocation(String text) {
    final Stream<QuerySnapshot<Object?>> location;
    if (typeForm.value == 'road_sweeper') {
      location = FirebaseProvider().locationCollectionRs.snapshots();
    } else {
      location = FirebaseProvider().locationCollectionMs.snapshots();
    }

    listCpSearch.clear();
    listCp.clear();

    DateTime now = DateTime.now();
    // tipe format tanggalnya ini jangan diubah
    String dayNow = DateFormat("EEEE", "en_US").format(now);

    location.forEach((e) {
      for (var element in e.docs) {
        String locationStart =
            element['location_start'].toString().toLowerCase();
        String locationEnd = element['location_end'].toString().toLowerCase();

        if (text.isEmpty) {
          listCp.add(element);
          if (typeForm.value == 'road_sweeper') {
            listCp.value =
                listCp.where((e) => e['name_days'] == dayNow).toList();
          }
        } else if (locationStart.contains(text.toLowerCase()) ||
            locationEnd.contains(text.toLowerCase())) {
          listCpSearch.add(element);
          if (typeForm.value == 'road_sweeper') {
            listCpSearch.value =
                listCpSearch.where((e) => e['name_days'] == dayNow).toList();
          }
        }
      }
    });
  }

  void changeFilterTypeForm(String name) {
    typeForm.value = name;
    refreshData();
  }

  Future<void> getCurrentLocation() async {
    var currentPosition = await locateUser();

    latCurrentLocation.value = currentPosition.latitude;
    lngCurrentLocation.value = currentPosition.longitude;
  }

  Future locateUser() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      SnackbarWidget()
          .getSnackbar('Alert!', 'Location services are disabled!', 'error');
      return;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        SnackbarWidget()
            .getSnackbar('Alert!', 'Location permission denied!', 'error');
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      SnackbarWidget().getSnackbar(
          'Alert!',
          'Location permission is permanently denied, we cannot request permission!',
          'error');
      return;
    }

    return await Geolocator.getCurrentPosition();
  }

  Future<void> pickedTimeFirstTime(context) async {
    TimeOfDay? pickedTime = await showTimePicker(
      initialTime: TimeOfDay.now(),
      context: context,
    );

    if (pickedTime != null) {
      firstHourFilter.value = pickedTime.hour;
      firstMinuteFilter.value = pickedTime.minute;

      firstTimeC.text =
          TimeConvertWidget().to24hours(pickedTime.hour, pickedTime.minute);
    }
  }

  Future<void> pickedTimeLastTime(context) async {
    TimeOfDay? pickedTime = await showTimePicker(
      initialTime: TimeOfDay.now(),
      context: context,
    );

    if (pickedTime != null) {
      lastHourFilter.value = pickedTime.hour;
      lastMinuteFilter.value = pickedTime.minute;

      lastTimeC.text =
          TimeConvertWidget().to24hours(pickedTime.hour, pickedTime.minute);
    }
  }

  void getDeviceType() {
    final data = MediaQueryData.fromView(WidgetsBinding.instance.window);
    if (data.size.shortestSide < 500) {
      isDevice.value = 'phone';
    } else if (data.size.shortestSide > 500) {
      isDevice.value = 'tv';
    } else {
      isDevice.value = 'tablet';
    }
  }

  // date single picker
  void selectionSingleDate(DateRangePickerSelectionChangedArgs args) {
    if (args.value is DateTime) {
      singleDateView.value = DateFormat("d MMMM y", "en_AU").format(args.value);
      singleDateFilter.value = DateFormat('yyyy-MM-dd').format(args.value);
    }
  }

  Widget getDateFilter() {
    return SizedBox(
      height: 350,
      width: 500,
      child: Card(
        elevation: 0,
        child: SfDateRangePicker(
          onSelectionChanged: selectionSingleDate,
          selectionMode: DateRangePickerSelectionMode.single,
          initialSelectedRange: null,
        ),
      ),
    );
  }

  void dialogPickerFilterDate(context) {
    DefaultDialogWidget().getDefaultDialog(
      context,
      'Select Date',
      getDateFilter(),
      () {
        singleDateFilter.value;
        singleDateView.value;
        filterDateC.text = singleDateView.value;
        Get.back();
      },
      'Save',
      HexColor(ColorWidget().primary),
      HexColor(ColorWidget().white),
      () {
        DateTime dateTimeNow = DateTime.now();
        singleDateFilter.value = DateFormat('yyyy-MM-dd').format(dateTimeNow);
        singleDateView.value =
            DateFormat("d MMMM y", "id_ID").format(dateTimeNow);
        filterDateC.text = singleDateView.value;
        Get.back();
      },
      'Cancel',
    );
  }

  Future<void> refreshData() async {
    listElement.clear();
    tracking.clear();
    listLatLng.clear();
    latLngFilter.clear();
    latLngStopVehicle.clear();
    mcVehicleTripData.clear();
    mcRouteLine.clear();
    mcVehicleId.value = 0;
    firstHourFilter.value = 0;
    firstMinuteFilter.value = 0;
    lastHourFilter.value = 0;
    lastMinuteFilter.value = 0;
    userIdTeam.value = 0;

    firstTimeC.text = '';
    lastTimeC.text = '';
    DateTime dateTimeNow = DateTime.now();
    singleDateFilter.value = DateFormat('yyyy-MM-dd').format(dateTimeNow);
    singleDateView.value = DateFormat("d MMMM y", "id_ID").format(dateTimeNow);
    filterDateC.text = singleDateView.value;

    justShowCar(false);
    detailVehicle.clear();
    searchC.text = '';
    searchLocation('');

    // routePoints = [const LatLng(-7.2875894, 112.632185)];

    // mapController.move(
    //   routePoints[0],
    //   15,
    // );
    getTaskGroupTeams();
    getDirectionRoute();
  }

  Future<void> getDirectionRoute() async {
    isLoading.value = true;
    try {
      List dataLatLng = [];
      if (typeForm.value == 'road_sweeper') {
        // road sweeper
        var data = await DailyTaskRsProvider().getDailyTask(token.value);
        dailyTask.value = data.toList();

        for (var element in dailyTask) {
          if (dailyTask.last.detailDailytaskId == element.detailDailytaskId) {
            dataLatLng.add({dailyTask.last.lngStart, dailyTask.last.latStart});
            dataLatLng
                .add({dailyTask.last.lngFinish, dailyTask.last.latFinish});
          } else {
            dataLatLng.add({element.lngStart, element.latStart});
          }
        }
      } else {
        // manual sweeper
        var data = await DailyTaskMsProvider().getDailyTask(token.value);
        dailyTaskMs.value = data.toList();

        for (var element in dailyTaskMs) {
          if (dailyTaskMs.last.detailDailytaskId == element.detailDailytaskId) {
            dataLatLng
                .add({dailyTaskMs.last.lngStart, dailyTaskMs.last.latStart});
            dataLatLng
                .add({dailyTaskMs.last.lngFinish, dailyTaskMs.last.latFinish});
          } else {
            dataLatLng.add({element.lngStart, element.latStart});
          }
        }
      }

      var stringList = dataLatLng.join(";");
      var removeObject =
          stringList.toString().replaceAll('{', '').replaceAll('}', '');
      var dataRoute =
          removeObject.toString().replaceAll(' ', '').replaceAll(' ', '');

      var responseDirections =
          await DirectionsProvider().getDirections(dataRoute);

      if (responseDirections.statusCode == 200) {
        routePoints = [];
        var ruter = jsonDecode(responseDirections.body)['routes'][0]['geometry']
            ['coordinates'];
        for (int i = 0; i < ruter.length; i++) {
          var reep = ruter[i].toString();
          reep = reep.replaceAll("[", "");
          reep = reep.replaceAll("]", "");
          var lat1 = reep.split(',');
          var long1 = reep.split(",");
          routePoints
              .add(LatLng(double.parse(lat1[1]), double.parse(long1[0])));
        }
      } else if (responseDirections.statusCode == 500) {
        refreshData();
        isLoading.value = false;
        WarningWidget().dialog('Please contact the administrator!');
      }
      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      print(e.toString());
      // SnackbarWidget()
      //     .getSnackbar('Something went wrong', '${e.toString}', 'error');
    }
  }

  Future<void> getTaskGroupTeams() async {
    isLoadingGroupTeams.value = true;
    try {
      if (typeForm.value == 'road_sweeper') {
        // road sweeper
        var data =
            await MonitoringScProvider().getTaskGroupTeamsRs(token.value);

        if (data.isNotEmpty) {
          taskGroupTeamsRs.value = data;
        }
      } else {
        // manual sweeper
        var data =
            await MonitoringScProvider().getTaskGroupTeamsMs(token.value);

        if (data.isNotEmpty) {
          taskGroupTeamsMs.value = data;
        }
      }
      isLoadingGroupTeams.value = false;
    } catch (e) {
      isLoadingGroupTeams.value = false;
    }
  }

  Future<void> submitDirections(form, name) async {
    final isValid = form.currentState.validate();
    if (!isValid) {
      return;
    }

    isLoading.value = true;

    tracking.value = allTracking.toList();
    var listFilterName = tracking.where((element) => element['name'] == name);

    // list route without vehicle name
    List listRoute = [];
    for (var element in listFilterName) {
      listRoute.add(element['route']);
    }

    if (listRoute.first == '' || listRoute.isEmpty || listRoute.first == null) {
      refreshData();
      isLoading.value = false;
      WarningWidget().dialog('There are no routes on this vehicle');
      return;
    }

    // list inside route / all inside tracking data
    List dataTracking = [];
    for (var element in listRoute) {
      element.forEach((key, value) {
        dataTracking.add(value);
      });
    }

    // where date
    List dataTrackingFilterDate = dataTracking
        .where(
          (element) =>
              DateFormat('yyyy-MM-dd')
                  .format(DateTime.parse(element['datetime'])) ==
              singleDateFilter.value,
        )
        .toList();

    if (dataTrackingFilterDate.isEmpty || dataTrackingFilterDate.first == '') {
      refreshData();
      isLoading.value = false;
      WarningWidget().dialog('There are no vehicle routes on that date');
      return;
    }

    for (int i = 0; i < dataTrackingFilterDate.length; i++) {
      listLatLng.add({
        'datetime': dataTrackingFilterDate[i]['datetime'],
        'lat': dataTrackingFilterDate[i]['lat'],
        'lng': dataTrackingFilterDate[i]['lng'],
      });
    }

    listLatLng.sort(
      (a, b) => DateFormat('hh:mm:ss')
          .format(DateTime.parse(a['datetime']))
          .compareTo(
            DateFormat('hh:mm:ss').format(
              DateTime.parse(b['datetime']),
            ),
          ),
    );

    routePoints = [];
    // List latLng = [];
    for (var element in listLatLng) {
      var elementTime =
          DateFormat('HH:mm:ss').format(DateTime.parse(element['datetime']));

      if (elementTime.compareTo(firstTimeC.text) > 0 &&
          elementTime.compareTo(lastTimeC.text) < 0) {
        // showing pin on map
        latLngFilter.add({
          'datetime': element['datetime'],
          'lng': element['lng'],
          'lat': element['lat'],
        });

        // show directions
        // latLng.add({
        //   element['lng'],
        //   element['lat'],
        // });
        routePoints.add(LatLng(element['lat'], element['lng']));
      }
    }

    animateMapMove(routePoints[0], 15);
    isLoading.value = false;

    // var stringList = latLng.join(";");
    // var removeObject =
    //     stringList.toString().replaceAll('{', '').replaceAll('}', '');
    // var dataDriving =
    //     removeObject.toString().replaceAll(' ', '').replaceAll(' ', '');

    // var responseDirections =
    //     await DirectionsProvider().getDirections(dataDriving);

    // if (responseDirections.statusCode == 200) {
    //   isLoading.value = false;
    //   routePoints = [];
    //   var ruter = jsonDecode(responseDirections.body)['routes'][0]['geometry']
    //       ['coordinates'];
    //   for (int i = 0; i < ruter.length; i++) {
    //     var reep = ruter[i].toString();
    //     reep = reep.replaceAll("[", "");
    //     reep = reep.replaceAll("]", "");
    //     var lat1 = reep.split(',');
    //     var long1 = reep.split(",");
    //     routePoints.add(LatLng(double.parse(lat1[1]), double.parse(long1[0])));
    //   }
    //   // refreshData();
    // } else if (responseDirections.statusCode == 400) {
    //   refreshData();
    //   isLoading.value = false;
    //   WarningWidget().dialog('There is no route at that time');
    //   return;
    // } else {
    //   refreshData();
    //   isLoading.value = false;
    //   WarningWidget()
    //       .dialog('The time is too long, please reduce the time period');
    //   return;
    // }
  }

  Future<void> submitFilterTeam(int userId) async {
    isLoading.value = true;

    try {
      userIdTeam.value = userId;

      try {
        List dataLatLng = [];
        if (typeForm.value == 'road_sweeper') {
          // road sweeper
          var data = await MonitoringScProvider()
              .getTaskWhereTeamsRs(token.value, userIdTeam.value);
          dailyTask.value = data.toList();

          for (var element in dailyTask) {
            if (dailyTask.last.detailDailytaskId == element.detailDailytaskId) {
              dataLatLng
                  .add({dailyTask.last.lngStart, dailyTask.last.latStart});
              dataLatLng
                  .add({dailyTask.last.lngFinish, dailyTask.last.latFinish});
            } else {
              dataLatLng.add({element.lngStart, element.latStart});
            }
          }
        } else {
          // manual sweeper
          var data = await MonitoringScProvider()
              .getTaskWhereTeamsMs(token.value, userIdTeam.value);
          dailyTaskMs.value = data.toList();

          for (var element in dailyTaskMs) {
            if (dailyTaskMs.last.detailDailytaskId ==
                element.detailDailytaskId) {
              dataLatLng
                  .add({dailyTaskMs.last.lngStart, dailyTaskMs.last.latStart});
              dataLatLng.add(
                  {dailyTaskMs.last.lngFinish, dailyTaskMs.last.latFinish});
            } else {
              dataLatLng.add({element.lngStart, element.latStart});
            }
          }
        }

        var stringList = dataLatLng.join(";");
        var removeObject =
            stringList.toString().replaceAll('{', '').replaceAll('}', '');
        var dataRoute =
            removeObject.toString().replaceAll(' ', '').replaceAll(' ', '');

        var responseDirections =
            await DirectionsProvider().getDirections(dataRoute);

        if (responseDirections.statusCode == 200) {
          routePoints = [];
          var ruter = jsonDecode(responseDirections.body)['routes'][0]
              ['geometry']['coordinates'];
          for (int i = 0; i < ruter.length; i++) {
            var reep = ruter[i].toString();
            reep = reep.replaceAll("[", "");
            reep = reep.replaceAll("]", "");
            var lat1 = reep.split(',');
            var long1 = reep.split(",");
            routePoints
                .add(LatLng(double.parse(lat1[1]), double.parse(long1[0])));
          }
        } else {
          refreshData();
          isLoading.value = false;
          WarningWidget().dialog('Please contact the administrator!');
        }
        isLoading.value = false;
      } catch (e) {
        isLoading.value = false;
        SnackbarWidget().getSnackbar(
            'Something went wrong', 'Please Reload this page ', 'error');
      }

      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      SnackbarWidget().getSnackbar(
          'Something went wrong', 'Please Reload this page ', 'error');
    }
  }

  void animateMapMove(LatLng destLocation, double destZoom) {
    final latTween = Tween<double>(
        begin: mapController.center.latitude, end: destLocation.latitude);
    final lngTween = Tween<double>(
        begin: mapController.center.longitude, end: destLocation.longitude);
    final zoomTween = Tween<double>(begin: mapController.zoom, end: destZoom);

    final controller = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
    final Animation<double> animation =
        CurvedAnimation(parent: controller, curve: Curves.fastOutSlowIn);

    controller.addListener(() {
      mapController.move(
          LatLng(latTween.evaluate(animation), lngTween.evaluate(animation)),
          zoomTween.evaluate(animation));
    });

    animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        controller.dispose();
      } else if (status == AnimationStatus.dismissed) {
        controller.dispose();
      }
    });

    controller.forward();
  }

  Stream getVehicle() {
    var location = FirebaseProvider().databaseReference.onValue;

    return location;
  }

  Stream<QuerySnapshot> locationRsStream() {
    final location = FirebaseProvider().locationCollectionRs.snapshots();

    return location;
  }

  Stream<QuerySnapshot> locationMsStream() {
    final location = FirebaseProvider().locationCollectionMs.snapshots();

    return location;
  }

  Future<void> getImage(transDtaId) async {
    attachmentList.clear();

    try {
      List<DataAttachmentScModel> data;
      if (typeForm.value == 'road_sweeper') {
        data = await AttachmentScProvider().getImageRs(token.value, transDtaId);
      } else {
        data = await AttachmentScProvider().getImageMs(token.value, transDtaId);
      }

      if (data.isNotEmpty) {
        attachmentList.value = data;
      }
      isLoadingImage.value = false;
    } catch (e) {
      isLoadingImage.value = false;
      ExpiredSessionC().dialog();
    }
  }

  void zoomInOut(String type) {
    var latitudePosition = mapController.camera.center.latitude;
    var longitudePosition = mapController.camera.center.longitude;
    var mapZoom = mapController.zoom;

    if (type == 'in') {
      mapController.move(
        LatLng(latitudePosition, longitudePosition),
        mapZoom + 0.2,
      );
    } else {
      mapController.move(
        LatLng(latitudePosition, longitudePosition),
        mapZoom - 0.2,
      );
    }
  }

  void gotoLocation(double lat, double long, double zoom) {
    animateMapMove(LatLng(lat - 0.0005, long), zoom);
  }
}
