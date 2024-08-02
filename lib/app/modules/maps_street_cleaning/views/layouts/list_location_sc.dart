import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';

import '../../../../widgets/color_widget.dart';
import '../../controllers/maps_street_cleaning_controller.dart';
import 'maps_sc.dart';

class ListLocationSc extends GetView<MapsStreetCleaningController> {
  const ListLocationSc({super.key});

  Widget listLocationRs() {
    return StreamBuilder<QuerySnapshot>(
      stream: controller.locationRsStream(),
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

          DateTime now = DateTime.now();
          String dayNow = DateFormat("EEEE", "en_AU").format(now);

          listData = listData
              .where((element) => element['name_days'] == dayNow)
              .toList();

          listData.sort(
            (a, b) => int.parse(a['sequence']).compareTo(
              int.parse(b['sequence']),
            ),
          );

          return MapsSc(
            data: listData,
          );
        } else {
          return Container();
        }
      },
    );
  }

  Widget listLocationMs() {
    return StreamBuilder<QuerySnapshot>(
      stream: controller.locationMsStream(),
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

          if (controller.userIdTeam.value != 0) {
            listData = listData
                .where((element) =>
                    element['user_id'] == controller.userIdTeam.value)
                .toList();
          }

          listData.sort(
            (a, b) => int.parse(a['sequence']).compareTo(
              int.parse(b['sequence']),
            ),
          );

          return MapsSc(
            data: listData,
          );
        } else {
          return Container();
        }
      },
    );
  }

  Widget vehicle(data) {
    return StreamBuilder(
      stream: controller.getVehicle(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
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
          DataSnapshot dataSnapshot = snapshot.data.snapshot;
          Map dataEsp = dataSnapshot.value as Map;

          controller.vehicleName.clear();
          controller.latLngNow.clear();
          controller.allTracking.clear();
          controller.vehicleProfile.clear();

          dataEsp.forEach((key, value) {
            if (value['lat'] != null && value['lat'] != '') {
              if (value['lat']['float'] != null &&
                  value['lat']['float'] != '') {
                controller.vehicleName.add(key);
                controller.latLngNow.add(
                  {'lat': value['lat']['float'], 'lng': value['lng']['float']},
                );
                controller.vehicleProfile.add(
                  value['profile'],
                );

                controller.allTracking.add({
                  'name': key,
                  'route': value['tracking'],
                });
              }
            }
          });

          return MapsSc(
            data: data,
            // vehicleName: controller.vehicleName,
            // latLngNow: controller.latLngNow,
            // vehicleProfile: controller.vehicleProfile,
          );
        } else {
          return Container();
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return controller.typeForm.value == 'road_sweeper'
        ? listLocationRs()
        : listLocationMs();
  }
}
