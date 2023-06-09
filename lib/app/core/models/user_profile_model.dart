import 'expertise_model.dart';
import 'office_model.dart';
import 'procedure_model.dart';
import 'region_model.dart';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_profile_model.freezed.dart';

@freezed
abstract class UserProfileModel with _$UserProfileModel {
  factory UserProfileModel({
    required String id,
    required String userName,
    required String email,
    required bool isActive,
    required List<String> access, //admin, sec, prof, fin

    String? name,
    String? nickname,
    String? cpf,
    String? register, // conselho de saude
    String? phone,
    String? photo,
    bool? isFemale,
    DateTime? birthday,
    String? address,
    RegionModel? region,
    List<OfficeModel>? offices, // cargos
    List<ExpertiseModel>? expertises, // especialidade
    List<ProcedureModel>? procedures, // procedimentos
  }) = _UserProfileModel;
}
