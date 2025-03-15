import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:waterstone/utils/api/prefetch.dart';
import 'package:waterstone/utils/api/spare_room/schema.dart';

import '../../../main.dart';

part 'spare_room.g.dart';

@riverpod
Future<List<SpareRoomBuilding>> spareRoomBuildings(Ref ref) async {
  bool sessionStatus = await ref.watch(mHubSessionStatusProvider.future);
  if (!sessionStatus) {
    throw Exception("Failed to get spare room session");
  }

  Dio dio = BaseSingleton.singleton.dio;
  Response resp = await dio.get(
    "https://mhub.hust.edu.cn/CommonController/jslOpthions",
  );
  if (resp.statusCode != 200) {
    throw Exception("Failed to get spare room buildings");
  }
  Map<String, dynamic> data = jsonDecode(resp.data);
  if (!data.containsKey("jslOpthions")) {
    throw Exception("Failed to get spare room buildings");
  }
  List<dynamic> buildings = data['jslOpthions'];
  return buildings.map((e) => SpareRoomBuilding.fromJson(e)).toList();
}

@riverpod
Future<List<SpareRoomData>> availableSpareRooms(Ref ref) async {
  bool sessionStatus = await ref.watch(mHubSessionStatusProvider.future);
  if (!sessionStatus) {
    throw Exception("Failed to get spare room session");
  }

  Dio dio = BaseSingleton.singleton.dio;
  Response resp = await dio.get(
    "https://mhub.hust.edu.cn/kxjsController/selectFreeRoom",
  );
  if (resp.statusCode != 200) {
    throw Exception("Failed to get spare room status");
  }
  Map<String, dynamic> data = jsonDecode(resp.data);
  if (!data.containsKey("dataList")) {
    throw Exception("Failed to get spare room status");
  }
  List<dynamic> rooms = data['dataList'];
  return rooms.map((e) => SpareRoomData.fromJson(e)).toList();
}
