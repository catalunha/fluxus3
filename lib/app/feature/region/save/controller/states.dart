import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/models/region_model.dart';

part 'states.freezed.dart';

enum RegionFormStatus { initial, loading, success, error }

@freezed
abstract class RegionFormState with _$RegionFormState {
  factory RegionFormState({
    @Default(RegionFormStatus.initial) RegionFormStatus status,
    @Default('') String error,
    RegionModel? model,
  }) = _RegionFormState;
}
