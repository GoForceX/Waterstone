class SemesterTimeInfo {
  SemesterTimeInfo({
    this.startDate,
    this.endDate,
    this.semesterName,
    this.semesterID,
    this.finalExamWeek,
  });

  String? startDate;
  String? endDate;
  String? semesterName;
  String? semesterID;
  int? finalExamWeek;

  factory SemesterTimeInfo.fromJson(Map<String, dynamic> json) =>
      SemesterTimeInfo(
        startDate: json["QSRQ"],
        endDate: json["JSRQ"],
        semesterName: json["XQMC"],
        semesterID: json["XQH"],
        finalExamWeek: json["QMKSZC"],
      );

  Map<String, dynamic> toJson() => {
    "QSRQ": startDate,
    "JSRQ": endDate,
    "XQMC": semesterName,
    "XQH": semesterID,
    "QMKSZC": finalExamWeek,
  };
}

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

/// EPIC -> Engineering Practice and Innovation Center
///
/// 工创中心课表
class ClassScheduleEPIC extends ClassSchedule {
  ClassScheduleEPIC({
    this.courseWorkId,
    super.courseID,
    super.courseName,
    this.classDate,
    super.weekday,
    this.time,
    this.classID,
    this.className,
    this.classCapacity,
    this.registeredStudents,
    this.workNo,
    this.workName,
    this.practiceTypeID,
    this.practiceTypeName,
    this.classroomNo,
    super.classroomName,
    this.staffNo,
    this.positionNo,
    this.positionName,
    this.teacherName,
    this.hasOpenings,
    this.adminClassName,
    super.startLessonIndex,
    super.endLessonIndex,
    this.plannedClassroom,
    this.planId,
    this.studentCount,
    this.startTime,
    this.endTime,
    this.workScore,
    this.examResult,
    this.courseType,
    super.startWeek,
    super.endWeek,
  });

  int? courseWorkId;
  String? classDate;
  dynamic time;
  dynamic classID;
  dynamic className;
  dynamic classCapacity;
  dynamic registeredStudents;
  dynamic workNo;
  String? workName;
  dynamic practiceTypeID;
  String? practiceTypeName;
  dynamic classroomNo;
  dynamic staffNo;
  dynamic positionNo;
  dynamic positionName;
  String? teacherName;
  dynamic hasOpenings;
  dynamic adminClassName;
  dynamic plannedClassroom;
  dynamic planId;
  dynamic studentCount;
  String? startTime;
  String? endTime;
  dynamic workScore;
  dynamic examResult;
  String? courseType;

  factory ClassScheduleEPIC.fromJson(
    Map<String, dynamic> json,
    SemesterTimeInfo timeInfo,
  ) {
    int? weekNumber;
    if (json["skrq"] != null) {
      DateTime classDate = DateTime.parse(json["skrq"]);
      DateTime startDate = DateTime.parse(timeInfo.startDate!);
      DateTime endDate = DateTime.parse(timeInfo.endDate!);

      if (classDate.isAfter(startDate) && classDate.isBefore(endDate)) {
        weekNumber = ((classDate.difference(startDate).inDays) / 7).floor() + 1;
      } else {
        weekNumber = -1;
      }
    } else {
      weekNumber = -1;
    }

    if (json["xq"] == null) {
      DateTime classDate = DateTime.parse(json["skrq"]);
      DateTime startDate = DateTime.parse(timeInfo.startDate!);
      DateTime weekStartDate = startDate.add(
        Duration(days: (weekNumber - 1) * 7),
      );
      int weekday = classDate.weekday - weekStartDate.weekday + 1;
      json["xq"] = weekday.toString();
    }

    return ClassScheduleEPIC(
      courseWorkId: json["ktgzid"],
      courseID: json["kcbh"],
      courseName: json["kcmc"] ?? json["xllxmc"],
      classDate: json["skrq"],
      weekday: json["xq"],
      time: json["time"],
      classID: json["ktbh"],
      className: json["ktmc"],
      classCapacity: json["ktrl"],
      registeredStudents: json["ktrs"],
      workNo: json["gzbh"],
      workName: json["gzmc"],
      practiceTypeID: json["xllxbh"],
      practiceTypeName: json["xllxmc"],
      classroomNo: json["jsbh"],
      classroomName: json["jsmc"],
      staffNo: json["zgwbh"],
      positionNo: json["gwxh"],
      positionName: json["gwmc"],
      teacherName: json["teacherName"],
      hasOpenings: json["sfykw"],
      adminClassName: json["bjmc"],
      startLessonIndex: json["qsjc"],
      endLessonIndex: json["jsjc"],
      plannedClassroom: json["jgsxApskjhJs"],
      planId: json["jhid"],
      studentCount: json["xsrs"],
      startTime: json["kssj"],
      endTime: json["jssj"],
      workScore: json["gzcj"],
      examResult: json["ksqkmc"],
      courseType: json["kcType"],
      startWeek: weekNumber,
      endWeek: weekNumber,
    );
  }

