// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_profile.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$UserProfile {

 int get totalXp; int get currentStreak; int get longestStreak; int get totalCompletions; DateTime? get lastCompletionDate; List<String> get unlockedBadgeIds; int get freezesUsedThisWeek; DateTime? get lastFreezeReset;
/// Create a copy of UserProfile
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UserProfileCopyWith<UserProfile> get copyWith => _$UserProfileCopyWithImpl<UserProfile>(this as UserProfile, _$identity);

  /// Serializes this UserProfile to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserProfile&&(identical(other.totalXp, totalXp) || other.totalXp == totalXp)&&(identical(other.currentStreak, currentStreak) || other.currentStreak == currentStreak)&&(identical(other.longestStreak, longestStreak) || other.longestStreak == longestStreak)&&(identical(other.totalCompletions, totalCompletions) || other.totalCompletions == totalCompletions)&&(identical(other.lastCompletionDate, lastCompletionDate) || other.lastCompletionDate == lastCompletionDate)&&const DeepCollectionEquality().equals(other.unlockedBadgeIds, unlockedBadgeIds)&&(identical(other.freezesUsedThisWeek, freezesUsedThisWeek) || other.freezesUsedThisWeek == freezesUsedThisWeek)&&(identical(other.lastFreezeReset, lastFreezeReset) || other.lastFreezeReset == lastFreezeReset));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,totalXp,currentStreak,longestStreak,totalCompletions,lastCompletionDate,const DeepCollectionEquality().hash(unlockedBadgeIds),freezesUsedThisWeek,lastFreezeReset);

@override
String toString() {
  return 'UserProfile(totalXp: $totalXp, currentStreak: $currentStreak, longestStreak: $longestStreak, totalCompletions: $totalCompletions, lastCompletionDate: $lastCompletionDate, unlockedBadgeIds: $unlockedBadgeIds, freezesUsedThisWeek: $freezesUsedThisWeek, lastFreezeReset: $lastFreezeReset)';
}


}

/// @nodoc
abstract mixin class $UserProfileCopyWith<$Res>  {
  factory $UserProfileCopyWith(UserProfile value, $Res Function(UserProfile) _then) = _$UserProfileCopyWithImpl;
@useResult
$Res call({
 int totalXp, int currentStreak, int longestStreak, int totalCompletions, DateTime? lastCompletionDate, List<String> unlockedBadgeIds, int freezesUsedThisWeek, DateTime? lastFreezeReset
});




}
/// @nodoc
class _$UserProfileCopyWithImpl<$Res>
    implements $UserProfileCopyWith<$Res> {
  _$UserProfileCopyWithImpl(this._self, this._then);

  final UserProfile _self;
  final $Res Function(UserProfile) _then;

/// Create a copy of UserProfile
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? totalXp = null,Object? currentStreak = null,Object? longestStreak = null,Object? totalCompletions = null,Object? lastCompletionDate = freezed,Object? unlockedBadgeIds = null,Object? freezesUsedThisWeek = null,Object? lastFreezeReset = freezed,}) {
  return _then(_self.copyWith(
totalXp: null == totalXp ? _self.totalXp : totalXp // ignore: cast_nullable_to_non_nullable
as int,currentStreak: null == currentStreak ? _self.currentStreak : currentStreak // ignore: cast_nullable_to_non_nullable
as int,longestStreak: null == longestStreak ? _self.longestStreak : longestStreak // ignore: cast_nullable_to_non_nullable
as int,totalCompletions: null == totalCompletions ? _self.totalCompletions : totalCompletions // ignore: cast_nullable_to_non_nullable
as int,lastCompletionDate: freezed == lastCompletionDate ? _self.lastCompletionDate : lastCompletionDate // ignore: cast_nullable_to_non_nullable
as DateTime?,unlockedBadgeIds: null == unlockedBadgeIds ? _self.unlockedBadgeIds : unlockedBadgeIds // ignore: cast_nullable_to_non_nullable
as List<String>,freezesUsedThisWeek: null == freezesUsedThisWeek ? _self.freezesUsedThisWeek : freezesUsedThisWeek // ignore: cast_nullable_to_non_nullable
as int,lastFreezeReset: freezed == lastFreezeReset ? _self.lastFreezeReset : lastFreezeReset // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [UserProfile].
extension UserProfilePatterns on UserProfile {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UserProfile value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UserProfile() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UserProfile value)  $default,){
final _that = this;
switch (_that) {
case _UserProfile():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UserProfile value)?  $default,){
final _that = this;
switch (_that) {
case _UserProfile() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int totalXp,  int currentStreak,  int longestStreak,  int totalCompletions,  DateTime? lastCompletionDate,  List<String> unlockedBadgeIds,  int freezesUsedThisWeek,  DateTime? lastFreezeReset)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UserProfile() when $default != null:
return $default(_that.totalXp,_that.currentStreak,_that.longestStreak,_that.totalCompletions,_that.lastCompletionDate,_that.unlockedBadgeIds,_that.freezesUsedThisWeek,_that.lastFreezeReset);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int totalXp,  int currentStreak,  int longestStreak,  int totalCompletions,  DateTime? lastCompletionDate,  List<String> unlockedBadgeIds,  int freezesUsedThisWeek,  DateTime? lastFreezeReset)  $default,) {final _that = this;
switch (_that) {
case _UserProfile():
return $default(_that.totalXp,_that.currentStreak,_that.longestStreak,_that.totalCompletions,_that.lastCompletionDate,_that.unlockedBadgeIds,_that.freezesUsedThisWeek,_that.lastFreezeReset);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int totalXp,  int currentStreak,  int longestStreak,  int totalCompletions,  DateTime? lastCompletionDate,  List<String> unlockedBadgeIds,  int freezesUsedThisWeek,  DateTime? lastFreezeReset)?  $default,) {final _that = this;
switch (_that) {
case _UserProfile() when $default != null:
return $default(_that.totalXp,_that.currentStreak,_that.longestStreak,_that.totalCompletions,_that.lastCompletionDate,_that.unlockedBadgeIds,_that.freezesUsedThisWeek,_that.lastFreezeReset);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _UserProfile implements UserProfile {
  const _UserProfile({this.totalXp = 0, this.currentStreak = 0, this.longestStreak = 0, this.totalCompletions = 0, this.lastCompletionDate, final  List<String> unlockedBadgeIds = const [], this.freezesUsedThisWeek = 0, this.lastFreezeReset}): _unlockedBadgeIds = unlockedBadgeIds;
  factory _UserProfile.fromJson(Map<String, dynamic> json) => _$UserProfileFromJson(json);

@override@JsonKey() final  int totalXp;
@override@JsonKey() final  int currentStreak;
@override@JsonKey() final  int longestStreak;
@override@JsonKey() final  int totalCompletions;
@override final  DateTime? lastCompletionDate;
 final  List<String> _unlockedBadgeIds;
@override@JsonKey() List<String> get unlockedBadgeIds {
  if (_unlockedBadgeIds is EqualUnmodifiableListView) return _unlockedBadgeIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_unlockedBadgeIds);
}

@override@JsonKey() final  int freezesUsedThisWeek;
@override final  DateTime? lastFreezeReset;

/// Create a copy of UserProfile
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UserProfileCopyWith<_UserProfile> get copyWith => __$UserProfileCopyWithImpl<_UserProfile>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UserProfileToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UserProfile&&(identical(other.totalXp, totalXp) || other.totalXp == totalXp)&&(identical(other.currentStreak, currentStreak) || other.currentStreak == currentStreak)&&(identical(other.longestStreak, longestStreak) || other.longestStreak == longestStreak)&&(identical(other.totalCompletions, totalCompletions) || other.totalCompletions == totalCompletions)&&(identical(other.lastCompletionDate, lastCompletionDate) || other.lastCompletionDate == lastCompletionDate)&&const DeepCollectionEquality().equals(other._unlockedBadgeIds, _unlockedBadgeIds)&&(identical(other.freezesUsedThisWeek, freezesUsedThisWeek) || other.freezesUsedThisWeek == freezesUsedThisWeek)&&(identical(other.lastFreezeReset, lastFreezeReset) || other.lastFreezeReset == lastFreezeReset));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,totalXp,currentStreak,longestStreak,totalCompletions,lastCompletionDate,const DeepCollectionEquality().hash(_unlockedBadgeIds),freezesUsedThisWeek,lastFreezeReset);

@override
String toString() {
  return 'UserProfile(totalXp: $totalXp, currentStreak: $currentStreak, longestStreak: $longestStreak, totalCompletions: $totalCompletions, lastCompletionDate: $lastCompletionDate, unlockedBadgeIds: $unlockedBadgeIds, freezesUsedThisWeek: $freezesUsedThisWeek, lastFreezeReset: $lastFreezeReset)';
}


}

