import 'package:flutter/material.dart';

class AddressText extends StatelessWidget {
  const AddressText(this.address, {this.style, super.key});

  final String address;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    return Text(
      address.length > 8
          ? '${address.substring(0, 4)}...'
              '${address.substring(address.length - 4, address.length)}'
          : address,
      style: style,
    );
  }
}
