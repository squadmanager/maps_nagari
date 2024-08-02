import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:maps_nagari/app/widgets/color_widget.dart';

class PhotoViewWidget extends StatelessWidget {
  final String image;
  const PhotoViewWidget({required this.image, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: HexColor(ColorWidget().white),
        leading: IconButton(
          splashRadius: 20.0,
          onPressed: () => Get.back(),
          icon: SvgPicture.asset(
            'assets/icons/arrow-left.svg',
            color: HexColor(ColorWidget().black),
            height: 24,
            width: 24,
          ),
        ),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            Image.network(
              image,
              width: Get.width,
              height: Get.height,
              loadingBuilder: (BuildContext context, Widget child,
                  ImageChunkEvent? loadingProgress) {
                if (loadingProgress == null) {
                  return child;
                }
                return Align(
                  alignment: Alignment.centerLeft,
                  child: CircularProgressIndicator(
                    value: loadingProgress.expectedTotalBytes != null
                        ? loadingProgress.cumulativeBytesLoaded /
                            loadingProgress.expectedTotalBytes!
                        : null,
                  ),
                );
              },
            ),
            // PhotoView(
            //   imageProvider: NetworkImage('$image'),
            //   enableRotation: true,
            // ),
          ],
        ),
      ),
    );
  }
}
