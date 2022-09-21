const content = '''
{
  "test1": {
    "json": {
      "crypto":{
        "cipher":"aes-128-ctr",
        "cipherparams":{
            "iv":"3295923db6c1794684cf66263e77adf6"
            },
        "ciphertext":"665c8c8739d0fdd856aff16d95199da5bff14fc4b587f76d9023354052ef7678dc0c73e4ccd4b8184919be4ea335339bef23a743b9a7364b2f9940f87620a218",
        "kdf":"scrypt",
        "kdfparams":{
          "salt":"0xc2b5e6a6a042968d40edda4807f76ce12de49bec034a7b8169876fbbd350492b5d65d0a6a277d5c6ad13f0aee20821614f2cda3a702e8d6ff4677ee2e06e4b85",
          "n":8192,
          "r":8,
          "p":1,
          "dklen":32
          },
        "mac":"1958cad8ea940ac1a8822f960430e2405b74aa842adff3d2e6cf8f554b2fa1cd"
        },
      "version":3
    },
    "password": "testpassword",
    "priv": "7a28b5ba57c53603b0b07b56bba752f7784bf506fa95edc395f5cf6c7514fe9d"
  }
}
''';
