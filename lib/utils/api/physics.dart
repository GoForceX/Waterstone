import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../main.dart';
import '../net.dart';

part 'physics.g.dart';

class PhysicsExperimentRecord {
  PhysicsExperimentRecord({
    required this.studentId,
    required this.roomName,
    required this.experimentScore,
    required this.facultyId,
    required this.courseName,
    required this.userName,
    required this.teacherId,
    required this.id,
    this.reportScore,
    required this.cardNumber,
    required this.signTime,
    required this.status,
  });

  final String studentId;
  final String roomName;
  final int experimentScore;
  final int facultyId;
  final String courseName;
  final String userName;
  final int teacherId;
  final int id;
  final int? reportScore;
  final String cardNumber;
  final String signTime;
  final int status;

  factory PhysicsExperimentRecord.fromJson(Map<String, dynamic> json) {
    return PhysicsExperimentRecord(
      studentId: json['studentId'],
      roomName: json['room_name'],
      experimentScore: json['experiment_score'],
      facultyId: json['faculty_id'],
      courseName: json['course_name'],
      userName: json['user_name'],
      teacherId: json['teacher_id'],
      id: json['id'],
      reportScore: json['report_score'],
      cardNumber: json['cardNumber'],
      signTime: json['sign_time'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['studentId'] = studentId;
    data['room_name'] = roomName;
    data['experiment_score'] = experimentScore;
    data['faculty_id'] = facultyId;
    data['course_name'] = courseName;
    data['user_name'] = userName;
    data['teacher_id'] = teacherId;
    data['id'] = id;
    data['report_score'] = reportScore;
    data['cardNumber'] = cardNumber;
    data['sign_time'] = signTime;
    data['status'] = status;
    return data;
  }
}

@riverpod
Future<bool> prefetchSession(Ref ref) async {
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
  bool sessionStatus = await ref.watch(prefetchSessionProvider.future);
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
