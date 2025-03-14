import "dart:convert";
import "dart:typed_data";

import "package:asn1lib/asn1lib.dart";
import "package:pointycastle/export.dart";

Uint8List rsaEncrypt(RSAPublicKey myPublic, Uint8List dataToEncrypt) {
  final encryptor = PKCS1Encoding(RSAEngine())
    ..init(true, PublicKeyParameter<RSAPublicKey>(myPublic)); // true=encrypt

  return _processInBlocks(encryptor, dataToEncrypt);
}

Uint8List rsaDecrypt(RSAPrivateKey myPrivate, Uint8List cipherText) {
  final decryptor = PKCS1Encoding(RSAEngine())..init(
    false,
    PrivateKeyParameter<RSAPrivateKey>(myPrivate),
  ); // false=decrypt

  return _processInBlocks(decryptor, cipherText);
}

Uint8List _processInBlocks(AsymmetricBlockCipher engine, Uint8List input) {
  final numBlocks =
      input.length ~/ engine.inputBlockSize +
      ((input.length % engine.inputBlockSize != 0) ? 1 : 0);

  final output = Uint8List(numBlocks * engine.outputBlockSize);

  var inputOffset = 0;
  var outputOffset = 0;
  while (inputOffset < input.length) {
    final chunkSize =
        (inputOffset + engine.inputBlockSize <= input.length)
            ? engine.inputBlockSize
            : input.length - inputOffset;

    outputOffset += engine.processBlock(
      input,
      inputOffset,
      chunkSize,
      output,
      outputOffset,
    );

    inputOffset += chunkSize;
  }

  return (output.length == outputOffset)
      ? output
      : output.sublist(0, outputOffset);
}

RSAPublicKey decodePEMPublicKey(String raw) {
  Uint8List transformed = base64Decode(raw);
  ASN1Parser parser = ASN1Parser(transformed);
  ASN1Sequence seq = parser.nextObject() as ASN1Sequence;
  Uint8List pubKeyStr = seq.elements[1].contentBytes();
  ASN1Parser pubKeyParser = ASN1Parser(pubKeyStr);
  ASN1Sequence pubKeySeq = pubKeyParser.nextObject() as ASN1Sequence;
  ASN1Integer modulus = pubKeySeq.elements[0] as ASN1Integer;
  ASN1Integer exponent = pubKeySeq.elements[1] as ASN1Integer;
  return RSAPublicKey(modulus.valueAsBigInteger, exponent.valueAsBigInteger);
}
