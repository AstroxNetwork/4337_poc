import 'package:app/web3dart/contracts.dart';

class IContract {
  final ContractAbi ABI;
  final String bytecode;
  IContract(this.ABI, this.bytecode);
}
