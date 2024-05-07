import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BuildListTiles extends StatelessWidget {
  const BuildListTiles({
    super.key,
    required this.title,
    this.leadingIcon,
    this.trailingIcon,
    required this.onPressed,
  });

  final String title;

  final IconData? leadingIcon;
  final IconData? trailingIcon;
  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        title,
      ),
      leading: Icon(leadingIcon),
      trailing: Icon(trailingIcon),
      onTap: onPressed,
    );
  }
}
