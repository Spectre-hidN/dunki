import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class RoundedTextField extends StatelessWidget {
  final TextEditingController controller;
  final bool obscureText;
  final TextCapitalization textCapitalization;
  final String? hintText;
  final Icon? icon;
  final Function(String)? onChanged;
  final int? maxLines;
  final TextStyle? style;
  final TextInputType? keyboardType;
  final Color focusedColor;
  final Color borderColor;
  final Color fillColor;
  final bool expands;
  final List<TextInputFormatter>? inputFormatters;

  const RoundedTextField(
      {super.key,
      required this.controller,
      required this.obscureText,
      this.hintText,
      this.icon,
      this.onChanged,
      this.style = const TextStyle(
          color: Colors.black,
          fontFamily: "Satoshi",
          fontWeight: FontWeight.bold),
      this.keyboardType,
      this.inputFormatters,
      this.fillColor = Colors.white,
      this.maxLines = 1,
      this.focusedColor = const Color(0xFFFF6D1F),
      this.borderColor = Colors.white,
      this.expands = false,
      this.textCapitalization = TextCapitalization.none});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      textCapitalization: textCapitalization,
      keyboardType: keyboardType,
      onChanged: onChanged,
      inputFormatters: inputFormatters,
      style: style,
      expands: expands,
      maxLines: maxLines,
      decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: borderColor),
              borderRadius: const BorderRadius.all(Radius.circular(15.0))),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: focusedColor, width: 1.5),
              borderRadius: const BorderRadius.all(Radius.circular(10.0))),
          filled: true,
          fillColor: fillColor,
          hintText: hintText,
          hintStyle: const TextStyle(
              color: Color.fromARGB(255, 139, 139, 139), fontSize: 15.0),
          icon: icon),
      cursorColor: const Color(0xFFFF6D1F),
    );
  }
}
