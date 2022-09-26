import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BaseDialog extends StatelessWidget {
  Widget child;

  BaseDialog({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Center(
        child: Container(
          child: child,
        ),
      ),
    );
  }
}
