// import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:image_network/image_network.dart';
import 'package:intl/intl.dart';
import 'package:maps_nagari/app/modules/maps_street_cleaning/controllers/maps_street_cleaning_controller.dart';

import '../../../../components/app_scroll_behavior.dart';
import '../../../../widgets/color_widget.dart';
import '../../../../widgets/detail_widget.dart';

class DetailPinSc extends GetView<MapsStreetCleaningController> {
  final element;
  const DetailPinSc({required this.element, super.key});

  // Widget listImage(context) {
  //   // return FlutterCarousel(
  //   //   options: CarouselOptions(
  //   //     height: Get.height,
  //   //     autoPlay: true,
  //   //     aspectRatio: 50,
  //   //     enlargeCenterPage: true,
  //   //     enlargeStrategy: CenterPageEnlargeStrategy.scale,
  //   //   ),
  //   //   items: [
  //   //     for (int i = 0; i < controller.attachmentList.length; i++)
  //   //       Container(
  //   //         margin: const EdgeInsets.all(5.0),
  //   //         child: ClipRRect(
  //   //           borderRadius: const BorderRadius.all(Radius.circular(5.0)),
  //   //           child: InkWell(
  //   //             onTap: () {
  //   //               Navigator.push(
  //   //                 context,
  //   //                 MaterialPageRoute(
  //   //                   builder: (context) => PhotoViewWidget(
  //   //                     image: controller.attachmentList[i].url,
  //   //                   ),
  //   //                 ),
  //   //               );
  //   //             },
  //   //             child: Stack(
  //   //               children: [
  //   //                 Image.network(
  //   //                   controller.attachmentList[i].url,
  //   //                   fit: BoxFit.cover,
  //   //                   width: 1000.0,
  //   //                   loadingBuilder: (BuildContext context, Widget child,
  //   //                       ImageChunkEvent? loadingProgress) {
  //   //                     if (loadingProgress == null) {
  //   //                       return child;
  //   //                     }
  //   //                     return Center(
  //   //                       child: CircularProgressIndicator(
  //   //                         value: loadingProgress.expectedTotalBytes != null
  //   //                             ? loadingProgress.cumulativeBytesLoaded /
  //   //                                 loadingProgress.expectedTotalBytes!
  //   //                             : null,
  //   //                       ),
  //   //                     );
  //   //                   },
  //   //                 ),
  //   //                 Positioned(
  //   //                   bottom: 0.0,
  //   //                   left: 0.0,
  //   //                   right: 0.0,
  //   //                   child: Container(
  //   //                     decoration: const BoxDecoration(
  //   //                       gradient: LinearGradient(
  //   //                         colors: [
  //   //                           Color.fromARGB(200, 0, 0, 0),
  //   //                           Color.fromARGB(0, 0, 0, 0)
  //   //                         ],
  //   //                         begin: Alignment.bottomCenter,
  //   //                         end: Alignment.topCenter,
  //   //                       ),
  //   //                     ),
  //   //                     padding: const EdgeInsets.symmetric(
  //   //                         vertical: 10.0, horizontal: 20.0),
  //   //                     child: Column(
  //   //                       crossAxisAlignment: CrossAxisAlignment.start,
  //   //                       children: [
  //   //                         Text(
  //   //                           'Image ${i + 1}',
  //   //                           style: GoogleFonts.poppins(
  //   //                             fontSize: 20.0,
  //   //                             fontWeight: FontWeight.bold,
  //   //                             color: HexColor(ColorWidget().primarySC),
  //   //                           ),
  //   //                         ),
  //   //                         Text(
  //   //                           'Created : ${DateFormat("d MMMM y hh:mm", "id_ID").format(
  //   //                             controller.attachmentList[i].createdAt,
  //   //                           )}',
  //   //                           style: GoogleFonts.poppins(
  //   //                             fontSize: 12.0,
  //   //                             fontWeight: FontWeight.normal,
  //   //                             color: HexColor(ColorWidget().primarySC),
  //   //                           ),
  //   //                         ),
  //   //                       ],
  //   //                     ),
  //   //                   ),
  //   //                 ),
  //   //               ],
  //   //             ),
  //   //           ),
  //   //         ),
  //   //       ),
  //   //   ],
  //   // );
  //   return CarouselSlider(
  //     options: CarouselOptions(
  //       autoPlay: true,
  //       aspectRatio: 50,
  //       enlargeCenterPage: true,
  //       enlargeStrategy: CenterPageEnlargeStrategy.zoom,
  //     ),
  //     items: [
  //       for (int i = 0; i < controller.attachmentList.length; i++)
  //         Container(
  //           margin: const EdgeInsets.all(5.0),
  //           child: ClipRRect(
  //             borderRadius: const BorderRadius.all(Radius.circular(5.0)),
  //             child: InkWell(
  //               onTap: () {
  //                 Navigator.push(
  //                   context,
  //                   MaterialPageRoute(
  //                     builder: (context) => PhotoViewWidget(
  //                       image: controller.attachmentList[i].url,
  //                     ),
  //                   ),
  //                 );
  //               },
  //               child: Stack(
  //                 children: [
  //                   Image.network(
  //                     controller.attachmentList[i].url,
  //                     fit: BoxFit.cover,
  //                     width: 1000.0,
  //                     loadingBuilder: (BuildContext context, Widget child,
  //                         ImageChunkEvent? loadingProgress) {
  //                       if (loadingProgress == null) {
  //                         return child;
  //                       }
  //                       return Center(
  //                         child: CircularProgressIndicator(
  //                           value: loadingProgress.expectedTotalBytes != null
  //                               ? loadingProgress.cumulativeBytesLoaded /
  //                                   loadingProgress.expectedTotalBytes!
  //                               : null,
  //                         ),
  //                       );
  //                     },
  //                   ),
  //                   Positioned(
  //                     bottom: 0.0,
  //                     left: 0.0,
  //                     right: 0.0,
  //                     child: Container(
  //                       decoration: const BoxDecoration(
  //                         gradient: LinearGradient(
  //                           colors: [
  //                             Color.fromARGB(200, 0, 0, 0),
  //                             Color.fromARGB(0, 0, 0, 0)
  //                           ],
  //                           begin: Alignment.bottomCenter,
  //                           end: Alignment.topCenter,
  //                         ),
  //                       ),
  //                       padding: const EdgeInsets.symmetric(
  //                           vertical: 10.0, horizontal: 20.0),
  //                       child: Column(
  //                         crossAxisAlignment: CrossAxisAlignment.start,
  //                         children: [
  //                           Text(
  //                             'Image ${i + 1}',
  //                             style: GoogleFonts.poppins(
  //                               fontSize: 20.0,
  //                               fontWeight: FontWeight.bold,
  //                               color: HexColor(ColorWidget().primarySC),
  //                             ),
  //                           ),
  //                           Text(
  //                             'Created : ${DateFormat("d MMMM y hh:mm", "id_ID").format(
  //                               controller.attachmentList[i].createdAt,
  //                             )}',
  //                             style: GoogleFonts.poppins(
  //                               fontSize: 12.0,
  //                               fontWeight: FontWeight.normal,
  //                               color: HexColor(ColorWidget().primarySC),
  //                             ),
  //                           ),
  //                         ],
  //                       ),
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //             ),
  //           ),
  //         ),
  //     ],
  //   );
  // }

