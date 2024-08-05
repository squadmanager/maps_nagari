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
import 'package:maps_nagari/app/components/expired_session_c.dart';
import 'package:maps_nagari/app/data/providers/attachment_wc_provider.dart';
import 'package:maps_nagari/app/data/providers/directions_provider.dart';
import 'package:maps_nagari/app/data/providers/firebase_provider.dart';
import 'package:maps_nagari/app/widgets/color_widget.dart';
import 'package:maps_nagari/app/widgets/default_dialog_widget.dart';
import 'package:maps_nagari/app/widgets/warning_widget.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../../../data/models/attachment_daily_task_model.dart';
import '../../../widgets/snackbar_widget.dart';
import '../../../widgets/time_covert_widget.dart';

class MapsWasteCollectionsController extends GetxController
    with GetTickerProviderStateMixin {
  final formKey = GlobalKey<FormState>().obs;
  final TextEditingController filterDateC = TextEditingController();
  final TextEditingController firstTimeC = TextEditingController();
  final TextEditingController lastTimeC = TextEditingController();
  final TextEditingController searchC = TextEditingController();
  MapController mapController = MapController();
  late PageController pageCarouselController;

  final attachmentList = List<DataAttachmentDailyTaskModel>.empty().obs;
  List<LatLng> routePoints = [const LatLng(-0.9722283291919985, 116.70915419634736)].obs;
  List<Marker> markers = List.empty();
  List listLatLng = [].obs;
  List latLngFilter = [].obs;

  var isBackValue = ''.obs;

  var fullName = ''.obs;
  var role = ''.obs;
  var roleString = ''.obs;
  var token = ''.obs;
  var gpsGroup = ''.obs;

  var isLoading = false.obs;
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

  var latClick = 0.0.obs;
  var longClick = 0.0.obs;

  var latCurrentLocation = 0.0.obs;
  var lngCurrentLocation = 0.0.obs;

  // search
  var listCp = [].obs;
  var listCpSearch = [].obs;

  late Timer timer;

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

  @override
  void onInit() async {
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

    typeForm.value = 'dragonfly';
    // titleForm.value = Get.arguments['titleForm'];

    DateTime dateTimeNow = DateTime.now();
    singleDateFilter.value = DateFormat('yyyy-MM-dd').format(dateTimeNow);
    singleDateView.value = DateFormat("d MMMM y", "id_ID").format(dateTimeNow);
    filterDateC.text = singleDateView.value;

    pageCarouselController = PageController(viewportFraction: 0.9);

    getDeviceType();

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
    if (typeForm.value == 'dragonfly') {
      location = FirebaseProvider().locationCollectionDragonfly.snapshots();
    } else if (typeForm.value == 'compactor') {
      location = FirebaseProvider().locationCollectionCompactor.snapshots();
    } else {
      location = FirebaseProvider().locationCollectionPruning.snapshots();
    }

    listCpSearch.clear();
    listCp.clear();

    location.forEach((e) {
      for (var element in e.docs) {
        String locationTask = element['location_task'].toString().toLowerCase();

        if (text.isEmpty) {
          listCp.add(element);
        } else if (locationTask.contains(text.toLowerCase())) {
          listCpSearch.add(element);
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
    isLoading.value = true;
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

    firstTimeC.text = '';
    lastTimeC.text = '';
    DateTime dateTimeNow = DateTime.now();
    singleDateFilter.value = DateFormat('yyyy-MM-dd').format(dateTimeNow);
    singleDateView.value = DateFormat("d MMMM y", "id_ID").format(dateTimeNow);
    filterDateC.text = singleDateView.value;

    routePoints = [const LatLng(-7.2875894, 112.632185)];

    animateMapMove(routePoints[0], 15);
    justShowCar(false);
    detailVehicle.clear();
    searchC.text = '';
    searchLocation('');
    isLoading.value = false;
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

        routePoints.add(LatLng(element['lat'], element['lng']));
      }
    }

    animateMapMove(routePoints[0], 15);
    isLoading.value = false;
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

  Stream<QuerySnapshot> locationDragonflyStream() {
    final location = FirebaseProvider().locationCollectionDragonfly.snapshots();

    return location;
  }

  Stream<QuerySnapshot> locationCompactorStream() {
    final location = FirebaseProvider().locationCollectionCompactor.snapshots();

    return location;
  }

  Stream<QuerySnapshot> locationPruningStream() {
    final location = FirebaseProvider().locationCollectionPruning.snapshots();

    return location;
  }

  Future<void> getImage(transDtaId) async {
    attachmentList.clear();
    // isLoadingImage.value = true;
    if (typeForm.value == 'dragonfly') {
      try {
        var data =
            await AttachmentProvider().getImageWc(token.value, transDtaId);
        if (data.isNotEmpty) {
          attachmentList.value = data;
        }
        isLoadingImage.value = false;
      } catch (e) {
        isLoadingImage.value = false;
        ExpiredSessionC().dialog();
      }
    } else if (typeForm.value == 'compactor') {
      try {
        var data = await AttachmentProvider()
            .getImageCompactor(token.value, transDtaId);

        if (data.isNotEmpty) {
          attachmentList.value = data;
        }
        isLoadingImage.value = false;
      } catch (e) {
        isLoadingImage.value = false;
        ExpiredSessionC().dialog();
      }
    } else if (typeForm.value == 'pruning') {
      try {
        var data =
            await AttachmentProvider().getImagePruning(token.value, transDtaId);

        if (data.isNotEmpty) {
          attachmentList.value = data;
        }
        isLoadingImage.value = false;
      } catch (e) {
        isLoadingImage.value = false;
        ExpiredSessionC().dialog();
      }
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

  Future<void> getDirection() async {
    isLoading.value = true;
    listLatLng = [
      {
        'name': 'Route 1',
        'lng': '112.76381457621257',
        'lat': '-7.306988833124254',
        'color': ColorWidget().green,
      },
      {
        'name': 'Route 2',
        'lng': '112.77145170480537',
        'lat': '-7.300038143490509',
        'color': ColorWidget().blue,
      },
      {
        'name': 'Route 3',
        'lng': '112.78102292498491',
        'lat': '-7.293026930126244',
        'color': ColorWidget().red,
      },
    ];

    List latLng = [];
    for (var element in listLatLng) {
      latLng.add({
        element['lng'],
        element['lat'],
      });
    }

    var stringList = latLng.join(";");
    var removeObject =
        stringList.toString().replaceAll('{', '').replaceAll('}', '');
    var dataDriving =
        removeObject.toString().replaceAll(' ', '').replaceAll(' ', '');

    var responseDirections =
        await DirectionsProvider().getDirections(dataDriving);

    routePoints = [];
    var ruter = jsonDecode(responseDirections.body)['routes'][0]['geometry']
        ['coordinates'];
    for (int i = 0; i < ruter.length; i++) {
      var reep = ruter[i].toString();
      reep = reep.replaceAll("[", "");
      reep = reep.replaceAll("]", "");
      var lat1 = reep.split(',');
      var long1 = reep.split(",");
      routePoints.add(LatLng(double.parse(lat1[1]), double.parse(long1[0])));
    }
    isLoading.value = false;
  }
}
