import 'package:app/app/base/get/getx_controller_inject.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

abstract class GetCommonView<T extends BaseGetController>
    extends StatefulWidget {
  const GetCommonView({Key? key}) : super(key: key);

  final String? tag = null;

  T get controller => GetInstance().find<T>(tag: tag);

  Object? get updateId => null;

  @protected
  Widget build(BuildContext context);

  @override
  AutoDisposeState createState() => AutoDisposeState<T>();
}

class AutoDisposeState<S extends GetxController> extends State<GetCommonView> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<S>(
      id: widget.updateId,
      builder: (controller) => widget.build(context),
    );
  }
}
