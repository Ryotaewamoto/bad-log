// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'score.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Score _$ScoreFromJson(Map<String, dynamic> json) {
  return _Score.fromJson(json);
}

/// @nodoc
mixin _$Score {
  String get scoreId => throw _privateConstructorUsedError;
  List<int> get yours => throw _privateConstructorUsedError;
  List<int> get opponents => throw _privateConstructorUsedError;
  bool get isWinner => throw _privateConstructorUsedError;
  String get comment => throw _privateConstructorUsedError;
  @alwaysUseServerTimestampUnionTimestampConverter
  UnionTimestamp get createdAt => throw _privateConstructorUsedError;
  @alwaysUseServerTimestampUnionTimestampConverter
  UnionTimestamp get updatedAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ScoreCopyWith<Score> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ScoreCopyWith<$Res> {
  factory $ScoreCopyWith(Score value, $Res Function(Score) then) =
      _$ScoreCopyWithImpl<$Res, Score>;
  @useResult
  $Res call(
      {String scoreId,
      List<int> yours,
      List<int> opponents,
      bool isWinner,
      String comment,
      @alwaysUseServerTimestampUnionTimestampConverter
          UnionTimestamp createdAt,
      @alwaysUseServerTimestampUnionTimestampConverter
          UnionTimestamp updatedAt});

  $UnionTimestampCopyWith<$Res> get createdAt;
  $UnionTimestampCopyWith<$Res> get updatedAt;
}

/// @nodoc
class _$ScoreCopyWithImpl<$Res, $Val extends Score>
    implements $ScoreCopyWith<$Res> {
  _$ScoreCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? scoreId = null,
    Object? yours = null,
    Object? opponents = null,
    Object? isWinner = null,
    Object? comment = null,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(_value.copyWith(
      scoreId: null == scoreId
          ? _value.scoreId
          : scoreId // ignore: cast_nullable_to_non_nullable
              as String,
      yours: null == yours
          ? _value.yours
          : yours // ignore: cast_nullable_to_non_nullable
              as List<int>,
      opponents: null == opponents
          ? _value.opponents
          : opponents // ignore: cast_nullable_to_non_nullable
              as List<int>,
      isWinner: null == isWinner
          ? _value.isWinner
          : isWinner // ignore: cast_nullable_to_non_nullable
              as bool,
      comment: null == comment
          ? _value.comment
          : comment // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as UnionTimestamp,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as UnionTimestamp,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $UnionTimestampCopyWith<$Res> get createdAt {
    return $UnionTimestampCopyWith<$Res>(_value.createdAt, (value) {
      return _then(_value.copyWith(createdAt: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $UnionTimestampCopyWith<$Res> get updatedAt {
    return $UnionTimestampCopyWith<$Res>(_value.updatedAt, (value) {
      return _then(_value.copyWith(updatedAt: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_ScoreCopyWith<$Res> implements $ScoreCopyWith<$Res> {
  factory _$$_ScoreCopyWith(_$_Score value, $Res Function(_$_Score) then) =
      __$$_ScoreCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String scoreId,
      List<int> yours,
      List<int> opponents,
      bool isWinner,
      String comment,
      @alwaysUseServerTimestampUnionTimestampConverter
          UnionTimestamp createdAt,
      @alwaysUseServerTimestampUnionTimestampConverter
          UnionTimestamp updatedAt});

  @override
  $UnionTimestampCopyWith<$Res> get createdAt;
  @override
  $UnionTimestampCopyWith<$Res> get updatedAt;
}

/// @nodoc
class __$$_ScoreCopyWithImpl<$Res> extends _$ScoreCopyWithImpl<$Res, _$_Score>
    implements _$$_ScoreCopyWith<$Res> {
  __$$_ScoreCopyWithImpl(_$_Score _value, $Res Function(_$_Score) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? scoreId = null,
    Object? yours = null,
    Object? opponents = null,
    Object? isWinner = null,
    Object? comment = null,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(_$_Score(
      scoreId: null == scoreId
          ? _value.scoreId
          : scoreId // ignore: cast_nullable_to_non_nullable
              as String,
      yours: null == yours
          ? _value._yours
          : yours // ignore: cast_nullable_to_non_nullable
              as List<int>,
      opponents: null == opponents
          ? _value._opponents
          : opponents // ignore: cast_nullable_to_non_nullable
              as List<int>,
      isWinner: null == isWinner
          ? _value.isWinner
          : isWinner // ignore: cast_nullable_to_non_nullable
              as bool,
      comment: null == comment
          ? _value.comment
          : comment // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as UnionTimestamp,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as UnionTimestamp,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Score extends _Score {
  const _$_Score(
      {this.scoreId = '',
      final List<int> yours = const <int>[],
      final List<int> opponents = const <int>[],
      this.isWinner = true,
      this.comment = '',
      @alwaysUseServerTimestampUnionTimestampConverter required this.createdAt,
      @alwaysUseServerTimestampUnionTimestampConverter required this.updatedAt})
      : _yours = yours,
        _opponents = opponents,
        super._();

  factory _$_Score.fromJson(Map<String, dynamic> json) =>
      _$$_ScoreFromJson(json);

  @override
  @JsonKey()
  final String scoreId;
  final List<int> _yours;
  @override
  @JsonKey()
  List<int> get yours {
    if (_yours is EqualUnmodifiableListView) return _yours;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_yours);
  }

  final List<int> _opponents;
  @override
  @JsonKey()
  List<int> get opponents {
    if (_opponents is EqualUnmodifiableListView) return _opponents;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_opponents);
  }

  @override
  @JsonKey()
  final bool isWinner;
  @override
  @JsonKey()
  final String comment;
  @override
  @alwaysUseServerTimestampUnionTimestampConverter
  final UnionTimestamp createdAt;
  @override
  @alwaysUseServerTimestampUnionTimestampConverter
  final UnionTimestamp updatedAt;

  @override
  String toString() {
    return 'Score(scoreId: $scoreId, yours: $yours, opponents: $opponents, isWinner: $isWinner, comment: $comment, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Score &&
            (identical(other.scoreId, scoreId) || other.scoreId == scoreId) &&
            const DeepCollectionEquality().equals(other._yours, _yours) &&
            const DeepCollectionEquality()
                .equals(other._opponents, _opponents) &&
            (identical(other.isWinner, isWinner) ||
                other.isWinner == isWinner) &&
            (identical(other.comment, comment) || other.comment == comment) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      scoreId,
      const DeepCollectionEquality().hash(_yours),
      const DeepCollectionEquality().hash(_opponents),
      isWinner,
      comment,
      createdAt,
      updatedAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ScoreCopyWith<_$_Score> get copyWith =>
      __$$_ScoreCopyWithImpl<_$_Score>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ScoreToJson(
      this,
    );
  }
}

abstract class _Score extends Score {
  const factory _Score(
      {final String scoreId,
      final List<int> yours,
      final List<int> opponents,
      final bool isWinner,
      final String comment,
      @alwaysUseServerTimestampUnionTimestampConverter
          required final UnionTimestamp createdAt,
      @alwaysUseServerTimestampUnionTimestampConverter
          required final UnionTimestamp updatedAt}) = _$_Score;
  const _Score._() : super._();

  factory _Score.fromJson(Map<String, dynamic> json) = _$_Score.fromJson;

  @override
  String get scoreId;
  @override
  List<int> get yours;
  @override
  List<int> get opponents;
  @override
  bool get isWinner;
  @override
  String get comment;
  @override
  @alwaysUseServerTimestampUnionTimestampConverter
  UnionTimestamp get createdAt;
  @override
  @alwaysUseServerTimestampUnionTimestampConverter
  UnionTimestamp get updatedAt;
  @override
  @JsonKey(ignore: true)
  _$$_ScoreCopyWith<_$_Score> get copyWith =>
      throw _privateConstructorUsedError;
}
