import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:waterstone/utils/api/physics/schema.dart';

import '../../../main.dart';
import '../../net.dart';

part 'physics.g.dart';

@riverpod
Future<bool> prefetchPhysicsExperimentSession(Ref ref) async {
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
Future<List<PhysicsExperimentRecord>> getPhysicsExperimentRecords(
  Ref ref,
) async {
  bool sessionStatus = await ref.watch(
    prefetchPhysicsExperimentSessionProvider.future,
  );
  if (!sessionStatus) {
    throw Exception("Failed to get physics experiment records");
  }

  Dio dio = BaseSingleton.singleton.dio;
  Response resp = await dio.get(
    "http://empxk.hust.edu.cn/weixin/wechat/searchSumScoreInterface",
  );
  if (resp.statusCode != 200) {
    throw Exception("Failed to get physics experiment records");
  }
  Map<String, dynamic> data = jsonDecode(resp.data);
  if (data['state'] != "0000") {
    throw Exception("Failed to get physics experiment records");
  }
  List<dynamic> courseData = data['data'];
  return courseData.map((e) => PhysicsExperimentRecord.fromJson(e)).toList();
}

@riverpod
Future<List<PhysicsExperimentAppointment>> getPhysicsExperimentSchedule(
  Ref ref,
) async {
  bool sessionStatus = await ref.watch(
    prefetchPhysicsExperimentSessionProvider.future,
  );
  if (!sessionStatus) {
    throw Exception("Failed to get physics schedules");
  }

  Dio dio = BaseSingleton.singleton.dio;
  Response resp = await dio.get(
    "http://empxk.hust.edu.cn/weixin/WeChatChooseCourse/getMyCourseSchedule",
  );
  if (resp.statusCode != 200) {
    throw Exception("Failed to get physics courses");
  }
  Map<String, dynamic> data = jsonDecode(resp.data);
  if (data['state'] != "0000") {
    throw Exception("Failed to get physics courses");
  }
  List<dynamic> courseData = data['data'];
  courseData = courseData.sublist(0, courseData.length - 1);
  return courseData
      .map((e) => PhysicsExperimentAppointment.fromJson(e))
      .toList();
}
