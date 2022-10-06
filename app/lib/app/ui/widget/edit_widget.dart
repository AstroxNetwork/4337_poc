import 'package:app/app/info/app_theme.dart';
import 'package:flutter/material.dart';

class Edit extends StatefulWidget {
  const Edit({
    super.key,
    required this.width,
    required this.height,
    this.hintText = "",
    this.controller,
    this.autofocus = false,
    this.obscureText = false,
  });

  final double width;
  final double height;
  final String hintText;
  final TextEditingController? controller;
  final bool autofocus;
  final bool obscureText;

  @override
  State<Edit> createState() => _EditState();
}

class _EditState extends State<Edit> {
  @override
  void dispose() {
    widget.controller?.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: widget.height,
      decoration: const BoxDecoration(
        color: Color(0x80BFBFBF),
        borderRadius: BorderRadius.all(Radius.circular(28)),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(28)),
          boxShadow: [
            BoxShadow(
              color: appThemeData.scaffoldBackgroundColor,
              blurRadius: 10,
              blurStyle: BlurStyle.inner,
            )
          ],
        ),
        child: TextField(
          autofocus: widget.autofocus,
          controller: widget.controller,
          cursorColor: Colors.black,
          keyboardType: TextInputType.text,
          textAlign: TextAlign.left,
          maxLines: 1,
          style: const TextStyle(
            fontSize: 20,
          ),
          onChanged: (text) {},
          obscureText: widget.obscureText,
          decoration: InputDecoration(
            fillColor: Colors.white12,
            filled: true,
            hintText: widget.hintText,
            hintStyle: const TextStyle(
              fontSize: 20,
              color: Color(0xFFB7B7B7),
              fontStyle: FontStyle.italic,
            ),
            border: _getBorder(false),
            focusedBorder: _getBorder(true),
            disabledBorder: _getBorder(false),
            enabledBorder: _getBorder(false),
            contentPadding:
                const EdgeInsets.only(left: 25, top: 16, right: 24, bottom: 15),
          ),
        ),
      ),
    );
  }

  OutlineInputBorder _getBorder(bool isEdit) {
    return OutlineInputBorder(
      borderRadius: const BorderRadius.all(Radius.circular(28)),
      borderSide: BorderSide(
        color: isEdit ? const Color(0xFF979797) : const Color(0xFF979797),
        width: 1,
      ),
    );
  }
}
