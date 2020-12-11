/// @description:
/// @date: 2020/11/8

import 'package:encrypt/encrypt.dart';
import 'package:pointycastle/asymmetric/api.dart';
import 'dart:async';
import 'package:flutter/services.dart' show rootBundle;

final parser = RSAKeyParser();

class EncryptHelper {

  static Future<String> encode(String src) async {
    String publicKeyString = await rootBundle.loadString('assets/keys/public.pem');
    RSAPublicKey publicKey = parser.parse(publicKeyString);
    final encrypter = Encrypter(RSA(publicKey: publicKey));
    return encrypter.encrypt(src).base64;
  }

  static Future<String> decode(String decoded) async {
    String privateKeyString = await rootBundle.loadString('assets/keys/private.pem');
    final privateKey = parser.parse(privateKeyString);
    final encrypter = Encrypter(RSA(privateKey: privateKey));
    return encrypter.decrypt(Encrypted.fromBase64(decoded));
  }

}