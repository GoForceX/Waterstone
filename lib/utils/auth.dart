import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pointycastle/pointycastle.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:waterstone/main.dart';
import 'package:waterstone/utils/rsa.dart';

part 'auth.g.dart';

class LoginTickets {
  LoginTickets({required this.lt, required this.execution});

  final String lt;
  final String execution;
}

@riverpod
Future<bool> checkLoginStatus(Ref ref) async {
  Dio dio = BaseSingleton.singleton.dio;
  logger.i("114514, checking");
  Response resp = await dio.get(
    "https://pass.hust.edu.cn/cas/login",
    options: Options(
      followRedirects: false,
      validateStatus: (statusCode) => true,
    ),
  );
  logger.i(resp.statusCode);
  if (resp.statusCode == 302) {
    return true;
  }
  return false;
}

@riverpod
Future<LoginTickets?> getLoginTickets(Ref ref) async {
  bool status = await ref.refresh(checkLoginStatusProvider.future);
  if (status) {
    return null;
  }

  Dio dio = BaseSingleton.singleton.dio;
  Response resp = await dio.get("https://pass.hust.edu.cn/cas/login");
  if (resp.statusCode != 200) {
    return null;
  }
  String html = resp.data.toString();
  RegExpMatch? matchLt = RegExp(
    r'<input type="hidden" id="lt" name="lt" value="(?<lt>.*)" />',
  ).firstMatch(html);
  RegExpMatch? matchExec = RegExp(
    r'<input type="hidden" name="execution" value="(?<exec>.*)" />',
  ).firstMatch(html);
  if (matchLt == null || matchExec == null) {
    return null;
  }
  String? lt = matchLt.namedGroup('lt');
  String? execution = matchExec.namedGroup('exec');
  logger.i('lt = $lt, execution = $execution');
  if (lt == null || execution == null) {
    return null;
  }
  return LoginTickets(lt: lt, execution: execution);
}

Future<bool> login(
  LoginTickets tickets,
  String username,
  String password,
  String code,
) async {
  Dio dio = BaseSingleton.singleton.dio;
  Response resp = await dio.post("https://pass.hust.edu.cn/cas/rsa");
  String data = resp.data.toString();
  String pubKey = jsonDecode(data)["publicKey"];
  RSAPublicKey publicKey = decodePEMPublicKey(pubKey);
  String encUsername = base64Encode(
    rsaEncrypt(publicKey, utf8.encode(username)),
  );
  String encPassword = base64Encode(
    rsaEncrypt(publicKey, utf8.encode(password)),
  );
  logger.i('$pubKey, $encUsername, $encPassword, $code');
  Map<String, dynamic> params = {
    "rsa": null,
    "ul": encUsername,
    "pl": encPassword,
    "code": code,
    "phoneCode": null,
    "lt": tickets.lt,
    "execution": tickets.execution,
    "_eventId": "submit",
  };
  logger.i(params);
  Response loginResp = await dio.post(
    "https://pass.hust.edu.cn/cas/login",
    options: Options(
      contentType: Headers.formUrlEncodedContentType,
      followRedirects: false,
      validateStatus: (statusCode) {
        if (statusCode != null && statusCode < 400) {
          return true;
        }
        return false;
      },
    ),
    data: params,
  );
  logger.i(loginResp.headers);
  return true;
}
