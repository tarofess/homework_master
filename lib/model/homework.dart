import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:homework_master/model/result.dart';

part 'homework.freezed.dart';
part 'homework.g.dart';

@freezed
class Homework with _$Homework {
  const factory Homework({
    required int startTime,
    required Map<String, Result> result,
  }) = _Homework;

  factory Homework.fromJson(Map<String, dynamic> json) =>
      _$HomeworkFromJson(json);
}

extension HomeworkExtension on Homework {
  List<MapEntry<String, Result>> get resultsList {
    final entries = result.entries.toList();
    entries.sort((a, b) => a.value.clearTime.compareTo(b.value.clearTime));
    return entries;
  }

  String? getFormattedClearTime(int? clearTime) {
    if (clearTime == null) {
      return null;
    }
    int adjustedValue = 3000; // startTimeが記録されてタイマーが作動するまで3秒間のアニメーションがあるため
    Duration difference =
        Duration(milliseconds: clearTime - startTime - adjustedValue);
    int minutes = difference.inMinutes;
    double seconds = (difference.inMilliseconds % 60000) / 1000;
    return minutes == 0
        ? '${seconds.toStringAsFixed(2)}秒'
        : '$minutes分${seconds.toStringAsFixed(2)}秒';
  }
}
