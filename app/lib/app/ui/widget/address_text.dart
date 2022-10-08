import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddressText extends StatelessWidget {
  const AddressText(this.address, {this.style, super.key});

  final String address;
  final TextStyle? style;

  Widget _buildSelectableDialog(BuildContext context) {
    return Center(
      child: Container(
        margin: const EdgeInsets.all(16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
        ),
        child: FittedBox(
          fit: BoxFit.cover,
          child: SelectableText(
            address,
            style: const TextStyle(fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () => Get.dialog(_buildSelectableDialog(context)),
      child: Text(
        address.length > 8
            ? '${address.substring(0, 4)}...'
                '${address.substring(address.length - 4, address.length)}'
            : address,
        style: style,
      ),
    );
  }
}
