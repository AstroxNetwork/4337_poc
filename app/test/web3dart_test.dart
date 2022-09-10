import 'json_rpc_test.dart' as jsonRpc;
import 'infura_integration_test.dart' as infuraTest;
import 'contracts/abi/array_of_dynamic_type.dart' as abiArrayTest;
import 'contracts/abi/encoding_test.dart' as encodingTest;
import 'contracts/abi/event_test.dart' as eventTest;
import 'contracts/abi/functions_test.dart' as functionTest;
import 'contracts/abi/integers_test.dart' as integerTest;
import 'contracts/abi/tuple_test.dart' as tupleTest;
import 'contracts/abi/types_test.dart' as typeTest;
import 'core/block_parameter_test.dart' as blockParamTest;
import 'core/client_test.dart' as clientTest;
import 'core/event_filter_test.dart' as eventFilterTest;
import 'core/sign_transaction_test.dart' as signTransactionTest;
import 'core/transaction_information_test.dart' as transactionInformationTest;
import 'credentials/address_test.dart' as addressTest;
import 'credentials/private_key_test.dart' as privateKeyTest;
import 'credentials/public_key_test.dart' as publickKeyTest;
import 'credentials/wallet_test.dart' as walletTest;
import 'crypto/formatting_test.dart' as formattingTest;
import 'crypto/secp256k1_test.dart' as secp256k1Test;
import 'utils/rlp_test.dart' as rlpTest;

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
  // walletTest.main();
  clientTest.main();
  eventFilterTest.main();
  signTransactionTest.main();
  transactionInformationTest.main();
  formattingTest.main();
  secp256k1Test.main();
  rlpTest.main();
}
