// Generated code, do not modify. Run `build_runner build` to re-generate!
// @dart=2.12
// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:web3dart/web3dart.dart' as _i1;

final _contractAbi = _i1.ContractAbi.fromJson(
  '[{"inputs":[{"internalType":"uint32","name":"_unstakeDelaySec","type":"uint32"}],"stateMutability":"nonpayable","type":"constructor"},{"anonymous":false,"inputs":[{"indexed":true,"internalType":"address","name":"account","type":"address"},{"indexed":false,"internalType":"uint256","name":"withdrawTime","type":"uint256"}],"name":"DepositUnstaked","type":"event"},{"anonymous":false,"inputs":[{"indexed":true,"internalType":"address","name":"account","type":"address"},{"indexed":false,"internalType":"uint256","name":"totalDeposit","type":"uint256"},{"indexed":false,"internalType":"uint256","name":"unstakeDelaySec","type":"uint256"}],"name":"Deposited","type":"event"},{"anonymous":false,"inputs":[{"indexed":true,"internalType":"address","name":"account","type":"address"},{"indexed":false,"internalType":"address","name":"withdrawAddress","type":"address"},{"indexed":false,"internalType":"uint256","name":"withdrawAmount","type":"uint256"}],"name":"Withdrawn","type":"event"},{"inputs":[{"internalType":"address","name":"account","type":"address"},{"internalType":"uint32","name":"_unstakeDelaySec","type":"uint32"}],"name":"addStakeTo","outputs":[],"stateMutability":"payable","type":"function"},{"inputs":[{"internalType":"address","name":"account","type":"address"}],"name":"balanceOf","outputs":[{"internalType":"uint256","name":"","type":"uint256"}],"stateMutability":"view","type":"function"},{"inputs":[{"internalType":"address","name":"account","type":"address"}],"name":"depositTo","outputs":[],"stateMutability":"payable","type":"function"},{"inputs":[{"internalType":"address","name":"","type":"address"}],"name":"deposits","outputs":[{"internalType":"uint112","name":"amount","type":"uint112"},{"internalType":"uint32","name":"unstakeDelaySec","type":"uint32"},{"internalType":"uint64","name":"withdrawTime","type":"uint64"}],"stateMutability":"view","type":"function"},{"inputs":[{"internalType":"address","name":"account","type":"address"}],"name":"getDepositInfo","outputs":[{"components":[{"internalType":"uint112","name":"amount","type":"uint112"},{"internalType":"uint32","name":"unstakeDelaySec","type":"uint32"},{"internalType":"uint64","name":"withdrawTime","type":"uint64"}],"internalType":"struct StakeManager.DepositInfo","name":"info","type":"tuple"}],"stateMutability":"view","type":"function"},{"inputs":[{"internalType":"address","name":"account","type":"address"},{"internalType":"uint256","name":"requiredStake","type":"uint256"},{"internalType":"uint256","name":"requiredDelaySec","type":"uint256"}],"name":"isStaked","outputs":[{"internalType":"bool","name":"","type":"bool"}],"stateMutability":"view","type":"function"},{"inputs":[],"name":"unstakeDelaySec","outputs":[{"internalType":"uint32","name":"","type":"uint32"}],"stateMutability":"view","type":"function"},{"inputs":[],"name":"unstakeDeposit","outputs":[],"stateMutability":"nonpayable","type":"function"},{"inputs":[{"internalType":"address payable","name":"withdrawAddress","type":"address"},{"internalType":"uint256","name":"withdrawAmount","type":"uint256"}],"name":"withdrawTo","outputs":[],"stateMutability":"nonpayable","type":"function"},{"stateMutability":"payable","type":"receive"}]',
  'StakeManager',
);

class StakeManager extends _i1.GeneratedContract {
  StakeManager({
    required _i1.EthereumAddress address,
    required _i1.Web3Client client,
    int? chainId,
  }) : super(
          _i1.DeployedContract(
            _contractAbi,
            address,
          ),
          client,
          chainId,
        );

