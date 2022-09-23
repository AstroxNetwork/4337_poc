import 'abi.dart';

void main() async {
  print(execFromEntryPoint.encodeName());
  for (final func in entryPointABI.functions) {
    print(func.encodeName());
  }
}