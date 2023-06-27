import 'package:freezed_annotation/freezed_annotation.dart';

import 'patient_model.dart';
import 'user_profile_model.dart';

part 'shared_model.freezed.dart';

@freezed
abstract class SharedModel with _$SharedModel {
  factory SharedModel({
    String? id,
    DateTime? createdAt,
    UserProfileModel? professional,
    PatientModel? patient,
    String? history,
    String? document,
  }) = _SharedModel;
}
