import 'package:dio/dio.dart';

const _backendURL = "https://securecenter-poc.soulwallets.me";

typedef JsonResponse = Response<Map<String, dynamic>>;

class Request {
  static final _dio = Dio();

  static Future<JsonResponse> addAccount(Object params) {
    return _dio.post('$_backendURL/add-account', data: params);
  } // email

  static Future<JsonResponse> updateAccount(Object params) {
    return _dio.post('$_backendURL/update-account', data: params);
  } // email, key, wallet_address

  static Future<JsonResponse> verifyEmail(Object params) {
    return _dio.post('$_backendURL/verify-email', data: params);
  } // email, code

  static Future<JsonResponse> addRecover(Object params) {
    return _dio.post('$_backendURL/add-recovery-record', data: params);
  }

  static Future<JsonResponse> finishRecover(Object params) {
    return _dio.post('$_backendURL/finish-recovery-record', data: params);
  }

  static Future<JsonResponse> isWalletOwner(Object params) {
    return _dio.post('$_backendURL/is-wallet-owner', data: params);
  }

  static Future<JsonResponse> getWalletAddress(Object params) {
    return _dio.post('$_backendURL/get-wallet-address', data: params);
  }

  static Future<JsonResponse> getGuardian(Object params) {
    return _dio.post('$_backendURL/get-account-guardian', data: params);
  }

  static Future<JsonResponse> addGuardian(Object params) {
    return _dio.post('$_backendURL/add-account-guardian', data: params);
  }

  static Future<JsonResponse> delGuardian(Object params) {
    return _dio.post('$_backendURL/del-account-guardian', data: params);
  }

  static Future<JsonResponse> recoveryRecords(Object params) {
    return _dio.post('$_backendURL/fetch-recovery-records', data: params);
  }
}
