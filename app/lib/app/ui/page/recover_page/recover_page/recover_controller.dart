import 'package:app/app/base/get/getx_controller_inject.dart';
import 'package:app/app/model/guardian_model.dart';

class RecoverController extends BaseGetController {
  List<GuardianModel> selectedData = [];

  List<GuardianModel> allData = [
    GuardianModel(
      name: 'Bob',
      address: '0x6b5cf860506c6291711478F54123312066946b0',
    ),
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

  toggleCheck(GuardianModel model) {
    if (selectedData.contains(model)) {
      selectedData.remove(model);
    } else {
      selectedData.add(model);
    }
    update();
  }
}
