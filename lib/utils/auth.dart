import 'package:dio/dio.dart';
import 'package:waterstone/main.dart';

class LoginTickets {
  LoginTickets({required this.lt, required this.execution});

  final String lt;
  final String execution;
}

Future<bool> checkLoginStatus() async {
  Dio dio = BaseSingleton.singleton.dio;
  Response resp = await dio.get("https://pass.hust.edu.cn/cas/login");
  if (resp.statusCode == 302) {
    return true;
  }
  return false;
}

Future<LoginTickets?> getLoginTickets() async {
  Dio dio = BaseSingleton.singleton.dio;
  Response resp = await dio.get("https://pass.hust.edu.cn/cas/login");
  if (resp.statusCode != 200) {
    return null;
  }
  String html = resp.data.toString();
  RegExpMatch? matchLt = RegExp(r'<input type="hidden" id="lt" name="lt" value="(?<lt>.*)" />').firstMatch(html);
  RegExpMatch? matchExec = RegExp(r'<input type="hidden" name="execution" value="(?<exec>.*)" />').firstMatch(html);
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

Future<bool> login() async {
  return true;
}