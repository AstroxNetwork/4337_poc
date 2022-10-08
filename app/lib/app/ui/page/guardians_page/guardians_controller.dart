import 'package:app/app/base/get/getx_controller_inject.dart';
import 'package:app/app/ui/routes/routes.dart';
import 'package:app/app/model/data_model.dart';
import 'package:app/app/util/toast_util.dart';
import 'package:app/constant.dart';
import 'package:app/eip4337lib/context/context.dart';
import 'package:app/eip4337lib/utils/log_util.dart';
import 'package:app/net/dio_utils.dart';
import 'package:app/net/http_api.dart';
import 'package:app/web3dart/credentials/address.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GuardiansController extends BaseGetController {
  late RxList<GuardianModel> datas = <GuardianModel>[].obs;

  late List<GuardianModel> addedGuardian = <GuardianModel>[];
  late List<GuardianModel> realGuardians = <GuardianModel>[];
  late Map<String, dynamic> guardianNameMapping = {};

  bool isAdding = false;

  TextEditingController nameController = TextEditingController(text: '');
  TextEditingController addressController = TextEditingController(text: '');

  @override
  void onVisibility() {
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      await fetchGuardiansNameMapping();
      await fetchAddedGuardians();
      await fetchGuardians();
    } catch (e, s) {
      LogUtil.e(e, stackTrace: s);
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

    var guardianModel = GuardianModel(
      name: name,
      address: address,
      addedDate: DateTime.now().toString(),
    );
    isAdding = true;
    guardianNameMapping[address] = name;
    LogUtil.d('setItem guardianNameMapping = $guardianNameMapping');
    await storage?.setItem(Constant.KEY_GUARDIAN_NAME_MAP, guardianNameMapping);

    final params = {};
    params['wallet_address'] =
        WalletContext.getInstance().walletAddress.hexNo0x;
    params['guardian'] = address;
    loadingStart();
    try {
      final ethereumAddress = EthereumAddress.fromHex(address);
      await WalletContext.getInstance().addGuardian(ethereumAddress);
      await requestNetwork<Object?>(
        Method.post,
        url: HttpApi.addAccountGuardian,
        params: params,
        onSuccess: (Object? res) {
          loadingStop();
          isAdding = false;
          datas.add(guardianModel);
          addedGuardian.add(guardianModel);
          storage?.setItem(Constant.KEY_ADDED_GUARDIANS, addedGuardian);
          callback?.call();
        },
        onError: (_, __) {
          loadingStop();
        },
        isShow: false,
      );
    } on ArgumentError catch (err) {
      if ((err.message ?? '').isNotEmpty) {
        loadingStop();
        ToastUtil.show(err.message.toString());
      }
    } catch (err) {
      ToastUtil.show(err.toString());
      loadingStop();
    } finally {
      isAdding = false;
    }
  }

  bool isAdded(String address) {
    var where = addedGuardian.where((element) => element.address == address);
    return where.isNotEmpty;
  }

  Future fetchGuardians() async {
    var params = {};
    params['wallet_address'] =
        WalletContext.getInstance().walletAddress.hexNo0x;
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
        for (var element in guardians) {
          var guardianModel = GuardianModel(
            name: guardianNameMapping[element] ?? '',
            address: element,
          );
          realGuardians.add(guardianModel);
        }
        addedGuardian.removeWhere(
          (element) => guardians.contains(element.address),
        );
        storage?.setItem(Constant.KEY_ADDED_GUARDIANS, addedGuardian);
        datas.clear();
        datas.addAll(realGuardians);
        datas.addAll(addedGuardian);
      },
      isShow: false,
    );
  }

  Future fetchAddedGuardians() async {
    final item = storage?.getItem(
      Constant.KEY_ADDED_GUARDIANS,
    ) as List<dynamic>?;
    LogUtil.d('fetchAddedGuardians $item');
    addedGuardian.clear();
    if (item != null) {
      for (var element in item) {
        addedGuardian.add(GuardianModel.fromJson(element));
      }
    }
    datas.addAll(addedGuardian);
  }

  Future fetchGuardiansNameMapping() async {
    return Future(() {
      final item = storage?.getItem(
        Constant.KEY_GUARDIAN_NAME_MAP,
      ) as Map<String, dynamic>?;
      LogUtil.d('fetchGuardiansNameMapping $item');
      if (item != null) {
        item.forEach((key, value) {
          guardianNameMapping[key] = value;
        });
      }
    });
  }

  void onGuardianItemClick(GuardianModel model) {
    LogUtil.d('GuardiansItem onItemClick ${model.toJson()}');
    Get.toNamed(Routes.guardianPage, arguments: model)?.then((value) {
      if (value is String && value.isNotEmpty) {
        removeGuardian(value);
        fetchData();
      }
    });
  }

  Future<void> removeGuardian(String address) async {
    if (address.isEmpty) {
      return;
    }
    addedGuardian.removeWhere((element) => element.address == address);
    var params = {};
    params['wallet_address'] =
        WalletContext.getInstance().walletAddress.hexNo0x;
    params['guardian'] = address;
    loadingStart();
    try {
      var ethereumAddress = EthereumAddress.fromHex(address);
      await WalletContext.getInstance().removeGuardian(ethereumAddress);
      await requestNetwork<Object?>(
        Method.post,
        url: HttpApi.delAccountGuardian,
        params: params,
        onSuccess: (Object? res) {
          datas.removeWhere((element) => element.address == address);
          loadingStop();
        },
        onError: (_, __) {
          loadingStop();
        },
        isShow: false,
      );
    } on ArgumentError catch (err) {
      ToastUtil.show(err.message.toString());
    } catch (err) {
      if (err.toString().isNotEmpty) {
        ToastUtil.show(err.toString());
      }
      loadingStop();
    }
  }
}