  /// The optional [transaction] parameter can be used to override parameters
  /// like the gas price, nonce and max gas. The `data` and `to` fields will be
  /// set by the contract.
  Future<String> addStakeTo(
    _i1.EthereumAddress account,
    BigInt _unstakeDelaySec, {
    required _i1.Credentials credentials,
    _i1.Transaction? transaction,
  }) async {
    final function = self.abi.functions[1];
    assert(checkSignature(function, '4a5b84ec'));
    final params = [
      account,
      _unstakeDelaySec,
    ];
    return write(
      credentials,
      transaction,
      function,
      params,
    );
  }

  /// The optional [atBlock] parameter can be used to view historical data. When
  /// set, the function will be evaluated in the specified block. By default, the
  /// latest on-chain block will be used.
  Future<BigInt> balanceOf(
    _i1.EthereumAddress account, {
    _i1.BlockNum? atBlock,
  }) async {
    final function = self.abi.functions[2];
    assert(checkSignature(function, '70a08231'));
    final params = [account];
    final response = await read(
      function,
      params,
      atBlock,
    );
    return (response[0] as BigInt);
  }

  /// The optional [transaction] parameter can be used to override parameters
  /// like the gas price, nonce and max gas. The `data` and `to` fields will be
  /// set by the contract.
  Future<String> depositTo(
    _i1.EthereumAddress account, {
    required _i1.Credentials credentials,
    _i1.Transaction? transaction,
  }) async {
    final function = self.abi.functions[3];
    assert(checkSignature(function, 'b760faf9'));
    final params = [account];
    return write(
      credentials,
      transaction,
      function,
      params,
    );
  }

  /// The optional [atBlock] parameter can be used to view historical data. When
  /// set, the function will be evaluated in the specified block. By default, the
  /// latest on-chain block will be used.
  Future<Deposits> deposits(
    _i1.EthereumAddress $param4, {
    _i1.BlockNum? atBlock,
  }) async {
    final function = self.abi.functions[4];
    assert(checkSignature(function, 'fc7e286d'));
    final params = [$param4];
    final response = await read(
      function,
      params,
      atBlock,
    );
    return Deposits(response);
  }

  /// The optional [atBlock] parameter can be used to view historical data. When
  /// set, the function will be evaluated in the specified block. By default, the
  /// latest on-chain block will be used.
  Future<dynamic> getDepositInfo(
    _i1.EthereumAddress account, {
    _i1.BlockNum? atBlock,
  }) async {
    final function = self.abi.functions[5];
    assert(checkSignature(function, '5287ce12'));
    final params = [account];
    final response = await read(
      function,
      params,
      atBlock,
    );
    return (response[0] as dynamic);
  }

  /// The optional [atBlock] parameter can be used to view historical data. When
  /// set, the function will be evaluated in the specified block. By default, the
  /// latest on-chain block will be used.
  Future<bool> isStaked(
    _i1.EthereumAddress account,
    BigInt requiredStake,
    BigInt requiredDelaySec, {
    _i1.BlockNum? atBlock,
  }) async {
    final function = self.abi.functions[6];
    assert(checkSignature(function, '1c112a44'));
    final params = [
      account,
      requiredStake,
      requiredDelaySec,
    ];
    final response = await read(
      function,
      params,
      atBlock,
    );
    return (response[0] as bool);
  }

  /// The optional [atBlock] parameter can be used to view historical data. When
  /// set, the function will be evaluated in the specified block. By default, the
  /// latest on-chain block will be used.
  Future<BigInt> unstakeDelaySec({_i1.BlockNum? atBlock}) async {
    final function = self.abi.functions[7];
    assert(checkSignature(function, '390b9978'));
    final params = [];
    final response = await read(
      function,
      params,
      atBlock,
    );
    return (response[0] as BigInt);
  }

  /// The optional [transaction] parameter can be used to override parameters
  /// like the gas price, nonce and max gas. The `data` and `to` fields will be
  /// set by the contract.
  Future<String> unstakeDeposit({
    required _i1.Credentials credentials,
    _i1.Transaction? transaction,
  }) async {
    final function = self.abi.functions[8];
    assert(checkSignature(function, '37bbb73a'));
    final params = [];
    return write(
      credentials,
      transaction,
      function,
      params,
    );
  }

