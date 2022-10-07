import 'package:http/http.dart' as http;

const backendURL = "https://securecenter-poc.soulwallets.me";

class Request {
  static final httpClient = http.Client();

  // email 发邮件
  static Future<http.Response> verifyEmail(Object params) async {
    return await httpClient.post(Uri.parse('$backendURL/verify-email'), body: params);
  }

  // 验证码，888888
  // email, code
  // jwtToken
  static Future<http.Response> addAccount(Object params) async {
    return await httpClient.post(Uri.parse('$backendURL/add-account'), body: params);
  }

  // 初始化 account
  // email, key(eoa地址), wallet_address
  static Future<http.Response> updateAccount(Object params) async {
    return await httpClient.post(Uri.parse('$backendURL/update-account'), body: params);
  }

  // 开始recover
  // email, code, new_key(新生成eoa), request_id(需要生成getRecoverId(new_key, walletAddress))
  // jwtToken
  static Future<http.Response> addRecover(Object params) async {
    return await httpClient.post(Uri.parse('$backendURL/add-recovery-record'), body: params);
  }

  // new_key
  // requirements {signedNum, total} 几分之几,
  // recoveryRecords.recovery_records， 里面有signatures 作为recoverWallet参数
  static Future<http.Response> fetchRecover(Object params) async {
    return await httpClient.post(Uri.parse('$backendURL/fetch-recovery-records'), body: params);
  }

  // new_key
  static Future<http.Response> finishRecover(Object params) async {
    return await httpClient.post(Uri.parse('$backendURL/finish-recovery-record'), body: params);
  }

  //
  static Future<http.Response> isWalletOwner(Object params) async {
    return await httpClient.post(Uri.parse('$backendURL/is-wallet-owner'), body: params);
  }

  // key/email
  // wallet_address
  static Future<http.Response> getWalletAddress(Object params) async {
    return await httpClient.post(Uri.parse('$backendURL/get-wallet-address'), body: params);
  }

  // wallet_address
  // 地址 []
  static Future<http.Response> getGuardian(Object params) async {
    return await httpClient.post(Uri.parse('$backendURL/get-account-guardian'), body: params);
  }

  // wallet_address, guardian
  // 200成功
  static Future<http.Response> addGuardian(Object params) async {
    return await httpClient.post(Uri.parse('$backendURL/add-account-guardian'), body: params);
  }

  // wallet_address, guardian
  // 200成功
  static Future<http.Response> delGuardian(Object params) async {
    return await httpClient.post(Uri.parse('$backendURL/del-account-guardian'), body: params);
  }
}