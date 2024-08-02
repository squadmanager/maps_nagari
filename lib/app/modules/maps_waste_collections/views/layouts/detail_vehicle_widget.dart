import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:maps_nagari/app/modules/maps_waste_collections/controllers/maps_waste_collections_controller.dart';
import 'package:maps_nagari/app/widgets/color_widget.dart';
import 'package:maps_nagari/app/widgets/detail_widget.dart';
import 'package:maps_nagari/app/widgets/photo_view_widget.dart';

class DetailVehicleWidget extends GetView<MapsWasteCollectionsController> {
  final element;
  const DetailVehicleWidget({required this.element, super.key});

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
                    controller.detailVehicle.clear();
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
              Expanded(
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PhotoViewWidget(
                          image: element[0]['images'],
                        ),
                      ),
                    );
                  },
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      // color: HexColor(themeC.grey.value),
                    ),
                    child: Image.network(
                      element[0]['images'],
                      loadingBuilder: (BuildContext context, Widget child,
                          ImageChunkEvent? loadingProgress) {
                        if (loadingProgress == null) {
                          return child;
                        }
                        return Center(
                          child: CircularProgressIndicator(
                            value: loadingProgress.expectedTotalBytes != null
                                ? loadingProgress.cumulativeBytesLoaded /
                                    loadingProgress.expectedTotalBytes!
                                : null,
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10.0,
              ),
              DetailWidget(
                title: 'Name',
                isStatus: false,
                textContent: element[0]['name'],
              ),
              const SizedBox(
                height: 10.0,
              ),
              DetailWidget(
                title: 'Police Number',
                isStatus: false,
                textContent: element[0]['nopol'],
              ),
            ],
          ),
        ),
        // height: double.infinity,
      ),
    );
  }
}
