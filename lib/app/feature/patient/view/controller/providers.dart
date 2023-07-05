import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/models/patient_model.dart';
import '../../../../core/repositories/providers.dart';
import '../../../../data/b4a/entity/patient_entity.dart';

part 'providers.g.dart';

@riverpod
FutureOr<PatientModel?> patientRead(PatientReadRef ref,
    {required String id}) async {
  final patient = await ref.read(patientRepositoryProvider).readById(id, cols: {
    '${PatientEntity.className}.cols': [
      PatientEntity.name,
      PatientEntity.email,
      PatientEntity.nickname,
      PatientEntity.cpf,
      PatientEntity.phone,
      PatientEntity.isFemale,
      PatientEntity.birthday,
      PatientEntity.address,
      PatientEntity.region,
      PatientEntity.family,
      PatientEntity.healthPlans,
    ],
    '${PatientEntity.className}.pointers': [PatientEntity.region],
  });
  return patient;
}
