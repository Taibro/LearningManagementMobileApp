import 'package:learning_management_app/enum/ScheduleType.dart';

class Schedule {
  final String subjectName;
  final String tiet;
  final String phong;
  final String giangVien;
  final ScheduleType type;

  const Schedule({
    required this.subjectName,
    required this.tiet,
    required this.phong,
    required this.giangVien,
    this.type = ScheduleType.lichHoc,
  });
}