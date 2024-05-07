import 'package:flutter/material.dart';
import 'package:food_diet_app/theme/light_color.dart';
import 'package:google_fonts/google_fonts.dart';

class TitleText extends StatelessWidget {
  final String? text;
  final double fontSize;
  final Color color;
  final FontWeight fontWeight;
  const TitleText(
      {this.text,
      this.fontSize = 18,
      this.color = LightColor.titleTextColor,
      this.fontWeight = FontWeight.w800});
  @override
  Widget build(BuildContext context) {
    return Text(text!,
        style: GoogleFonts.mulish(
            fontSize: fontSize, fontWeight: fontWeight, color: color));
  }
}
