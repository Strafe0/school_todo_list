// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'task_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

TaskDto _$TaskDtoFromJson(Map<String, dynamic> json) {
  return _TaskDto.fromJson(json);
}

/// @nodoc
mixin _$TaskDto {
  String get id => throw _privateConstructorUsedError;
  String get text => throw _privateConstructorUsedError;
  String get importance => throw _privateConstructorUsedError;
  int? get deadline => throw _privateConstructorUsedError;
  bool get done => throw _privateConstructorUsedError;
  String? get color => throw _privateConstructorUsedError;
  @JsonKey(name: "created_at")
  int get createdAt => throw _privateConstructorUsedError;
  @JsonKey(name: "changed_at")
  int get changedAt => throw _privateConstructorUsedError;
  @JsonKey(name: "last_updated_by")
  String get lastUpdatedBy => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TaskDtoCopyWith<TaskDto> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TaskDtoCopyWith<$Res> {
  factory $TaskDtoCopyWith(TaskDto value, $Res Function(TaskDto) then) =
      _$TaskDtoCopyWithImpl<$Res, TaskDto>;
  @useResult
  $Res call(
      {String id,
      String text,
      String importance,
      int? deadline,
      bool done,
      String? color,
      @JsonKey(name: "created_at") int createdAt,
      @JsonKey(name: "changed_at") int changedAt,
      @JsonKey(name: "last_updated_by") String lastUpdatedBy});
}

/// @nodoc
class _$TaskDtoCopyWithImpl<$Res, $Val extends TaskDto>
    implements $TaskDtoCopyWith<$Res> {
  _$TaskDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? text = null,
    Object? importance = null,
    Object? deadline = freezed,
    Object? done = null,
    Object? color = freezed,
    Object? createdAt = null,
    Object? changedAt = null,
    Object? lastUpdatedBy = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      text: null == text
          ? _value.text
          : text // ignore: cast_nullable_to_non_nullable
              as String,
      importance: null == importance
          ? _value.importance
          : importance // ignore: cast_nullable_to_non_nullable
              as String,
      deadline: freezed == deadline
          ? _value.deadline
          : deadline // ignore: cast_nullable_to_non_nullable
              as int?,
      done: null == done
          ? _value.done
          : done // ignore: cast_nullable_to_non_nullable
              as bool,
      color: freezed == color
          ? _value.color
          : color // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as int,
      changedAt: null == changedAt
          ? _value.changedAt
          : changedAt // ignore: cast_nullable_to_non_nullable
              as int,
      lastUpdatedBy: null == lastUpdatedBy
          ? _value.lastUpdatedBy
          : lastUpdatedBy // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TaskDtoImplCopyWith<$Res> implements $TaskDtoCopyWith<$Res> {
  factory _$$TaskDtoImplCopyWith(
          _$TaskDtoImpl value, $Res Function(_$TaskDtoImpl) then) =
      __$$TaskDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String text,
      String importance,
      int? deadline,
      bool done,
      String? color,
      @JsonKey(name: "created_at") int createdAt,
      @JsonKey(name: "changed_at") int changedAt,
      @JsonKey(name: "last_updated_by") String lastUpdatedBy});
}

/// @nodoc
class __$$TaskDtoImplCopyWithImpl<$Res>
    extends _$TaskDtoCopyWithImpl<$Res, _$TaskDtoImpl>
    implements _$$TaskDtoImplCopyWith<$Res> {
  __$$TaskDtoImplCopyWithImpl(
      _$TaskDtoImpl _value, $Res Function(_$TaskDtoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? text = null,
    Object? importance = null,
    Object? deadline = freezed,
    Object? done = null,
    Object? color = freezed,
    Object? createdAt = null,
    Object? changedAt = null,
    Object? lastUpdatedBy = null,
  }) {
    return _then(_$TaskDtoImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      text: null == text
          ? _value.text
          : text // ignore: cast_nullable_to_non_nullable
              as String,
      importance: null == importance
          ? _value.importance
          : importance // ignore: cast_nullable_to_non_nullable
              as String,
      deadline: freezed == deadline
          ? _value.deadline
          : deadline // ignore: cast_nullable_to_non_nullable
              as int?,
      done: null == done
          ? _value.done
          : done // ignore: cast_nullable_to_non_nullable
              as bool,
      color: freezed == color
          ? _value.color
          : color // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as int,
      changedAt: null == changedAt
          ? _value.changedAt
          : changedAt // ignore: cast_nullable_to_non_nullable
              as int,
      lastUpdatedBy: null == lastUpdatedBy
          ? _value.lastUpdatedBy
          : lastUpdatedBy // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TaskDtoImpl extends _TaskDto {
  const _$TaskDtoImpl(
      {required this.id,
      required this.text,
      required this.importance,
      this.deadline,
      required this.done,
      this.color,
      @JsonKey(name: "created_at") required this.createdAt,
      @JsonKey(name: "changed_at") required this.changedAt,
      @JsonKey(name: "last_updated_by") required this.lastUpdatedBy})
      : super._();

  factory _$TaskDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$TaskDtoImplFromJson(json);

  @override
  final String id;
  @override
  final String text;
  @override
  final String importance;
  @override
  final int? deadline;
  @override
  final bool done;
  @override
  final String? color;
  @override
  @JsonKey(name: "created_at")
  final int createdAt;
  @override
  @JsonKey(name: "changed_at")
  final int changedAt;
  @override
  @JsonKey(name: "last_updated_by")
  final String lastUpdatedBy;

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TaskDtoImplCopyWith<_$TaskDtoImpl> get copyWith =>
      __$$TaskDtoImplCopyWithImpl<_$TaskDtoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TaskDtoImplToJson(
      this,
    );
  }
}

abstract class _TaskDto extends TaskDto {
  const factory _TaskDto(
      {required final String id,
      required final String text,
      required final String importance,
      final int? deadline,
      required final bool done,
      final String? color,
      @JsonKey(name: "created_at") required final int createdAt,
      @JsonKey(name: "changed_at") required final int changedAt,
      @JsonKey(name: "last_updated_by")
      required final String lastUpdatedBy}) = _$TaskDtoImpl;
  const _TaskDto._() : super._();

  factory _TaskDto.fromJson(Map<String, dynamic> json) = _$TaskDtoImpl.fromJson;

  @override
  String get id;
  @override
  String get text;
  @override
  String get importance;
  @override
  int? get deadline;
  @override
  bool get done;
  @override
  String? get color;
  @override
  @JsonKey(name: "created_at")
  int get createdAt;
  @override
  @JsonKey(name: "changed_at")
  int get changedAt;
  @override
  @JsonKey(name: "last_updated_by")
  String get lastUpdatedBy;
  @override
  @JsonKey(ignore: true)
  _$$TaskDtoImplCopyWith<_$TaskDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
