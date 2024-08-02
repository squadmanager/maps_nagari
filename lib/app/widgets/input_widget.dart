import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:maps_nagari/app/widgets/color_widget.dart';

class InputWidget extends StatelessWidget {
  final title;
  final hintText;
  final messageError;
  final controllerText;
  final prefixIcon;
  final obscureText;
  final suffixIcon;
  final onChange;
  final bool textRequired;
  final bool readOnly;
  final VoidCallback onTap;
  final maxLines;
  final keyboardType;
  final double paddingVertical;
  final fillColor;
  final inputFormatters;

  InputWidget(
      {this.title,
      required this.controllerText,
      required this.hintText,
      required this.messageError,
      required this.prefixIcon,
      required this.obscureText,
      this.suffixIcon,
      this.onChange,
      required this.textRequired,
      this.readOnly = false,
      required this.onTap,
      required this.maxLines,
      this.keyboardType,
      required this.paddingVertical,
      this.fillColor,
      this.inputFormatters,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        if (title != null) ...[
          Text(
            '${title}',
            style: GoogleFonts.poppins(
              fontSize: 15.0,
              fontWeight: FontWeight.w400,
              color: HexColor(ColorWidget().black),
            ),
          ),
          const SizedBox(
            height: 5.0,
          ),
        ],
        TextFormField(
          inputFormatters: inputFormatters,
          controller: controllerText,
          obscureText: obscureText,
          style: GoogleFonts.poppins(
            fontSize: 15.0,
            fontWeight: FontWeight.w400,
            color: HexColor(ColorWidget().black),
          ),
          validator: (text) {
            if (textRequired) {
              if (text == null || text.isEmpty) {
                return '${messageError}';
              }
              return null;
            }
            return null;
          },
          onChanged: onChange,
          readOnly: readOnly,
          onTap: onTap,
          maxLines: maxLines,
          keyboardType: keyboardType,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(
              vertical: paddingVertical,
              horizontal: 10,
            ),
            prefixIcon: prefixIcon,
            suffixIcon: suffixIcon,
            hintText: '${hintText}',
            hintStyle: GoogleFonts.poppins(
              color: HexColor(ColorWidget().grey),
            ),
            fillColor: fillColor ?? HexColor(ColorWidget().background),
            filled: true,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide(
                color: HexColor(ColorWidget().background),
                width: 1,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: const BorderRadius.all(
                Radius.circular(10.0),
              ),
              borderSide: BorderSide(
                color: HexColor(ColorWidget().primary),
                width: 1,
              ),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: const BorderRadius.all(
                Radius.circular(10.0),
              ),
              borderSide: BorderSide(
                color: HexColor(ColorWidget().red),
                width: 1,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: const BorderRadius.all(
                Radius.circular(10.0),
              ),
              borderSide: BorderSide(
                color: HexColor(ColorWidget().red),
                width: 1,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
