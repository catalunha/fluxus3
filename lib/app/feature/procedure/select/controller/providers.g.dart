// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$procedureSelectHash() => r'b0872947fe952b6974a29a02ccf5a38ce562af39';

/// See also [procedureSelect].
@ProviderFor(procedureSelect)
final procedureSelectProvider = FutureProvider<List<ProcedureModel>>.internal(
  procedureSelect,
  name: r'procedureSelectProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$procedureSelectHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef ProcedureSelectRef = FutureProviderRef<List<ProcedureModel>>;
String _$procedureSelectedHash() => r'be8c252d7f69001284fe0a01a78cf7ff547610b0';

/// See also [ProcedureSelected].
@ProviderFor(ProcedureSelected)
final procedureSelectedProvider = AutoDisposeNotifierProvider<ProcedureSelected,
    List<ProcedureModel>>.internal(
  ProcedureSelected.new,
  name: r'procedureSelectedProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$procedureSelectedHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$ProcedureSelected = AutoDisposeNotifier<List<ProcedureModel>>;
// ignore_for_file: unnecessary_raw_strings, subtype_of_sealed_class, invalid_use_of_internal_member, do_not_use_environment, prefer_const_constructors, public_member_api_docs, avoid_private_typedef_functions
