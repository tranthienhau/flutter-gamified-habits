import 'package:freezed_annotation/freezed_annotation.dart';

part 'habit.freezed.dart';
part 'habit.g.dart';

@freezed
sealed class Habit with _$Habit {
  const factory Habit({
    required String id,
    required String name,
    required int iconCodePoint,
    required int colorValue,
    @Default(0) int order,
    @Default(true) bool isActive,
    required DateTime createdAt,
  }) = _Habit;

  factory Habit.fromJson(Map<String, dynamic> json) => _$HabitFromJson(json);
}
