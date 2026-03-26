// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'completion.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Completion {

 String get id; String get habitId; DateTime get completedAt; int get xpEarned;
/// Create a copy of Completion
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CompletionCopyWith<Completion> get copyWith => _$CompletionCopyWithImpl<Completion>(this as Completion, _$identity);

  /// Serializes this Completion to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Completion&&(identical(other.id, id) || other.id == id)&&(identical(other.habitId, habitId) || other.habitId == habitId)&&(identical(other.completedAt, completedAt) || other.completedAt == completedAt)&&(identical(other.xpEarned, xpEarned) || other.xpEarned == xpEarned));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,habitId,completedAt,xpEarned);

@override
String toString() {
  return 'Completion(id: $id, habitId: $habitId, completedAt: $completedAt, xpEarned: $xpEarned)';
}


}

/// @nodoc
abstract mixin class $CompletionCopyWith<$Res>  {
  factory $CompletionCopyWith(Completion value, $Res Function(Completion) _then) = _$CompletionCopyWithImpl;
@useResult
$Res call({
 String id, String habitId, DateTime completedAt, int xpEarned
});




}
/// @nodoc
class _$CompletionCopyWithImpl<$Res>
    implements $CompletionCopyWith<$Res> {
  _$CompletionCopyWithImpl(this._self, this._then);

  final Completion _self;
  final $Res Function(Completion) _then;

/// Create a copy of Completion
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? habitId = null,Object? completedAt = null,Object? xpEarned = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,habitId: null == habitId ? _self.habitId : habitId // ignore: cast_nullable_to_non_nullable
as String,completedAt: null == completedAt ? _self.completedAt : completedAt // ignore: cast_nullable_to_non_nullable
as DateTime,xpEarned: null == xpEarned ? _self.xpEarned : xpEarned // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [Completion].
extension CompletionPatterns on Completion {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Completion value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Completion() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Completion value)  $default,){
final _that = this;
switch (_that) {
case _Completion():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Completion value)?  $default,){
final _that = this;
switch (_that) {
case _Completion() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String habitId,  DateTime completedAt,  int xpEarned)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Completion() when $default != null:
return $default(_that.id,_that.habitId,_that.completedAt,_that.xpEarned);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String habitId,  DateTime completedAt,  int xpEarned)  $default,) {final _that = this;
switch (_that) {
case _Completion():
return $default(_that.id,_that.habitId,_that.completedAt,_that.xpEarned);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String habitId,  DateTime completedAt,  int xpEarned)?  $default,) {final _that = this;
switch (_that) {
case _Completion() when $default != null:
return $default(_that.id,_that.habitId,_that.completedAt,_that.xpEarned);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Completion implements Completion {
  const _Completion({required this.id, required this.habitId, required this.completedAt, this.xpEarned = 0});
  factory _Completion.fromJson(Map<String, dynamic> json) => _$CompletionFromJson(json);

@override final  String id;
@override final  String habitId;
@override final  DateTime completedAt;
@override@JsonKey() final  int xpEarned;

/// Create a copy of Completion
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CompletionCopyWith<_Completion> get copyWith => __$CompletionCopyWithImpl<_Completion>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CompletionToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Completion&&(identical(other.id, id) || other.id == id)&&(identical(other.habitId, habitId) || other.habitId == habitId)&&(identical(other.completedAt, completedAt) || other.completedAt == completedAt)&&(identical(other.xpEarned, xpEarned) || other.xpEarned == xpEarned));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,habitId,completedAt,xpEarned);

@override
String toString() {
  return 'Completion(id: $id, habitId: $habitId, completedAt: $completedAt, xpEarned: $xpEarned)';
}


}

/// @nodoc
abstract mixin class _$CompletionCopyWith<$Res> implements $CompletionCopyWith<$Res> {
  factory _$CompletionCopyWith(_Completion value, $Res Function(_Completion) _then) = __$CompletionCopyWithImpl;
@override @useResult
$Res call({
 String id, String habitId, DateTime completedAt, int xpEarned
});




}
/// @nodoc
class __$CompletionCopyWithImpl<$Res>
    implements _$CompletionCopyWith<$Res> {
  __$CompletionCopyWithImpl(this._self, this._then);

  final _Completion _self;
  final $Res Function(_Completion) _then;

/// Create a copy of Completion
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? habitId = null,Object? completedAt = null,Object? xpEarned = null,}) {
  return _then(_Completion(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,habitId: null == habitId ? _self.habitId : habitId // ignore: cast_nullable_to_non_nullable
as String,completedAt: null == completedAt ? _self.completedAt : completedAt // ignore: cast_nullable_to_non_nullable
as DateTime,xpEarned: null == xpEarned ? _self.xpEarned : xpEarned // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
