import 'package:dio/dio.dart';

const _backendURL = "https://securecenter-poc.soulwallets.me";

typedef JsonResponse = Response<Map<String, dynamic>>;

class Request {
  static final _dio = Dio();

// email 发邮件
  static Future<JsonResponse> addAccount(Object params) {
    return _dio.post('$_backendURL/add-account', data: params);
  } 

// 验证码，888888
  // email, code
  // jwtToken
  static Future<JsonResponse> updateAccount(Object params) {
    return _dio.post('$_backendURL/update-account', data: params);
  } 

// 初始化 account
  // email, key(eoa地址), wallet_address
  static Future<JsonResponse> verifyEmail(Object params) {
    return _dio.post('$_backendURL/verify-email', data: params);
  } 

// 开始recover
  // email, code, new_key(新生成eoa), request_id(需要生成getRecoverId(new_key, walletAddress))
  // jwtToken
  static Future<JsonResponse> addRecover(Object params) {
    return _dio.post('$_backendURL/add-recovery-record', data: params);
  }

// new_key
  // requirements {signedNum, total} 几分之几,
  // recoveryRecords.recovery_records， 里面有signatures 作为recoverWallet参数
  static Future<JsonResponse> fetchRecover(Object params) {
    return _dio.post('$_backendURL/fetch-recovery-records', data: params);
  }

// new_key
  static Future<JsonResponse> finishRecover(Object params) {
    return _dio.post('$_backendURL/finish-recovery-record', data: params);
  }

  static Future<JsonResponse> isWalletOwner(Object params) {
    return _dio.post('$_backendURL/is-wallet-owner', data: params);
  }

// key/email
  // wallet_address
  static Future<JsonResponse> getWalletAddress(Object params) {
    return _dio.post('$_backendURL/get-wallet-address', data: params);
  }

// wallet_address
  // 地址 []
  static Future<JsonResponse> getGuardian(Object params) {
    return _dio.post('$_backendURL/get-account-guardian', data: params);
  }

// wallet_address, guardian
  // 200成功
  static Future<JsonResponse> addGuardian(Object params) {
    return _dio.post('$_backendURL/add-account-guardian', data: params);
  }

// wallet_address, guardian
  // 200成功
  static Future<JsonResponse> delGuardian(Object params) {
    return _dio.post('$_backendURL/del-account-guardian', data: params);
  }

}
