class IByte4Method {
  String functionName;
  String functionSignature;
  List<String> typesArray;
  IByte4Method._(this.functionName, this.functionSignature, this.typesArray);
  factory IByte4Method.create(String func, List<String> params) {
    var encodeName = '$func(${params.join(",")})';
    return IByte4Method._(func, encodeName, params);
  }
}
class IDecode {
  String functionName;
  String functionSignature;
  Object params;
  IDecode(this.functionName, this.functionSignature, this.params);
}

class DecodeCallData {
  static final DecodeCallData _instance = DecodeCallData._internal();
  var bytes4Methods = <String, IByte4Method>{};
  DecodeCallData._internal();
  static get instance {
    return _instance;
  }

  DecodeCallData() {
    bytes4Methods['0xa9059cbb'] = IByte4Method.create(transfer, transferParams);
    bytes4Methods['0x095ea7b3'] = IByte4Method.create(approve, approveParams);
    bytes4Methods['0x23b872dd'] =
        IByte4Method.create(transferFrom, transferFromParams);
    bytes4Methods['0xb88d4fde'] =
        IByte4Method.create(safeTransferFrom, safeTransferFromParams);
    bytes4Methods['0x42842e0e'] =
        IByte4Method.create(safeTransferFrom, safeTransferFromParams2);
    bytes4Methods['0xa22cb465'] =
        IByte4Method.create(setApprovalForAll, setApprovalForAllParams);
    bytes4Methods['0x2eb2c2d6'] =
        IByte4Method.create(safeBatchTransferFrom, safeBatchTransferFromParams);
    bytes4Methods['0x80c5c7d0'] =
        IByte4Method.create(execFromEntryPoint, execFromEntryPointParams);
    bytes4Methods['0xe6268114'] =
        IByte4Method.create(deleteGuardianRequest, deleteGuardianRequestParams);
    bytes4Methods['0x79f2d7c3'] =
        IByte4Method.create(grantGuardianRequest, grantGuardianRequestParams);
    bytes4Methods['0xaaf9bbd6'] =
        IByte4Method.create(revokeGuardianRequest, revokeGuardianRequestParams);
    bytes4Methods['0x4fb2e45d'] =
        IByte4Method.create(transferOwner, transferOwnerParams);
  }
}

const transfer = 'transfer';
const transferParams = ['address', 'uint256'];
const approve = 'approve';
const approveParams = ['address', 'uint256'];
const transferFrom = 'transferFrom';
const transferFromParams = ['address', 'address', 'uint256'];
const safeTransferFrom = 'safeTransferFrom';
const safeTransferFromParams = ['address', 'address', 'uint256', 'bytes'];
const safeTransferFromParams2 = ['address', 'address', 'uint256'];
const setApprovalForAll = 'setApprovalForAll';
const setApprovalForAllParams = ['address', 'bool'];
const safeBatchTransferFrom = 'safeBatchTransferFrom';
const safeBatchTransferFromParams = ['address', 'address', 'uint256[]', 'uint256[]', 'bytes']
const execFromEntryPoint = 'execFromEntryPoint';
const execFromEntryPointParams =['address', 'uint256', 'bytes'];
const deleteGuardianRequest = 'deleteGuardianRequest';
const deleteGuardianRequestParams = ['address'];
const grantGuardianRequest = 'grantGuardianRequest';
const grantGuardianRequestParams = ['address'];
const revokeGuardianRequest = 'revokeGuardianRequest';
const revokeGuardianRequestParams = ['address'];
const transferOwner = 'transferOwner';
const transferOwnerParams = ['address'];

