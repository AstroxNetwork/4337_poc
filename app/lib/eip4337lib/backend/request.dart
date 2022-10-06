import 'package:http/http.dart' as http;

const backendURL = "https://securecenter-poc.soulwallets.me";

class Request {
  static final httpClient = http.Client();

  static Future<http.Response> addAccount(Object params) async {
    return await httpClient.post(Uri.parse('$backendURL/add-account'), body: params);
  }
  // email

  static Future<http.Response> updateAccount(Object params) async {
    return await httpClient.post(Uri.parse('$backendURL/update-account'), body: params);
  }
  // email, key, wallet_address

  static Future<http.Response> verifyEmail(Object params) async {
    return await httpClient.post(Uri.parse('$backendURL/verify-email'), body: params);
  }
  // email, code

  static Future<http.Response> addRecover(Object params) async {
    return await httpClient.post(Uri.parse('$backendURL/add-recovery-record'), body: params);
  }

  static Future<http.Response> finishRecover(Object params) async {
    return await httpClient.post(Uri.parse('$backendURL/finish-recovery-record'), body: params);
  }

  static Future<http.Response> isWalletOwner(Object params) async {
    return await httpClient.post(Uri.parse('$backendURL/is-wallet-owner'), body: params);
  }

  static Future<http.Response> getWalletAddress(Object params) async {
    return await httpClient.post(Uri.parse('$backendURL/get-wallet-address'), body: params);
  }


  static Future<http.Response> getGuardian(Object params) async {
    return await httpClient.post(Uri.parse('$backendURL/get-account-guardian'), body: params);
  }

  static Future<http.Response> addGuardian(Object params) async {
    return await httpClient.post(Uri.parse('$backendURL/add-account-guardian'), body: params);
  }

  static Future<http.Response> delGuardian(Object params) async {
    return await httpClient.post(Uri.parse('$backendURL/del-account-guardian'), body: params);
  }

  static Future<http.Response> recoveryRecords(Object params) async {
    return await httpClient.post(Uri.parse('$backendURL/fetch-recovery-records'), body: params);
  }
}