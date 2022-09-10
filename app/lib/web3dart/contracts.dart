/// Library to interact with ethereum smart contracts. Handles encoding and
/// decoding of the solidity contact ABI and creating transactions for calls on
/// smart contracts.
library contracts;

export 'contracts/abi/abi.dart';
export 'contracts/abi/arrays.dart';
export 'contracts/abi/integers.dart';
export 'contracts/abi/tuple.dart';
export 'contracts/abi/types.dart' hide array;
export 'contracts/deployed_contract.dart';
export 'contracts/generated_contract.dart';
