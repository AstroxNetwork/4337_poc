
const backendURL = "https://securecenter-poc.soulwallets.me";

class HttpApi {
  static const String addAccount = '$backendURL/add-account';
  static const String updateAccount = '$backendURL/update-account';
  static const String verifyEmail = '$backendURL/verify-email';
  static const String addRecoveryRecord = '$backendURL/add-recovery-record';
  static const String getAccountGuardian = '$backendURL/get-account-guardian';
  static const String addAccountGuardian = '$backendURL/add-account-guardian';
  static const String delAccountGuardian = '$backendURL/del-account-guardian';
  static const String fetchRecoveryRecords = '$backendURL/fetch-recovery-records';
}
