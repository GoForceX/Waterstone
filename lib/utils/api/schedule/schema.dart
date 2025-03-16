abstract class ClassSchedule {
  ClassSchedule({
    this.startLessonIndex,
    this.endLessonIndex,
    this.courseName,
    this.startWeek,
    this.endWeek,
    this.weekday,
    this.lessonIndex,
    this.courseID,
    this.classroomName,
  });

  String? startLessonIndex;
  String? endLessonIndex;
  String? courseName;
  int? startWeek;
  int? endWeek;
  String? weekday;
  String? lessonIndex;
  String? courseID;
  String? classroomName;
}

class ClassScheduleHubs extends ClassSchedule {
  ClassScheduleHubs({
    super.endLessonIndex,
    this.targetGrade,
    this.classID,
    super.courseName,
    super.startWeek,
    this.semesterID,
    super.endWeek,
    this.teachingForm,
    super.weekday,
    super.lessonIndex,
    this.className,
    super.startLessonIndex,
    super.courseID,
    super.classroomName,
    this.remarks,
  });

  String? targetGrade;
  String? classID;
  String? semesterID;
  String? teachingForm;
  String? className;
  String? remarks;

  factory ClassScheduleHubs.fromJson(Map<String, dynamic> json) =>
      ClassScheduleHubs(
        endLessonIndex: json["JSJC"],
        targetGrade: json["MXNJ"],
        classID: json["KTBH"],
        courseName: json["KCMC"],
        startWeek: json["QSZC"],
        semesterID: json["XQH"],
        endWeek: json["JSZC"],
        teachingForm: json["SKXS"],
        weekday: json["XQ"],
        lessonIndex: json["JC"],
        className: json["KTMC"],
        startLessonIndex: json["QSJC"],
        courseID: json["KCBH"],
        classroomName: json["JSMC"],
        remarks: json["BZ"],
      );

  Map<String, dynamic> toJson() => {
    "JSJC": endLessonIndex,
    "MXNJ": targetGrade,
    "KTBH": classID,
    "KCMC": courseName,
    "QSZC": startWeek,
    "XQH": semesterID,
    "JSZC": endWeek,
    "SKXS": teachingForm,
    "XQ": weekday,
    "JC": lessonIndex,
    "KTMC": className,
    "QSJC": startLessonIndex,
    "KCBH": courseID,
    "JSMC": classroomName,
    "BZ": remarks,
  };
}

class WeeklyScheduleHubs {
  WeeklyScheduleHubs({
    this.monday,
    this.tuesday,
    this.wednesday,
    this.thursday,
    this.friday,
    this.saturday,
    this.sunday,
    this.weekIndex,
    this.startDate,
    this.endDate,
  });

  List<ClassScheduleHubs>? monday;
  List<ClassScheduleHubs>? tuesday;
  List<ClassScheduleHubs>? wednesday;
  List<ClassScheduleHubs>? thursday;
  List<ClassScheduleHubs>? friday;
  List<ClassScheduleHubs>? saturday;
  List<ClassScheduleHubs>? sunday;
  int? weekIndex;
  String? startDate;
  String? endDate;

  factory WeeklyScheduleHubs.fromJson(Map<String, dynamic> json) =>
      WeeklyScheduleHubs(
        monday:
            json["MONDAY"] == null
                ? null
                : List<ClassScheduleHubs>.from(
                  json["MONDAY"].map((x) => ClassScheduleHubs.fromJson(x)),
                ),
        tuesday:
            json["TUESDAY"] == null
                ? null
                : List<ClassScheduleHubs>.from(
                  json["TUESDAY"].map((x) => ClassScheduleHubs.fromJson(x)),
                ),
        wednesday:
            json["WEDNESDAY"] == null
                ? null
                : List<ClassScheduleHubs>.from(
                  json["WEDNESDAY"].map((x) => ClassScheduleHubs.fromJson(x)),
                ),
        thursday:
            json["THURSDAY"] == null
                ? null
                : List<ClassScheduleHubs>.from(
                  json["THURSDAY"].map((x) => ClassScheduleHubs.fromJson(x)),
                ),
        friday:
            json["FRIDAY"] == null
                ? null
                : List<ClassScheduleHubs>.from(
                  json["FRIDAY"].map((x) => ClassScheduleHubs.fromJson(x)),
                ),
        saturday:
            json["SATURDAY"] == null
                ? null
                : List<ClassScheduleHubs>.from(
                  json["SATURDAY"].map((x) => ClassScheduleHubs.fromJson(x)),
                ),
        sunday:
            json["SUNDAY"] == null
                ? null
                : List<ClassScheduleHubs>.from(
                  json["SUNDAY"].map((x) => ClassScheduleHubs.fromJson(x)),
                ),
        weekIndex: json["ZC"],
        startDate: json["KS"],
        endDate: json["JS"],
      );

  Map<String, dynamic> toJson() => {
    "MONDAY":
        monday == null
            ? null
            : List<dynamic>.from(monday!.map((x) => x.toJson())),
    "TUESDAY":
        tuesday == null
            ? null
            : List<dynamic>.from(tuesday!.map((x) => x.toJson())),
    "WEDNESDAY":
        wednesday == null
            ? null
            : List<dynamic>.from(wednesday!.map((x) => x.toJson())),
    "THURSDAY":
        thursday == null
            ? null
            : List<dynamic>.from(thursday!.map((x) => x.toJson())),
    "FRIDAY":
        friday == null
            ? null
            : List<dynamic>.from(friday!.map((x) => x.toJson())),
    "SATURDAY":
        saturday == null
            ? null
            : List<dynamic>.from(saturday!.map((x) => x.toJson())),
    "SUNDAY":
        sunday == null
            ? null
            : List<dynamic>.from(sunday!.map((x) => x.toJson())),
    "ZC": weekIndex,
    "KS": startDate,
    "JS": endDate,
  };
}
