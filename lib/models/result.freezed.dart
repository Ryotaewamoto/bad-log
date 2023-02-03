// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'result.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Result _$ResultFromJson(Map<String, dynamic> json) {
  return _Result.fromJson(json);
}

/// @nodoc
mixin _$Result {
  String get resultId => throw _privateConstructorUsedError;
  String get type => throw _privateConstructorUsedError;
  String get partner => throw _privateConstructorUsedError;
  List<String> get opponents => throw _privateConstructorUsedError;
  List<int> get yourScore => throw _privateConstructorUsedError;
  List<int> get opponentsScore => throw _privateConstructorUsedError;
  bool get isWinner => throw _privateConstructorUsedError;
  String get comment => throw _privateConstructorUsedError;
  @unionTimestampConverter
  UnionTimestamp get createdAt => throw _privateConstructorUsedError;
  @alwaysUseServerTimestampUnionTimestampConverter
  UnionTimestamp get updatedAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ResultCopyWith<Result> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ResultCopyWith<$Res> {
  factory $ResultCopyWith(Result value, $Res Function(Result) then) =
      _$ResultCopyWithImpl<$Res, Result>;
  @useResult
  $Res call(
      {String resultId,
      String type,
      String partner,
      List<String> opponents,
      List<int> yourScore,
      List<int> opponentsScore,
      bool isWinner,
      String comment,
      @unionTimestampConverter
          UnionTimestamp createdAt,
      @alwaysUseServerTimestampUnionTimestampConverter
          UnionTimestamp updatedAt});

  $UnionTimestampCopyWith<$Res> get createdAt;
  $UnionTimestampCopyWith<$Res> get updatedAt;
}

/// @nodoc
class _$ResultCopyWithImpl<$Res, $Val extends Result>
    implements $ResultCopyWith<$Res> {
  _$ResultCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? resultId = null,
    Object? type = null,
    Object? partner = null,
    Object? opponents = null,
    Object? yourScore = null,
    Object? opponentsScore = null,
    Object? isWinner = null,
    Object? comment = null,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(_value.copyWith(
      resultId: null == resultId
          ? _value.resultId
          : resultId // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      partner: null == partner
          ? _value.partner
          : partner // ignore: cast_nullable_to_non_nullable
              as String,
      opponents: null == opponents
          ? _value.opponents
          : opponents // ignore: cast_nullable_to_non_nullable
              as List<String>,
      yourScore: null == yourScore
          ? _value.yourScore
          : yourScore // ignore: cast_nullable_to_non_nullable
              as List<int>,
      opponentsScore: null == opponentsScore
          ? _value.opponentsScore
          : opponentsScore // ignore: cast_nullable_to_non_nullable
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
abstract class _$$_ResultCopyWith<$Res> implements $ResultCopyWith<$Res> {
  factory _$$_ResultCopyWith(_$_Result value, $Res Function(_$_Result) then) =
      __$$_ResultCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String resultId,
      String type,
      String partner,
      List<String> opponents,
      List<int> yourScore,
      List<int> opponentsScore,
      bool isWinner,
      String comment,
      @unionTimestampConverter
          UnionTimestamp createdAt,
      @alwaysUseServerTimestampUnionTimestampConverter
          UnionTimestamp updatedAt});

  @override
  $UnionTimestampCopyWith<$Res> get createdAt;
  @override
  $UnionTimestampCopyWith<$Res> get updatedAt;
}

/// @nodoc
class __$$_ResultCopyWithImpl<$Res>
    extends _$ResultCopyWithImpl<$Res, _$_Result>
    implements _$$_ResultCopyWith<$Res> {
  __$$_ResultCopyWithImpl(_$_Result _value, $Res Function(_$_Result) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? resultId = null,
    Object? type = null,
    Object? partner = null,
    Object? opponents = null,
    Object? yourScore = null,
    Object? opponentsScore = null,
    Object? isWinner = null,
    Object? comment = null,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(_$_Result(
      resultId: null == resultId
          ? _value.resultId
          : resultId // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      partner: null == partner
          ? _value.partner
          : partner // ignore: cast_nullable_to_non_nullable
              as String,
      opponents: null == opponents
          ? _value._opponents
          : opponents // ignore: cast_nullable_to_non_nullable
              as List<String>,
      yourScore: null == yourScore
          ? _value._yourScore
          : yourScore // ignore: cast_nullable_to_non_nullable
              as List<int>,
      opponentsScore: null == opponentsScore
          ? _value._opponentsScore
          : opponentsScore // ignore: cast_nullable_to_non_nullable
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
class _$_Result extends _Result {
  const _$_Result(
      {this.resultId = '',
      this.type = 'singles',
      this.partner = '',
      final List<String> opponents = const <String>[],
      final List<int> yourScore = const <int>[],
      final List<int> opponentsScore = const <int>[],
      this.isWinner = true,
      this.comment = '',
      @unionTimestampConverter required this.createdAt,
      @alwaysUseServerTimestampUnionTimestampConverter required this.updatedAt})
      : _opponents = opponents,
        _yourScore = yourScore,
        _opponentsScore = opponentsScore,
        super._();

  factory _$_Result.fromJson(Map<String, dynamic> json) =>
      _$$_ResultFromJson(json);

  @override
  @JsonKey()
  final String resultId;
  @override
  @JsonKey()
  final String type;
  @override
  @JsonKey()
  final String partner;
  final List<String> _opponents;
  @override
  @JsonKey()
  List<String> get opponents {
    if (_opponents is EqualUnmodifiableListView) return _opponents;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_opponents);
  }

  final List<int> _yourScore;
  @override
  @JsonKey()
  List<int> get yourScore {
    if (_yourScore is EqualUnmodifiableListView) return _yourScore;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_yourScore);
  }

  final List<int> _opponentsScore;
  @override
  @JsonKey()
  List<int> get opponentsScore {
    if (_opponentsScore is EqualUnmodifiableListView) return _opponentsScore;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_opponentsScore);
  }

  @override
  @JsonKey()
  final bool isWinner;
  @override
  @JsonKey()
  final String comment;
  @override
  @unionTimestampConverter
  final UnionTimestamp createdAt;
  @override
  @alwaysUseServerTimestampUnionTimestampConverter
  final UnionTimestamp updatedAt;

  @override
  String toString() {
    return 'Result(resultId: $resultId, type: $type, partner: $partner, opponents: $opponents, yourScore: $yourScore, opponentsScore: $opponentsScore, isWinner: $isWinner, comment: $comment, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Result &&
            (identical(other.resultId, resultId) ||
                other.resultId == resultId) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.partner, partner) || other.partner == partner) &&
            const DeepCollectionEquality()
                .equals(other._opponents, _opponents) &&
            const DeepCollectionEquality()
                .equals(other._yourScore, _yourScore) &&
            const DeepCollectionEquality()
                .equals(other._opponentsScore, _opponentsScore) &&
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
      resultId,
      type,
      partner,
      const DeepCollectionEquality().hash(_opponents),
      const DeepCollectionEquality().hash(_yourScore),
      const DeepCollectionEquality().hash(_opponentsScore),
      isWinner,
      comment,
      createdAt,
      updatedAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ResultCopyWith<_$_Result> get copyWith =>
      __$$_ResultCopyWithImpl<_$_Result>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ResultToJson(
      this,
    );
  }
}

abstract class _Result extends Result {
  const factory _Result(
      {final String resultId,
      final String type,
      final String partner,
      final List<String> opponents,
      final List<int> yourScore,
      final List<int> opponentsScore,
      final bool isWinner,
      final String comment,
      @unionTimestampConverter
          required final UnionTimestamp createdAt,
      @alwaysUseServerTimestampUnionTimestampConverter
          required final UnionTimestamp updatedAt}) = _$_Result;
  const _Result._() : super._();

  factory _Result.fromJson(Map<String, dynamic> json) = _$_Result.fromJson;

  @override
  String get resultId;
  @override
  String get type;
  @override
  String get partner;
  @override
  List<String> get opponents;
  @override
  List<int> get yourScore;
  @override
  List<int> get opponentsScore;
  @override
  bool get isWinner;
  @override
  String get comment;
  @override
  @unionTimestampConverter
  UnionTimestamp get createdAt;
  @override
  @alwaysUseServerTimestampUnionTimestampConverter
  UnionTimestamp get updatedAt;
  @override
  @JsonKey(ignore: true)
  _$$_ResultCopyWith<_$_Result> get copyWith =>
      throw _privateConstructorUsedError;
}
