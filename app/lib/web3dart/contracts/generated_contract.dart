import '../credentials/credentials.dart';
import '../utils/formatting.dart';
import '../web3dart.dart';
import 'abi/abi.dart';
import 'deployed_contract.dart';

/// Base classes for generated contracts.
///
/// web3dart can generate contract classes from abi specifications. For more
/// information, see its readme!
abstract class GeneratedContract {
  GeneratedContract(this.self, this.client, this.chainId);
  final DeployedContract self;
  final Web3Client client;
  final int? chainId;

  /// Returns whether the [function] has the [expected] selector.
  ///
  /// This is used in an assert in the generated code.
  Future<bool> checkSignature(
      ContractFunction function, String expected) async {
    return bytesToHex(await function.selector) == expected;
  }

  Future<List<dynamic>> read(
    ContractFunction function,
    List<dynamic> params,
    BlockNum? atBlock,
  ) {
    return client.call(
      contract: self,
      function: function,
      params: params,
      atBlock: atBlock,
    );
  }

  Future<String> write(
    Credentials credentials,
    Transaction? base,
    ContractFunction function,
    List<dynamic> parameters,
  ) async {
    final transaction = base?.copyWith(
          data: await function.encodeCall(parameters),
          to: self.address,
        ) ??
        await Transaction.callContract(
          contract: self,
          function: function,
          parameters: parameters,
        );

    return client.sendTransaction(
      credentials,
      transaction,
      chainId: chainId,
      fetchChainIdFromNetworkId: chainId == null,
    );
  }
}
