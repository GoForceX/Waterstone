import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:waterstone/utils/api/prefetch.dart';
import 'package:waterstone/utils/api/schedule/schema.dart';

import '../../../main.dart';

part 'schedule.g.dart';

@riverpod
Future<String> currentSemesterIDFromHubs(Ref ref) async {
  bool sessionStatus = await ref.watch(hubsSessionStatusProvider.future);
  if (!sessionStatus) {
    throw Exception("Failed to get hubs session");
  }

  Dio dio = BaseSingleton.singleton.dio;
  Response resp = await dio.get(
    "https://hubs.hust.edu.cn/schedule/getCurrentXq",
  );
  if (resp.statusCode != 200) {
    throw Exception("Failed to get current semester");
  }
  Map<String, dynamic> data = jsonDecode(resp.data);
  if (!data.containsKey("XQH")) {
    throw Exception("Failed to get current semester");
  }
  return data['XQH'];
}

@riverpod
Future<List<WeeklyScheduleHubs>> hubsSemesterSchedule(
  Ref ref,
  String? semesterID,
) async {
  try {
    await ref.watch(hubsSessionStatusProvider.future);
  } catch (e) {
    logger.e(e);
    rethrow;
  }

  semesterID ??= await ref.refresh(currentSemesterIDFromHubsProvider.future);

  logger.i(
    'https://hubs.hust.edu.cn/schedule/getStudentScheduleByXqh?XQH=$semesterID',
  );

  Dio dio = BaseSingleton.singleton.dio;
  Response resp = await dio.get(
    "https://hubs.hust.edu.cn/schedule/getStudentScheduleByXqh?XQH=$semesterID",
  );
  if (resp.statusCode != 200) {
    throw Exception("Failed to get semester schedule");
  }
  dynamic data = jsonDecode(resp.data);
  if (data is! List) {
    throw Exception("Failed to get semester schedule");
  }
  return data.map((e) => WeeklyScheduleHubs.fromJson(e)).toList();
}