  Widget listImage(context) {
    return MaterialApp(
      scrollBehavior: AppScrollBehavior(),
      home: PageView.builder(
        itemCount: controller.attachmentList.length,
        pageSnapping: true,
        controller: controller.pageCarouselController,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, i) {
          return Container(
            margin: const EdgeInsets.all(5.0),
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(5.0)),
              child: InkWell(
                onTap: () {},
                child: Stack(
                  children: [
                    ImageNetwork(
                      image: controller.attachmentList[i].url,
                      width: 500.0,
                      height: 500.0,
                      fullScreen: true,
                      // onTap: () {
                      //   Get.defaultDialog(
                      //     title: 'Image ${i + 1}',
                      //     content: SizedBox(
                      //       width: Get.width / 1.5,
                      //       height: Get.height / 1.5,
                      //       child: PhotoView(
                      //         imageProvider: NetworkImage(
                      //           controller.attachmentList[i].url,
                      //         ),
                      //         enableRotation: true,
                      //       ),
                      //     ),
                      //   );
                      // },
                    ),
                    // Image.network(
                    //   controller.attachmentList[i].url,
                    //   fit: BoxFit.cover,
                    //   width: 1000.0,
                    //   loadingBuilder: (BuildContext context, Widget child,
                    //       ImageChunkEvent? loadingProgress) {
                    //     if (loadingProgress == null) {
                    //       return child;
                    //     }
                    //     return Center(
                    //       child: CircularProgressIndicator(
                    //         value: loadingProgress.expectedTotalBytes != null
                    //             ? loadingProgress.cumulativeBytesLoaded /
                    //                 loadingProgress.expectedTotalBytes!
                    //             : null,
                    //       ),
                    //     );
                    //   },
                    // ),
                    Positioned(
                      bottom: 0.0,
                      left: 0.0,
                      right: 0.0,
                      child: Container(
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Color.fromARGB(200, 0, 0, 0),
                              Color.fromARGB(0, 0, 0, 0)
                            ],
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                          ),
                        ),
                        padding: const EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            DefaultTextStyle(
                              style: GoogleFonts.poppins(
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                                color: HexColor(ColorWidget().primarySC),
                              ),
                              child: Text(
                                'Image ${i + 1}',
                              ),
                            ),
                            DefaultTextStyle(
                              style: GoogleFonts.poppins(
                                fontSize: 12.0,
                                fontWeight: FontWeight.normal,
                                color: HexColor(ColorWidget().primarySC),
                              ),
                              child: Text(
                                'Created : ${DateFormat("d MMMM y hh:mm", "id_ID").format(
                                  controller.attachmentList[i].createdAt,
                                )}',
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.topRight,
                child: InkWell(
                  onTap: () {
                    controller.listElement.clear();
                  },
                  child: SvgPicture.asset(
                    'assets/icons/times-circle.svg',
                    color: HexColor(ColorWidget().red),
                    fit: BoxFit.scaleDown,
                  ),
                ),
              ),
              const SizedBox(
                height: 10.0,
              ),
              if (controller.attachmentList.isNotEmpty) ...[
                Expanded(
                  child: listImage(context),
                ),
              ] else ...[
                Expanded(
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: HexColor(ColorWidget().grey),
                    ),
                  ),
                ),
              ],
              const SizedBox(
                height: 10.0,
              ),
              DetailWidget(
                title: 'Location Name',
                isStatus: false,
                textContent: '${element[0]['userAssigment']}',
              ),
              const SizedBox(
                height: 10.0,
              ),
              DetailWidget(
                title: 'Team',
                isStatus: false,
                textContent: '${element[0]['taskName']}',
              ),
              const SizedBox(
                height: 10.0,
              ),
              DetailWidget(
                title: 'Status',
                isStatus: true,
                colorBackgroundStatus: element[0]['status'] == '0'
                    ? HexColor(ColorWidget().yellow)
                    : element[0]['status'] == '1'
                        ? HexColor(ColorWidget().green)
                        : HexColor(ColorWidget().grey),
                colorTextStatus: HexColor(ColorWidget().white),
                textContent: element[0]['status'] == '0'
                    ? 'Draft'
                    : element[0]['status'] == '1'
                        ? 'Complete Task'
                        : 'In Progress',
              ),
            ],
          ),
        ),
        // height: double.infinity,
      ),
    );
  }
}
