import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:maps_nagari/app/widgets/color_widget.dart';

class DetailWidget extends StatelessWidget {
  final String title;
  final bool isStatus;
  final colorBackgroundStatus;
  final colorTextStatus;
  final String textContent;
  const DetailWidget(
      {required this.title,
      required this.isStatus,
      this.colorBackgroundStatus,
      this.colorTextStatus,
      required this.textContent,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: GoogleFonts.poppins(
            fontSize: 15.0,
            fontWeight: FontWeight.w600,
            color: HexColor(
              ColorWidget().black,
            ),
          ),
        ),
        const SizedBox(
          height: 5.0,
        ),
        Row(
          children: [
            isStatus
                ? Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.0),
                      color: colorBackgroundStatus,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Text(
                        textContent,
                        style: GoogleFonts.poppins(
                          fontSize: 12.0,
                          fontWeight: FontWeight.w500,
                          color: colorTextStatus,
                        ),
                      ),
                    ),
                  )
                : Expanded(
                    child: Text(
                      textContent,
                      style: GoogleFonts.poppins(
                        fontSize: 12.0,
                        fontWeight: FontWeight.w500,
                        color: HexColor(ColorWidget().grey),
                      ),
                    ),
                  ),
          ],
        )
      ],
    );
  }
}
