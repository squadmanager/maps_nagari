import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../../../widgets/color_widget.dart';
import '../../controllers/maps_waste_collections_controller.dart';
import 'maps_widget.dart';

class ListLocationWidget extends GetView<MapsWasteCollectionsController> {
  const ListLocationWidget({super.key});

  // dragonfly
  Widget listLocationDragonfly() {
    return StreamBuilder<QuerySnapshot>(
      stream: controller.locationDragonflyStream(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text(
            'Something went wrong',
            style: GoogleFonts.poppins(
              fontSize: 15.0,
              fontWeight: FontWeight.w600,
              color: HexColor(ColorWidget().black),
            ),
          );
        }

        // if (snapshot.connectionState == ConnectionState.waiting) {
        //   return const Center(
        //     child: CupertinoActivityIndicator(),
        //   );
        // }

        if (snapshot.hasData) {
          List listData = snapshot.data!.docs;

          return MapsWidget(
            data: listData,
          );
        } else {
          return Container();
        }
      },
    );
  }

  // compactor
  Widget listLocationCompactor() {
    return StreamBuilder<QuerySnapshot>(
      stream: controller.locationCompactorStream(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text(
            'Something went wrong',
            style: GoogleFonts.poppins(
              fontSize: 15.0,
              fontWeight: FontWeight.w600,
              color: HexColor(ColorWidget().black),
            ),
          );
        }

        if (snapshot.hasData) {
          List listData = snapshot.data!.docs;

          return MapsWidget(
            data: listData,
          );
        } else {
          return Container();
        }
      },
    );
  }

  // pruning
  Widget listLocationPruning() {
    return StreamBuilder<QuerySnapshot>(
      stream: controller.locationPruningStream(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text(
            'Something went wrong',
            style: GoogleFonts.poppins(
              fontSize: 15.0,
              fontWeight: FontWeight.w600,
              color: HexColor(ColorWidget().black),
            ),
          );
        }

        if (snapshot.hasData) {
          List listData = snapshot.data!.docs;

          return MapsWidget(
            data: listData,
          );
        } else {
          return Container();
        }
      },
    );
  }

  // Widget vehicle(data) {
  //   return StreamBuilder(
  //     stream: controller.getVehicle(),
  //     builder: (BuildContext context, AsyncSnapshot snapshot) {
  //       if (snapshot.hasError) {
  //         return Text(
  //           'Something went wrong',
  //           style: GoogleFonts.poppins(
  //             fontSize: 15.0,
  //             fontWeight: FontWeight.w600,
  //             color: HexColor(ColorWidget().black),
  //           ),
  //         );
  //       }

  //       if (snapshot.hasData) {
  //         DataSnapshot dataSnapshot = snapshot.data.snapshot;
  //         Map dataEsp = dataSnapshot.value as Map;

  //         controller.vehicleName.clear();
  //         controller.latLngNow.clear();
  //         controller.allTracking.clear();
  //         controller.vehicleProfile.clear();

  //         dataEsp.forEach((key, value) {
  //           if (value['lat'] != null && value['lat'] != '') {
  //             if (value['lat']['float'] != null &&
  //                 value['lat']['float'] != '') {
  //               controller.vehicleName.add(key);
  //               controller.latLngNow.add(
  //                 {'lat': value['lat']['float'], 'lng': value['lng']['float']},
  //               );
  //               controller.vehicleProfile.add(
  //                 value['profile'],
  //               );

  //               controller.allTracking.add({
  //                 'name': key,
  //                 'route': value['tracking'],
  //               });
  //             }
  //           }
  //         });

  //         return MapsWidget(
  //           data: data,
  //           // vehicleName: controller.vehicleName,
  //           // latLngNow: controller.latLngNow,
  //           // vehicleProfile: controller.vehicleProfile,
  //         );
  //       } else {
  //         return Container();
  //       }
  //     },
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => controller.typeForm.value == 'dragonfly'
          ? listLocationDragonfly()
          : controller.typeForm.value == 'compactor'
              ? listLocationCompactor()
              : listLocationPruning(),
    );
  }
}