/// @nodoc
abstract mixin class _$UserProfileCopyWith<$Res> implements $UserProfileCopyWith<$Res> {
  factory _$UserProfileCopyWith(_UserProfile value, $Res Function(_UserProfile) _then) = __$UserProfileCopyWithImpl;
@override @useResult
$Res call({
 int totalXp, int currentStreak, int longestStreak, int totalCompletions, DateTime? lastCompletionDate, List<String> unlockedBadgeIds, int freezesUsedThisWeek, DateTime? lastFreezeReset
});




}
/// @nodoc
class __$UserProfileCopyWithImpl<$Res>
    implements _$UserProfileCopyWith<$Res> {
  __$UserProfileCopyWithImpl(this._self, this._then);

  final _UserProfile _self;
  final $Res Function(_UserProfile) _then;

/// Create a copy of UserProfile
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? totalXp = null,Object? currentStreak = null,Object? longestStreak = null,Object? totalCompletions = null,Object? lastCompletionDate = freezed,Object? unlockedBadgeIds = null,Object? freezesUsedThisWeek = null,Object? lastFreezeReset = freezed,}) {
  return _then(_UserProfile(
totalXp: null == totalXp ? _self.totalXp : totalXp // ignore: cast_nullable_to_non_nullable
as int,currentStreak: null == currentStreak ? _self.currentStreak : currentStreak // ignore: cast_nullable_to_non_nullable
as int,longestStreak: null == longestStreak ? _self.longestStreak : longestStreak // ignore: cast_nullable_to_non_nullable
as int,totalCompletions: null == totalCompletions ? _self.totalCompletions : totalCompletions // ignore: cast_nullable_to_non_nullable
as int,lastCompletionDate: freezed == lastCompletionDate ? _self.lastCompletionDate : lastCompletionDate // ignore: cast_nullable_to_non_nullable
as DateTime?,unlockedBadgeIds: null == unlockedBadgeIds ? _self._unlockedBadgeIds : unlockedBadgeIds // ignore: cast_nullable_to_non_nullable
as List<String>,freezesUsedThisWeek: null == freezesUsedThisWeek ? _self.freezesUsedThisWeek : freezesUsedThisWeek // ignore: cast_nullable_to_non_nullable
as int,lastFreezeReset: freezed == lastFreezeReset ? _self.lastFreezeReset : lastFreezeReset // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
