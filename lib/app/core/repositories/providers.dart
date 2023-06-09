import '../../data/b4a/table/user_b4a.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'anamnese_answer_repository.dart';
import 'anamnese_group_repository.dart';
import 'anamnese_people_repository.dart';
import 'anamnese_question_repository.dart';
import 'anamnese_repository.dart';
import 'attendance_repository.dart';
import 'event_repository.dart';
import 'expertise_repository.dart';
import 'healthplan_repository.dart';
import 'healthplantype_repository.dart';
import 'log_repository.dart';
import 'office_repository.dart';
import 'patient_repository.dart';
import 'procedure_repository.dart';
import 'region_repository.dart';
import 'room_repository.dart';
import 'shared_repository.dart';
import 'status_repository.dart';
import 'user_profile_repository.dart';
import 'user_repository.dart';

part 'providers.g.dart';

@riverpod
UserB4a userB4a(UserB4aRef ref) {
  return UserB4a();
}

@riverpod
UserRepository userRepository(UserRepositoryRef ref) {
  return UserRepository(userB4a: ref.read(userB4aProvider));
}

@riverpod
UserProfileRepository userProfileRepository(UserProfileRepositoryRef ref) {
  return UserProfileRepository();
}

@riverpod
StatusRepository statusRepository(StatusRepositoryRef ref) {
  return StatusRepository();
}

@riverpod
RoomRepository roomRepository(RoomRepositoryRef ref) {
  return RoomRepository();
}

@riverpod
RegionRepository regionRepository(RegionRepositoryRef ref) {
  return RegionRepository();
}

@riverpod
ProcedureRepository procedureRepository(ProcedureRepositoryRef ref) {
  return ProcedureRepository();
}

@riverpod
PatientRepository patientRepository(PatientRepositoryRef ref) {
  return PatientRepository();
}

@riverpod
OfficeRepository officeRepository(OfficeRepositoryRef ref) {
  return OfficeRepository();
}

@riverpod
HealthPlanTypeRepository healthPlanTypeRepository(
    HealthPlanTypeRepositoryRef ref) {
  return HealthPlanTypeRepository();
}

@riverpod
HealthPlanRepository healthPlanRepository(HealthPlanRepositoryRef ref) {
  return HealthPlanRepository();
}

@riverpod
ExpertiseRepository expertiseRepository(ExpertiseRepositoryRef ref) {
  return ExpertiseRepository();
}

@riverpod
EventRepository eventRepository(EventRepositoryRef ref) {
  return EventRepository();
}

@riverpod
AttendanceRepository attendanceRepository(AttendanceRepositoryRef ref) {
  return AttendanceRepository();
}

@riverpod
AnamneseGroupRepository anamneseGroupRepository(
    AnamneseGroupRepositoryRef ref) {
  return AnamneseGroupRepository();
}

@riverpod
AnamneseQuestionRepository anamneseQuestionRepository(
    AnamneseQuestionRepositoryRef ref) {
  return AnamneseQuestionRepository();
}

@riverpod
AnamneseRepository anamneseRepository(AnamneseRepositoryRef ref) {
  return AnamneseRepository();
}

@riverpod
AnamnesePeopleRepository anamnesePeopleRepository(
    AnamnesePeopleRepositoryRef ref) {
  return AnamnesePeopleRepository();
}

@riverpod
AnamneseAnswerRepository anamneseAnswerRepository(
    AnamneseAnswerRepositoryRef ref) {
  return AnamneseAnswerRepository();
}

@riverpod
SharedRepository sharedRepository(SharedRepositoryRef ref) {
  return SharedRepository();
}

@riverpod
LogRepository logRepository(LogRepositoryRef ref) {
  return LogRepository();
}
