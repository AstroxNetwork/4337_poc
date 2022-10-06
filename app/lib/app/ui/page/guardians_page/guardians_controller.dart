import 'package:app/app/base/get/getx_controller_inject.dart';
import 'package:app/app/model/guardian_model.dart';
import 'package:app/app/util/toast_util.dart';
import 'package:app/eip4337lib/context/context.dart';
import 'package:app/eip4337lib/utils/log_utils.dart';
import 'package:app/net/dio_utils.dart';
import 'package:app/net/http_api.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:localstorage/localstorage.dart';

class GuardiansController extends BaseGetController {

  static final String KEY_ADDED_GUARDIANS = 'added_guardians';
  static final String KEY_GUARDIAN_NAME_MAP = 'guardian_name_map';
  LocalStorage? storage;

  late RxList<GuardianModel> datas = <GuardianModel>[].obs;

  late List<GuardianModel> addedGuardian = <GuardianModel>[];
  late List<GuardianModel> realGuardians = <GuardianModel>[];
  late Map<String, dynamic> guardianNameMapping = {};

  bool isAdding = false;

  // late List<String> guardians = <String>[];

  TextEditingController nameController = TextEditingController(text: '');
  TextEditingController addressController = TextEditingController(text: '');

  @override
  void onInit() {
    super.onInit();
    var hex = WalletContext.getInstance().walletAddress?.hex;
    if (hex != null && hex.isNotEmpty) {
      storage = new LocalStorage(hex);
    }
  }

  @override
  void onReady() {
    super.onReady();
  }

  void onVisiablity() {
    fetchData();
  }

  void fetchData() async {
    try {
      await fetchGuardiansNameMapping();
      await fetchAddedGuardians();
      await fetchGuardians();
    } catch(err) {
      Log.e(err.toString());
    }
  }

  Future<void> addGuardian({VoidCallback? callback}) async {
    var name = nameController.text;
    var address = addressController.text;
    if (isAdding) {
      return;
    }
    if (name.isEmpty) {
      ToastUtil.show('Please enter name');
      return;
    }

    if (address.isEmpty) {
      ToastUtil.show('Please enter address');
      return;
    }

    if (guardianNameMapping.containsKey(address)) {
      ToastUtil.show('The guardian $address you want to add has exists in your guardian list.');
      return;
    }

    isAdding = true;
    guardianNameMapping[address] = name;
    Log.d('setItem guardianNameMapping = ${guardianNameMapping}');
    await storage?.setItem(KEY_GUARDIAN_NAME_MAP, guardianNameMapping);

    var params = Map();
    params['wallet_address'] =
        WalletContext
            .getInstance()
            .walletAddress
            ?.hexNo0x;
    params['guardian'] = address;
    requestNetwork<Object?>(
      Method.post,
      url: HttpApi.addAccountGuardian,
      params: params,
      onSuccess: (Object? res) {
        var guardianModel = GuardianModel(name: name,
            address: address,
            addedDate: DateTime.now().toString());
        isAdding = false;
        addedGuardian.add(guardianModel);
        datas.add(guardianModel);
        storage?.setItem(KEY_ADDED_GUARDIANS, addedGuardian);
        callback?.call();
      },
    );
  }

  bool isAdded(String address) {
    var where = addedGuardian.where((element) => element.address == address);
    return where.isNotEmpty;
  }

  Future fetchGuardians() async {
    var params = {};
    params['wallet_address'] =
        WalletContext
            .getInstance()
            .walletAddress
            ?.hexNo0x;
    requestNetwork<List<dynamic>>(
      Method.post,
      url: HttpApi.getAccountGuardian,
      params: params,
      onSuccess: (List<dynamic>? res) {
        List<String> guardians = [];
        res?.forEach((element) {
          if (element != null) {
            var address = element;
            guardians.add(address);
          }
        });
        realGuardians.clear();
        guardians.forEach((element) {
          var guardianModel = GuardianModel(
            name: guardianNameMapping[element] ?? '',
            address: element,
          );
          realGuardians.add(guardianModel);
        });
        addedGuardian.removeWhere((element) => guardians.contains(element.address));
        storage?.setItem(KEY_ADDED_GUARDIANS, addedGuardian);
        datas.clear();
        datas.addAll(realGuardians);
        datas.addAll(addedGuardian);
      },
      isShow: false
    );
  }

  Future fetchAddedGuardians() async {
    Future(() {
      var item = storage?.getItem(KEY_ADDED_GUARDIANS) as List<dynamic>?;
      Log.d('fetchAddedGuardians $item');
      addedGuardian.clear();
      if (item != null) {
        item.forEach((element) {
          addedGuardian.add(GuardianModel.fromJson(element));
        });
      }
      datas.addAll(addedGuardian);
    });
  }

  Future fetchGuardiansNameMapping() async {
    return Future(() {
      var item = storage?.getItem(KEY_GUARDIAN_NAME_MAP) as Map<String, dynamic>?;
      Log.d('fetchGuardiansNameMapping $item');
      item?.forEach((key, value) {
        guardianNameMapping[key] = value;
      });
    });
  }
}
