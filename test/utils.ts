import { getCreate2Address } from '@ethersproject/address';
import { hexlify } from '@ethersproject/bytes';
import { hexZeroPad } from '@ethersproject/bytes';
import { keccak256 } from '@ethersproject/keccak256';

export function create2(from: string, salt: number, initCode: string): string {
  const saltBytes32 = numberToBytes32Hex(salt);
  const initCodeHash = keccak256(initCode);
  return getCreate2Address(from, saltBytes32, initCodeHash);
}

export function numberToBytes32Hex(number: number): string {
  return hexZeroPad(hexlify(number), 32);
}
