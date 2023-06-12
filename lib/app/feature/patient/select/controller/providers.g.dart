// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$patientSelectHash() => r'b30aa740128c66e3016a0fff106e2f458594616b';

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
String _$patientSelectedHash() => r'1f14e75736ac234ebd1d17a80e137a9d453b1408';

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
