class SpareRoomBuilding {
  SpareRoomBuilding({
    this.createdTime,
    this.lastModifiedTime,
    this.buildingShortName,
    this.buildingFloorCount,
    this.buildingName,
    this.buildingType,
    this.creatorIP,
    this.schedulingZone,
    this.buildingAvailability,
    this.creatorID,
    this.lastModifierIP,
    this.lastModifierID,
    this.campusZone,
    this.explanation,
    this.buildingID,
    this.eduBuildingID,
  });

  String? createdTime;
  String? lastModifiedTime;
  String? buildingShortName;
  int? buildingFloorCount;
  String? buildingName;
  String? buildingType;
  String? creatorIP;
  String? schedulingZone; // WTF is this pkxq!!!
  String? buildingAvailability;
  String? creatorID;
  String? lastModifierIP;
  String? lastModifierID;
  String? campusZone;
  dynamic explanation; // WTF is this sm!!!
  String? buildingID;
  String? eduBuildingID;

  factory SpareRoomBuilding.fromJson(Map<String, dynamic> json) =>
      SpareRoomBuilding(
        createdTime: json["CJSJ"],
        lastModifiedTime: json["ZHXGSJ"],
        buildingShortName: json["JXLJC"],
        buildingFloorCount: json["JXLLC"],
        buildingName: json["JXLMC"],
        buildingType: json["JXLLX"],
        creatorIP: json["CJIP"],
        schedulingZone: json["PKXQ"],
        buildingAvailability: json["JXLSFKY"],
        creatorID: json["CJRID"],
        lastModifierIP: json["ZHXGIP"],
        lastModifierID: json["ZHXGRID"],
        campusZone: json["XQ"],
        explanation: json["SM"],
        buildingID: json["LDBH"],
        eduBuildingID: json["JXLBH"],
      );

  Map<String, dynamic> toJson() => {
    "CJSJ": createdTime,
    "ZHXGSJ": lastModifiedTime,
    "JXLJC": buildingShortName,
    "JXLLC": buildingFloorCount,
    "JXLMC": buildingName,
    "JXLLX": buildingType,
    "CJIP": creatorIP,
    "PKXQ": schedulingZone,
    "JXLSFKY": buildingAvailability,
    "CJRID": creatorID,
    "ZHXGIP": lastModifierIP,
    "ZHXGRID": lastModifierID,
    "XQ": campusZone,
    "SM": explanation,
    "LDBH": buildingID,
    "JXLBH": eduBuildingID,
  };
}

class SpareRoomData {
  SpareRoomData({
    this.key1,
    this.roomCapacity,
    this.endTime,
    this.key0,
    this.seatRowCount,
    this.roomID,
    this.seatColumnCount,
    this.buildingFloorCount,
    this.buildingName,
    this.jssbmc, // WTF is this???
    this.jxyfxz, // WTF is this???
    this.campusZoneCode,
    this.roomTypeName,
    this.lessonIndex,
    this.floor,
    this.entityID,
    this.jssb, // WTF is this???
    this.startTime,
    this.roomName,
    this.eduBuildingID,
  });

  String? key1;
  int? roomCapacity;
  String? endTime;
  String? key0;
  int? seatRowCount;
  String? roomID;
  int? seatColumnCount;
  int? buildingFloorCount;
  String? buildingName;
  dynamic jssbmc;
  dynamic jxyfxz;
  String? campusZoneCode;
  dynamic roomTypeName;
  int? lessonIndex;
  int? floor;
  String? entityID;
  dynamic jssb;
  String? startTime;
  String? roomName;
  String? eduBuildingID;

  factory SpareRoomData.fromJson(Map<String, dynamic> json) => SpareRoomData(
    key1: json["key1"],
    roomCapacity: json["JSRL"],
    endTime: json["JSSJ"],
    key0: json["key0"],
    seatRowCount: json["ZWPS"],
    roomID: json["JSBH"],
    seatColumnCount: json["ZWLS"],
    buildingFloorCount: json["JXLLC"],
    buildingName: json["JXLMC"],
    jssbmc: json["JSSBMC"],
    jxyfxz: json["JXYFXZ"],
    campusZoneCode: json["XQM"],
    roomTypeName: json["JSLXMC"],
    lessonIndex: json["JC"],
    floor: json["SZLC"],
    entityID: json["DWBH"],
    jssb: json["JSSB"],
    startTime: json["KSSJ"],
    roomName: json["JSMC"],
    eduBuildingID: json["JXLBH"],
  );

  Map<String, dynamic> toJson() => {
    "key1": key1,
    "JSRL": roomCapacity,
    "JSSJ": endTime,
    "key0": key0,
    "ZWPS": seatRowCount,
    "JSBH": roomID,
    "ZWLS": seatColumnCount,
    "JXLLC": buildingFloorCount,
    "JXLMC": buildingName,
    "JSSBMC": jssbmc,
    "JXYFXZ": jxyfxz,
    "XQM": campusZoneCode,
    "JSLXMC": roomTypeName,
    "JC": lessonIndex,
    "SZLC": floor,
    "DWBH": entityID,
    "JSSB": jssb,
    "KSSJ": startTime,
    "JSMC": roomName,
    "JXLBH": eduBuildingID,
  };
}
