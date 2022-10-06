import 'package:app/app/base/get/getx_controller_inject.dart';
import 'package:app/app/util/toast_util.dart';
import 'package:app/eip4337lib/utils/log_utils.dart';
import 'package:get/get.dart';
import 'package:flutter/cupertino.dart';

abstract class GetCommonView<T extends BaseGetController> extends StatefulWidget {
  const GetCommonView({Key? key}) : super(key: key);

  final String? tag = null;

  T get controller => GetInstance().find<T>(tag: tag);

  get updateId => null;

  @protected
  Widget build(BuildContext context);

  @override
  AutoDisposeState createState() => AutoDisposeState<T>();
}

class AutoDisposeState<S extends GetxController> extends State<GetCommonView> {
  AutoDisposeState();
  
  OverlayEntry? loadingEntry;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<S>(
      id: widget.updateId,
      builder: (controller) {
        return widget.build(context);
      },
    );
  }


  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    // Get.delete<S>();
    super.dispose();
  }
}
