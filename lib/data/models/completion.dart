import 'package:freezed_annotation/freezed_annotation.dart';

part 'completion.freezed.dart';
part 'completion.g.dart';

@freezed
sealed class Completion with _$Completion {
  const factory Completion({
    required String id,
    required String habitId,
    required DateTime completedAt,
    @Default(0) int xpEarned,
  }) = _Completion;

  factory Completion.fromJson(Map<String, dynamic> json) =>
      _$CompletionFromJson(json);
}
