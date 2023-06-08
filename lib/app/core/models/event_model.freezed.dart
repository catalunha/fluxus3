// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'event_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$EventModel {
  String? get id => throw _privateConstructorUsedError;
  List<AttendanceModel>? get attendances => throw _privateConstructorUsedError;
  String? get attendanceBrief => throw _privateConstructorUsedError;
  RoomModel? get room => throw _privateConstructorUsedError;
  StatusModel? get status => throw _privateConstructorUsedError;
  DateTime? get start => throw _privateConstructorUsedError;
  DateTime? get end => throw _privateConstructorUsedError;
  String? get history => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $EventModelCopyWith<EventModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EventModelCopyWith<$Res> {
  factory $EventModelCopyWith(
          EventModel value, $Res Function(EventModel) then) =
      _$EventModelCopyWithImpl<$Res, EventModel>;
  @useResult
  $Res call(
      {String? id,
      List<AttendanceModel>? attendances,
      String? attendanceBrief,
      RoomModel? room,
      StatusModel? status,
      DateTime? start,
      DateTime? end,
      String? history});

  $RoomModelCopyWith<$Res>? get room;
  $StatusModelCopyWith<$Res>? get status;
}

/// @nodoc
class _$EventModelCopyWithImpl<$Res, $Val extends EventModel>
    implements $EventModelCopyWith<$Res> {
  _$EventModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? attendances = freezed,
    Object? attendanceBrief = freezed,
    Object? room = freezed,
    Object? status = freezed,
    Object? start = freezed,
    Object? end = freezed,
    Object? history = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      attendances: freezed == attendances
          ? _value.attendances
          : attendances // ignore: cast_nullable_to_non_nullable
              as List<AttendanceModel>?,
      attendanceBrief: freezed == attendanceBrief
          ? _value.attendanceBrief
          : attendanceBrief // ignore: cast_nullable_to_non_nullable
              as String?,
      room: freezed == room
          ? _value.room
          : room // ignore: cast_nullable_to_non_nullable
              as RoomModel?,
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as StatusModel?,
      start: freezed == start
          ? _value.start
          : start // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      end: freezed == end
          ? _value.end
          : end // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      history: freezed == history
          ? _value.history
          : history // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $RoomModelCopyWith<$Res>? get room {
    if (_value.room == null) {
      return null;
    }

    return $RoomModelCopyWith<$Res>(_value.room!, (value) {
      return _then(_value.copyWith(room: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $StatusModelCopyWith<$Res>? get status {
    if (_value.status == null) {
      return null;
    }

    return $StatusModelCopyWith<$Res>(_value.status!, (value) {
      return _then(_value.copyWith(status: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_EventModelCopyWith<$Res>
    implements $EventModelCopyWith<$Res> {
  factory _$$_EventModelCopyWith(
          _$_EventModel value, $Res Function(_$_EventModel) then) =
      __$$_EventModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? id,
      List<AttendanceModel>? attendances,
      String? attendanceBrief,
      RoomModel? room,
      StatusModel? status,
      DateTime? start,
      DateTime? end,
      String? history});

  @override
  $RoomModelCopyWith<$Res>? get room;
  @override
  $StatusModelCopyWith<$Res>? get status;
}

/// @nodoc
class __$$_EventModelCopyWithImpl<$Res>
    extends _$EventModelCopyWithImpl<$Res, _$_EventModel>
    implements _$$_EventModelCopyWith<$Res> {
  __$$_EventModelCopyWithImpl(
      _$_EventModel _value, $Res Function(_$_EventModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? attendances = freezed,
    Object? attendanceBrief = freezed,
    Object? room = freezed,
    Object? status = freezed,
    Object? start = freezed,
    Object? end = freezed,
    Object? history = freezed,
  }) {
    return _then(_$_EventModel(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      attendances: freezed == attendances
          ? _value._attendances
          : attendances // ignore: cast_nullable_to_non_nullable
              as List<AttendanceModel>?,
      attendanceBrief: freezed == attendanceBrief
          ? _value.attendanceBrief
          : attendanceBrief // ignore: cast_nullable_to_non_nullable
              as String?,
      room: freezed == room
          ? _value.room
          : room // ignore: cast_nullable_to_non_nullable
              as RoomModel?,
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as StatusModel?,
      start: freezed == start
          ? _value.start
          : start // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      end: freezed == end
          ? _value.end
          : end // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      history: freezed == history
          ? _value.history
          : history // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$_EventModel implements _EventModel {
  _$_EventModel(
      {this.id,
      final List<AttendanceModel>? attendances,
      this.attendanceBrief,
      this.room,
      this.status,
      this.start,
      this.end,
      this.history})
      : _attendances = attendances;

  @override
  final String? id;
  final List<AttendanceModel>? _attendances;
  @override
  List<AttendanceModel>? get attendances {
    final value = _attendances;
    if (value == null) return null;
    if (_attendances is EqualUnmodifiableListView) return _attendances;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final String? attendanceBrief;
  @override
  final RoomModel? room;
  @override
  final StatusModel? status;
  @override
  final DateTime? start;
  @override
  final DateTime? end;
  @override
  final String? history;

  @override
  String toString() {
    return 'EventModel(id: $id, attendances: $attendances, attendanceBrief: $attendanceBrief, room: $room, status: $status, start: $start, end: $end, history: $history)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_EventModel &&
            (identical(other.id, id) || other.id == id) &&
            const DeepCollectionEquality()
                .equals(other._attendances, _attendances) &&
            (identical(other.attendanceBrief, attendanceBrief) ||
                other.attendanceBrief == attendanceBrief) &&
            (identical(other.room, room) || other.room == room) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.start, start) || other.start == start) &&
            (identical(other.end, end) || other.end == end) &&
            (identical(other.history, history) || other.history == history));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      const DeepCollectionEquality().hash(_attendances),
      attendanceBrief,
      room,
      status,
      start,
      end,
      history);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_EventModelCopyWith<_$_EventModel> get copyWith =>
      __$$_EventModelCopyWithImpl<_$_EventModel>(this, _$identity);
}

abstract class _EventModel implements EventModel {
  factory _EventModel(
      {final String? id,
      final List<AttendanceModel>? attendances,
      final String? attendanceBrief,
      final RoomModel? room,
      final StatusModel? status,
      final DateTime? start,
      final DateTime? end,
      final String? history}) = _$_EventModel;

  @override
  String? get id;
  @override
  List<AttendanceModel>? get attendances;
  @override
  String? get attendanceBrief;
  @override
  RoomModel? get room;
  @override
  StatusModel? get status;
  @override
  DateTime? get start;
  @override
  DateTime? get end;
  @override
  String? get history;
  @override
  @JsonKey(ignore: true)
  _$$_EventModelCopyWith<_$_EventModel> get copyWith =>
      throw _privateConstructorUsedError;
}
