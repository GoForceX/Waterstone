import 'package:dio/dio.dart';
import 'package:waterstone/main.dart';

Future<Response> followRedirects(Response initialResp) async {
  Dio dio = BaseSingleton.singleton.dio;
  Response resp = initialResp;
  while (resp.statusCode == 302) {
    String location = resp.headers['location']!.first;
    resp = await dio.get(location);
  }
  return resp;
}
