import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:intl/intl.dart'; // Add this import
import 'package:waterstone/utils/api/prefetch.dart';
import 'package:waterstone/utils/api/schedule/schema.dart';

import '../../../main.dart';

part 'schedule.g.dart';

// @riverpod
// Future<String> currentSemesterIDFromHubs(Ref ref) async {
//   bool sessionStatus = await ref.watch(hubsSessionStatusProvider.future);
//   if (!sessionStatus) {
//     throw Exception("Failed to get hubs session");
//   }
//
//   Dio dio = BaseSingleton.singleton.dio;
//   Response resp = await dio.get(
//     "https://hubs.hust.edu.cn/schedule/getCurrentXq",
//   );
//   if (resp.statusCode != 200) {
//     throw Exception("Failed to get current semester");
//   }
//   Map<String, dynamic> data = jsonDecode(resp.data);
//   if (!data.containsKey("XQH")) {
//     throw Exception("Failed to get current semester");
//   }
//   return data['XQH'];
// }

@riverpod
Future<SemesterTimeInfo> currentSemesterTimeInfoFromHubs(Ref ref) async {
  bool sessionStatus = await ref.watch(hubsSessionStatusProvider.future);
  if (!sessionStatus) {
    throw Exception("Failed to get hubs session");
  }

  Dio dio = BaseSingleton.singleton.dio;
  Response resp = await dio.get(
    "https://hubs.hust.edu.cn/schedule/getCurrentXq",
  );
  if (resp.statusCode != 200) {
    throw Exception("Failed to get current semester times");
  }
  Map<String, dynamic> data = jsonDecode(resp.data);
  if (!data.containsKey("XQH")) {
    throw Exception("Failed to get current semester times");
  }
  return SemesterTimeInfo.fromJson(data);
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

  semesterID ??=
      (await ref.refresh(
        currentSemesterTimeInfoFromHubsProvider.future,
      )).semesterID;

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

@riverpod
Future<List<ClassScheduleEPIC>> epicClassSchedule(Ref ref) async {
  bool hubmSessionStatus = await ref.watch(hubmSessionStatusProvider.future);
  bool hubsSessionStatus = await ref.watch(hubsSessionStatusProvider.future);
  if (!hubmSessionStatus || !hubsSessionStatus) {
    throw Exception("Failed to get session");
  }

  SemesterTimeInfo timeInfo = await ref.watch(
    currentSemesterTimeInfoFromHubsProvider.future,
  );

  final DateFormat formatter = DateFormat('yyyy-MM-dd');
  final DateTime startDate = DateTime.parse(timeInfo.startDate ?? "");
  final DateTime endDate = DateTime.parse(timeInfo.endDate ?? "");
  final String formattedStartDate = formatter.format(startDate);
  final String formattedEndDate = formatter.format(endDate);

  Dio dio = BaseSingleton.singleton.dio;
  Response resp = await dio.post(
    "http://hub.m.hust.edu.cn/hub_weix/commonController/queryJgsx.do",
    options: Options(contentType: Headers.formUrlEncodedContentType),
    data: {
      "jgsxMethod": "jgsxservice.queryMyTimetableUrl",
      "start": formattedStartDate,
      "end": formattedEndDate,
    },
  );

  if (resp.statusCode != 200) {
    throw Exception("Failed to get class schedule");
  }

  String data = jsonDecode(resp.data);
  Map<String, dynamic> dataMap = jsonDecode(data);
  if (dataMap["returnCode"] != "S") {
    throw Exception("Failed to get class schedule");
  }

  List<dynamic> courses = jsonDecode(dataMap["returnData"]);
  logger.i(courses);

  return courses.map((e) => ClassScheduleEPIC.fromJson(e, timeInfo)).toList();
}

@riverpod
Future<WeeklySchedule> getAllSchedule(Ref ref) async {
  try {
    // Get the current semester ID from the time info
    SemesterTimeInfo timeInfo = await ref.watch(
      currentSemesterTimeInfoFromHubsProvider.future,
    );

    // Fetch schedules from both sources in parallel
    final hubsScheduleFuture = ref.watch(
      hubsSemesterScheduleProvider(timeInfo.semesterID).future,
    );

    final epicScheduleFuture = ref.watch(epicClassScheduleProvider.future);

    // Wait for both to complete
    final results = await Future.wait([hubsScheduleFuture, epicScheduleFuture]);

    // Combine the results
    return WeeklySchedule(
      hubsSchedules: results[0] as List<WeeklyScheduleHubs>,
      epicSchedules: results[1] as List<ClassScheduleEPIC>,
    );
  } catch (e) {
    logger.e("Failed to get combined schedules: $e");
    rethrow;
  }
}
