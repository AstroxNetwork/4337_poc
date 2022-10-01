import 'package:app/app/base/get/getx_controller_inject.dart';
import 'package:app/app/model/guardian_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GuardiansController extends BaseGetController {
  late RxList<GuardianModel> datas = <GuardianModel>[].obs;

  TextEditingController nameController = TextEditingController(text: '');

  TextEditingController addressController = TextEditingController(text: '');

  @override
  void onInit() {
    super.onInit();
    datas.value = [
      GuardianModel(
        name: 'Sean',
        address: '0x6b5cf860506c6291711478F54123312066946b0',
      ),
      GuardianModel(
        name: 'Yin',
        address: '0x6b5cf860506c6291711478F54123312066946b0',
      ),
      GuardianModel(
        name: 'King',
        address: '0x6b5cf860506c6291711478F54123312066946b0',
      ),
      GuardianModel(
        name: 'Tony',
        address: '0x6b5cf860506c6291711478F54123312066946b0',
      ),
      GuardianModel(
        name: 'Tony',
        address: '0x6b5cf860506c6291711478F54123312066946b0',
      ),
      GuardianModel(
        name: 'Tony',
        address: '0x6b5cf860506c6291711478F54123312066946b0',
      ),
      GuardianModel(
        name: 'Tony',
        address: '0x6b5cf860506c6291711478F54123312066946b0',
      ),
      GuardianModel(
        name: 'Tony',
        address: '0x6b5cf860506c6291711478F54123312066946b0',
      ),
      GuardianModel(
        name: 'Tony',
        address: '0x6b5cf860506c6291711478F54123312066946b0',
      ),
      GuardianModel(
        name: 'Tony',
        address: '0x6b5cf860506c6291711478F54123312066946b0',
      ),
    ];
  }

  void addGuardian() {
    datas.add(
      GuardianModel(
        name: nameController.text,
        address: addressController.text,
      ),
    );
  }
}
