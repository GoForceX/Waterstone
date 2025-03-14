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

class PhysicsExperimentAppointment {
  PhysicsExperimentAppointment({
    required this.roomTestNum,
    required this.courseId,
    required this.sessionName,
    required this.courseName,
    required this.userName,
    required this.weekNum,
    required this.roomName,
    required this.startTime,
    required this.isWithdraw,
    required this.weekDay,
    required this.id,
    required this.planId,
    required this.status,
  });

  final int roomTestNum;
  final int courseId;
  final String sessionName;
  final String courseName;
  final String userName;
  final int weekNum;
  final String roomName;
  final String startTime;
  final int isWithdraw;
  final int weekDay;
  final int id;
  final int planId;
  final int status;

  factory PhysicsExperimentAppointment.fromJson(Map<String, dynamic> json) {
    return PhysicsExperimentAppointment(
      roomTestNum: json['room_test_num'],
      courseId: json['course_id'],
      sessionName: json['session_name'],
      courseName: json['course_name'],
      userName: json['user_name'],
      weekNum: json['week_num'],
      roomName: json['room_name'],
      startTime: json['start_time'],
      isWithdraw: json['isWithdraw'],
      weekDay: json['week_day'],
      id: json['id'],
      planId: json['plan_id'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['room_test_num'] = roomTestNum;
    data['course_id'] = courseId;
    data['session_name'] = sessionName;
    data['course_name'] = courseName;
    data['user_name'] = userName;
    data['week_num'] = weekNum;
    data['room_name'] = roomName;
    data['start_time'] = startTime;
    data['isWithdraw'] = isWithdraw;
    data['week_day'] = weekDay;
    data['id'] = id;
    data['plan_id'] = planId;
    data['status'] = status;
    return data;
  }
}
