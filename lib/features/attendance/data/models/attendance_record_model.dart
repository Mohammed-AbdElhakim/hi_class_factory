class AttendanceRecordModel {
  final int? acNo;
  final String? name;
  final String? date;
  final String? timetable;
  final String? onDuty;
  final String? offDuty;
  final String? clockIn;
  final String? clockOut;
  final double? normal;
  final double? realTime;
  final String? late;
  final String? early;
  final String? absent;
  final String? otTime;
  final String? workTime;
  final double? nDays;
  final String? attTime;
  final double? nDaysOt;

  AttendanceRecordModel({
    this.acNo,
    this.name,
    this.date,
    this.timetable,
    this.onDuty,
    this.offDuty,
    this.clockIn,
    this.clockOut,
    this.normal,
    this.realTime,
    this.late,
    this.early,
    this.absent,
    this.otTime,
    this.workTime,
    this.nDays,
    this.attTime,
    this.nDaysOt,
  });

  factory AttendanceRecordModel.fromJson(Map<String, dynamic> json) {
    return AttendanceRecordModel(
      acNo: json['AC-No.'] != null
          ? (json['AC-No.'] is double
                ? (json['AC-No.'] as double).toInt()
                : int.tryParse(json['AC-No.'].toString()))
          : null,
      name: json['Name'],
      date: json['Date'],
      timetable: json['Timetable'],
      onDuty: json['On duty'],
      offDuty: json['Off duty'],
      clockIn: json['Clock In'],
      clockOut: json['Clock Out'],
      normal: json['Normal'] != null ? double.tryParse(json['Normal'].toString()) : null,
      realTime: json['Real time'] != null
          ? double.tryParse(json['Real time'].toString())
          : null,
      late: json['Late'],
      early: json['Early'],
      absent: json['Absent'],
      otTime: json['OT Time'],
      workTime: json['Work Time'],
      nDays: json['NDays'] != null ? double.tryParse(json['NDays'].toString()) : null,
      attTime: json['ATT_Time'],
      nDaysOt: json['NDays_OT'] != null
          ? double.tryParse(json['NDays_OT'].toString())
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'AC-No.': acNo,
      'Name': name,
      'Date': date,
      'Timetable': timetable,
      'On duty': onDuty,
      'Off duty': offDuty,
      'Clock In': clockIn,
      'Clock Out': clockOut,
      'Normal': normal,
      'Real time': realTime,
      'Late': late,
      'Early': early,
      'Absent': absent,
      'OT Time': otTime,
      'Work Time': workTime,
      'NDays': nDays,
      'ATT_Time': attTime,
      'NDays_OT': nDaysOt,
    };
  }

  // Copy with method
  AttendanceRecordModel copyWith({
    int? acNo,
    String? name,
    String? date,
    String? timetable,
    String? onDuty,
    String? offDuty,
    String? clockIn,
    String? clockOut,
    double? normal,
    double? realTime,
    String? late,
    String? early,
    String? absent,
    String? otTime,
    String? workTime,
    double? nDays,
    String? attTime,
    double? nDaysOt,
  }) {
    return AttendanceRecordModel(
      acNo: acNo ?? this.acNo,
      name: name ?? this.name,
      date: date ?? this.date,
      timetable: timetable ?? this.timetable,
      onDuty: onDuty ?? this.onDuty,
      offDuty: offDuty ?? this.offDuty,
      clockIn: clockIn ?? this.clockIn,
      clockOut: clockOut ?? this.clockOut,
      normal: normal ?? this.normal,
      realTime: realTime ?? this.realTime,
      late: late ?? this.late,
      early: early ?? this.early,
      absent: absent ?? this.absent,
      otTime: otTime ?? this.otTime,
      workTime: workTime ?? this.workTime,
      nDays: nDays ?? this.nDays,
      attTime: attTime ?? this.attTime,
      nDaysOt: nDaysOt ?? this.nDaysOt,
    );
  }

  @override
  String toString() {
    return 'AttendanceRecordModel(acNo: $acNo, name: $name, date: $date, timetable: $timetable)';
  }
}
