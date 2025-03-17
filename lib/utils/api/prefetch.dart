import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../main.dart';
import '../net.dart';

part 'prefetch.g.dart';

@riverpod
Future<bool> physicsExperimentSessionStatus(Ref ref) async {
  Dio dio = BaseSingleton.singleton.dio;
  Response resp = await dio.get(
    "http://empxk.hust.edu.cn/weixin/index",
    options: Options(validateStatus: (statusCode) => true),
  );
  resp = await followRedirects(resp);
  if (resp.realUri.toString().startsWith("http://empxk.hust.edu.cn")) {
    return true;
  }
  return false;
}

@riverpod
Future<bool> mHubSessionStatus(Ref ref) async {
  Dio dio = BaseSingleton.singleton.dio;
  Response resp = await dio.get(
    "https://mhub.hust.edu.cn/kxjsPageController/by-sy",
    options: Options(validateStatus: (statusCode) => true),
  );
  resp = await followRedirects(resp);
  if (resp.realUri.toString().startsWith("https://mhub.hust.edu.cn")) {
    return true;
  }
  return false;
}

@riverpod
Future<bool> hubsSessionStatus(Ref ref) async {
  Dio dio = BaseSingleton.singleton.dio;
  Response resp = await dio.get(
    "https://hubs.hust.edu.cn/cas/login",
    options: Options(validateStatus: (statusCode) => true),
  );
  resp = await followRedirects(resp);
  if (resp.realUri.toString().startsWith("https://hubs.hust.edu.cn")) {
    return true;
  }
  return false;
}

@riverpod
Future<bool> hubmSessionStatus(Ref ref) async {
  Dio dio = BaseSingleton.singleton.dio;
  Response resp = await dio.get(
    "http://hub.m.hust.edu.cn/hub_weix/menuPage.do?CDBH=9128",
    options: Options(validateStatus: (statusCode) => true),
  );
  resp = await followRedirects(resp);
  if (resp.realUri.toString().startsWith("http://hub.m.hust.edu.cn")) {
    return true;
  }
  return false;
}