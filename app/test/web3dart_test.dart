import './web3dart/json_rpc_test.dart' as jsonRpc;
import './web3dart/infura_integration_test.dart' as infuraTest;
import './web3dart/contracts/abi/array_of_dynamic_type.dart' as abiArrayTest;
import './web3dart/contracts/abi/encoding_test.dart' as encodingTest;
import './web3dart/contracts/abi/event_test.dart' as eventTest;
import './web3dart/contracts/abi/functions_test.dart' as functionTest;
import './web3dart/contracts/abi/integers_test.dart' as integerTest;
import './web3dart/contracts/abi/tuple_test.dart' as tupleTest;
import './web3dart/contracts/abi/types_test.dart' as typeTest;
import './web3dart/core/block_parameter_test.dart' as blockParamTest;
import './web3dart/core/client_test.dart' as clientTest;
import './web3dart/core/event_filter_test.dart' as eventFilterTest;
import './web3dart/core/sign_transaction_test.dart' as signTransactionTest;
import './web3dart/core/transaction_information_test.dart'
    as transactionInformationTest;
import './web3dart/credentials/address_test.dart' as addressTest;
import './web3dart/credentials/private_key_test.dart' as privateKeyTest;
import './web3dart/credentials/public_key_test.dart' as publickKeyTest;
import './web3dart/credentials/wallet_test.dart' as walletTest;
import './web3dart/crypto/formatting_test.dart' as formattingTest;
import './web3dart/crypto/secp256k1_test.dart' as secp256k1Test;
import './web3dart/utils/rlp_test.dart' as rlpTest;

void main() {
  jsonRpc.main();
  infuraTest.main();
  abiArrayTest.main();
  encodingTest.main();
  eventTest.main();
  functionTest.main();
  integerTest.main();
  tupleTest.main();
  typeTest.main();
  blockParamTest.main();
  addressTest.main();
  privateKeyTest.main();
  publickKeyTest.main();
  walletTest.main();
  clientTest.main();
  eventFilterTest.main();
  signTransactionTest.main();
  transactionInformationTest.main();
  formattingTest.main();
  secp256k1Test.main();
  rlpTest.main();
}
