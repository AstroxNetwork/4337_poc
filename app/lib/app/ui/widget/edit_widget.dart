import 'package:app/app/info/app_theme.dart';
import 'package:flutter/material.dart';

class Edit extends StatefulWidget {
  double width;
  double height;
  String hintText;
  TextEditingController controller;
  bool obscureText;

  Edit(
      {super.key,
      required this.width,
      required this.height,
      this.hintText = "",
      required this.controller,
      this.obscureText = false});

  @override
  State<Edit> createState() => _EditState();
}

class _EditState extends State<Edit> {
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
            ]),
        child: TextField(
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

  @override
  void dispose() {
    super.dispose();
    widget.controller.clear();
  }
}
