import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

import 'color_widget.dart';

class CardNoElevationWidget extends StatelessWidget {
  final HexColor backgroundColor;
  final borderRadiusCircular;
  final VoidCallback onTap;
  final VoidCallback onLongPress;
  final String title;
  final Widget widgetLeftTop;
  final Widget widgetLeft;
  final Widget widgetRight;
  final Widget widgetBottom;
  const CardNoElevationWidget(
      {required this.backgroundColor,
      this.borderRadiusCircular,
      required this.onTap,
      required this.onLongPress,
      required this.title,
      required this.widgetLeftTop,
      required this.widgetLeft,
      required this.widgetRight,
      required this.widgetBottom,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: backgroundColor,
      borderRadius: BorderRadius.circular(borderRadiusCircular ?? 0),
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: InkWell(
          borderRadius: BorderRadius.circular(borderRadiusCircular ?? 0),
          onTap: onTap,
          onLongPress: onLongPress,
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          widgetLeftTop,
                          Text(
                            title,
                            style: GoogleFonts.poppins(
                              fontSize: 14.0,
                              fontWeight: FontWeight.w600,
                              color: HexColor(ColorWidget().black),
                            ),
                          ),
                          widgetLeft,
                        ],
                      ),
                    ),
                    widgetRight,
                  ],
                ),
                widgetBottom,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
