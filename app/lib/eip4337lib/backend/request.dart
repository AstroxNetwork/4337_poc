import 'package:http/http.dart' as http;

const backendURL = "https://securecenter-poc.soulwallets.me";

class Request {
  static final httpClient = http.Client();

  static Future<http.Response> addAccount(Object params) async {
    return await httpClient.post(Uri.parse('$backendURL/add-account'), body: params);
  }

  static Future<http.Response> updateAccount(Object params) async {
    return await httpClient.post(Uri.parse('$backendURL/update-account'), body: params);
  }

  static Future<http.Response> verifyEmail(Object params) async {
    return await httpClient.post(Uri.parse('$backendURL/verify-email'), body: params);
  }

  static Future<http.Response> recover(Object params) async {
    return await httpClient.post(Uri.parse('$backendURL/add-recovery-record'), body: params);
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