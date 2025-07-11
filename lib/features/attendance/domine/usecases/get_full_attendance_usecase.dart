import 'package:vitapmate/core/utils/usecase.dart';
import 'package:vitapmate/features/attendance/domine/repositories/attendance_repository.dart';
import 'package:vitapmate/src/api/vtop/types.dart';

class GetFullAttendanceUsecase implements Usecase<FullAttendanceData, void> {
  final AttendanceRepository _attendanceRepository;
  final String _courseType;
  final String _courseId;
  GetFullAttendanceUsecase(
    this._attendanceRepository,
    this._courseType,
    this._courseId,
  );
  @override
  Future<FullAttendanceData> call({void params}) async {
    var timetable = await _attendanceRepository.getFullAttendanceFromStorage(
      _courseType,
      _courseId,
    );
    return timetable;
  }
}