  /// The optional [transaction] parameter can be used to override parameters
  /// like the gas price, nonce and max gas. The `data` and `to` fields will be
  /// set by the contract.
  Future<String> withdrawTo(
    _i1.EthereumAddress withdrawAddress,
    BigInt withdrawAmount, {
    required _i1.Credentials credentials,
    _i1.Transaction? transaction,
  }) async {
    final function = self.abi.functions[9];
    assert(checkSignature(function, '205c2878'));
    final params = [
      withdrawAddress,
      withdrawAmount,
    ];
    return write(
      credentials,
      transaction,
      function,
      params,
    );
  }

  /// Returns a live stream of all DepositUnstaked events emitted by this contract.
  Stream<DepositUnstaked> depositUnstakedEvents({
    _i1.BlockNum? fromBlock,
    _i1.BlockNum? toBlock,
  }) {
    final event = self.event('DepositUnstaked');
    final filter = _i1.FilterOptions.events(
      contract: self,
      event: event,
      fromBlock: fromBlock,
      toBlock: toBlock,
    );
    return client.events(filter).map((_i1.FilterEvent result) {
      final decoded = event.decodeResults(
        result.topics!,
        result.data!,
      );
      return DepositUnstaked(decoded);
    });
  }

  /// Returns a live stream of all Deposited events emitted by this contract.
  Stream<Deposited> depositedEvents({
    _i1.BlockNum? fromBlock,
    _i1.BlockNum? toBlock,
  }) {
    final event = self.event('Deposited');
    final filter = _i1.FilterOptions.events(
      contract: self,
      event: event,
      fromBlock: fromBlock,
      toBlock: toBlock,
    );
    return client.events(filter).map((_i1.FilterEvent result) {
      final decoded = event.decodeResults(
        result.topics!,
        result.data!,
      );
      return Deposited(decoded);
    });
  }

  /// Returns a live stream of all Withdrawn events emitted by this contract.
  Stream<Withdrawn> withdrawnEvents({
    _i1.BlockNum? fromBlock,
    _i1.BlockNum? toBlock,
  }) {
    final event = self.event('Withdrawn');
    final filter = _i1.FilterOptions.events(
      contract: self,
      event: event,
      fromBlock: fromBlock,
      toBlock: toBlock,
    );
    return client.events(filter).map((_i1.FilterEvent result) {
      final decoded = event.decodeResults(
        result.topics!,
        result.data!,
      );
      return Withdrawn(decoded);
    });
  }
}

class Deposits {
  Deposits(List<dynamic> response)
      : amount = (response[0] as BigInt),
        unstakeDelaySec = (response[1] as BigInt),
        withdrawTime = (response[2] as BigInt);

  final BigInt amount;

  final BigInt unstakeDelaySec;

  final BigInt withdrawTime;
}

class DepositUnstaked {
  DepositUnstaked(List<dynamic> response)
      : account = (response[0] as _i1.EthereumAddress),
        withdrawTime = (response[1] as BigInt);

  final _i1.EthereumAddress account;

  final BigInt withdrawTime;
}

class Deposited {
  Deposited(List<dynamic> response)
      : account = (response[0] as _i1.EthereumAddress),
        totalDeposit = (response[1] as BigInt),
        unstakeDelaySec = (response[2] as BigInt);

  final _i1.EthereumAddress account;

  final BigInt totalDeposit;

  final BigInt unstakeDelaySec;
}

class Withdrawn {
  Withdrawn(List<dynamic> response)
      : account = (response[0] as _i1.EthereumAddress),
        withdrawAddress = (response[1] as _i1.EthereumAddress),
        withdrawAmount = (response[2] as BigInt);

  final _i1.EthereumAddress account;

  final _i1.EthereumAddress withdrawAddress;

  final BigInt withdrawAmount;
}