  Map<String, dynamic> toJson() => {
    "ktgzid": courseWorkId,
    "kcbh": courseID,
    "kcmc": courseName,
    "skrq": classDate,
    "xq": weekday,
    "time": time,
    "ktbh": classID,
    "ktmc": className,
    "ktrl": classCapacity,
    "ktrs": registeredStudents,
    "gzbh": workNo,
    "gzmc": workName,
    "xllxbh": practiceTypeID,
    "xllxmc": practiceTypeName,
    "jsbh": classroomNo,
    "jsmc": classroomName,
    "zgwbh": staffNo,
    "gwxh": positionNo,
    "gwmc": positionName,
    "teacherName": teacherName,
    "sfykw": hasOpenings,
    "bjmc": adminClassName,
    "qsjc": startLessonIndex,
    "jsjc": endLessonIndex,
    "jgsxApskjhJs": plannedClassroom,
    "jhid": planId,
    "xsrs": studentCount,
    "kssj": startTime,
    "jssj": endTime,
    "gzcj": workScore,
    "ksqkmc": examResult,
    "kcType": courseType,
  };
}

class WeeklySchedule {
  final List<WeeklyScheduleHubs> hubsSchedules;
  final List<ClassScheduleEPIC> epicSchedules;

  WeeklySchedule({required this.hubsSchedules, required this.epicSchedules});

  // Helper method to get all courses for a specific week
  List<dynamic> getCoursesForWeek(int week) {
    List<dynamic> courses = [];

    // Add HUBS courses for this week
    for (var hubsWeek in hubsSchedules) {
      if (hubsWeek.weekIndex == week) {
        // Add all courses from this week's schedule
        if (hubsWeek.monday != null) courses.addAll(hubsWeek.monday!);
        if (hubsWeek.tuesday != null) courses.addAll(hubsWeek.tuesday!);
        if (hubsWeek.wednesday != null) courses.addAll(hubsWeek.wednesday!);
        if (hubsWeek.thursday != null) courses.addAll(hubsWeek.thursday!);
        if (hubsWeek.friday != null) courses.addAll(hubsWeek.friday!);
        if (hubsWeek.saturday != null) courses.addAll(hubsWeek.saturday!);
        if (hubsWeek.sunday != null) courses.addAll(hubsWeek.sunday!);
      }
    }

    // Add EPIC courses for this week
    for (var epicCourse in epicSchedules) {
      if (epicCourse.startWeek == week ||
          epicCourse.endWeek == week ||
          (epicCourse.startWeek != null &&
              epicCourse.endWeek != null &&
              epicCourse.startWeek! <= week &&
              epicCourse.endWeek! >= week)) {
        courses.add(epicCourse);
      }
    }

    return courses;
  }

  // Alternative method that returns courses organized by day of the week
  Map<String, List<dynamic>> getCoursesForWeekByDay(int week) {
    Map<String, List<dynamic>> coursesByDay = {
      'Monday': [],
      'Tuesday': [],
      'Wednesday': [],
      'Thursday': [],
      'Friday': [],
      'Saturday': [],
      'Sunday': [],
    };

    // Add HUBS courses
    for (var hubsWeek in hubsSchedules) {
      if (hubsWeek.weekIndex == week) {
        if (hubsWeek.monday != null) {
          coursesByDay['Monday']!.addAll(hubsWeek.monday!);
        }
        if (hubsWeek.tuesday != null) {
          coursesByDay['Tuesday']!.addAll(hubsWeek.tuesday!);
        }
        if (hubsWeek.wednesday != null) {
          coursesByDay['Wednesday']!.addAll(hubsWeek.wednesday!);
        }
        if (hubsWeek.thursday != null) {
          coursesByDay['Thursday']!.addAll(hubsWeek.thursday!);
        }
        if (hubsWeek.friday != null) {
          coursesByDay['Friday']!.addAll(hubsWeek.friday!);
        }
        if (hubsWeek.saturday != null) {
          coursesByDay['Saturday']!.addAll(hubsWeek.saturday!);
        }
        if (hubsWeek.sunday != null) {
          coursesByDay['Sunday']!.addAll(hubsWeek.sunday!);
        }
      }
    }

    // Add EPIC courses
    for (var epicCourse in epicSchedules) {
      if (epicCourse.startWeek == week ||
          epicCourse.endWeek == week ||
          (epicCourse.startWeek != null &&
              epicCourse.endWeek != null &&
              epicCourse.startWeek! <= week &&
              epicCourse.endWeek! >= week)) {
        String? day;
        switch (epicCourse.weekday) {
          case '1':
            day = 'Monday';
            break;
          case '2':
            day = 'Tuesday';
            break;
          case '3':
            day = 'Wednesday';
            break;
          case '4':
            day = 'Thursday';
            break;
          case '5':
            day = 'Friday';
            break;
          case '6':
            day = 'Saturday';
            break;
          case '7':
            day = 'Sunday';
            break;
        }

        if (day != null) {
          coursesByDay[day]!.add(epicCourse);
        }
      }
    }

    return coursesByDay;
  }
}
