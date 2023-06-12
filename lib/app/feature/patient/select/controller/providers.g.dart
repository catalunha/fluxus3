// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$patientSelectHash() => r'906941ea9a71522283cc1a2d288c4b455da6a1d4';

/// See also [patientSelect].
@ProviderFor(patientSelect)
final patientSelectProvider = FutureProvider<List<PatientModel>>.internal(
  patientSelect,
  name: r'patientSelectProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$patientSelectHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef PatientSelectRef = FutureProviderRef<List<PatientModel>>;
String _$patientSelectedHash() => r'0b95c9a18ce466e3591b126059eb6a0cf46f5d1b';

/// See also [PatientSelected].
@ProviderFor(PatientSelected)
final patientSelectedProvider =
    AutoDisposeNotifierProvider<PatientSelected, List<PatientModel>>.internal(
  PatientSelected.new,
  name: r'patientSelectedProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$patientSelectedHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$PatientSelected = AutoDisposeNotifier<List<PatientModel>>;
// ignore_for_file: unnecessary_raw_strings, subtype_of_sealed_class, invalid_use_of_internal_member, do_not_use_environment, prefer_const_constructors, public_member_api_docs, avoid_private_typedef_functions
