// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$expertiseSelectHash() => r'e82b8acf7d1c3c15def8685bce4a502c04725f74';

/// See also [expertiseSelect].
@ProviderFor(expertiseSelect)
final expertiseSelectProvider = FutureProvider<List<ExpertiseModel>>.internal(
  expertiseSelect,
  name: r'expertiseSelectProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$expertiseSelectHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef ExpertiseSelectRef = FutureProviderRef<List<ExpertiseModel>>;
String _$expertiseSelectedHash() => r'8d7a751307d2f0ea8b9ce8ebf81cc1a7f6dcbf42';

/// See also [ExpertiseSelected].
@ProviderFor(ExpertiseSelected)
final expertiseSelectedProvider = AutoDisposeNotifierProvider<ExpertiseSelected,
    List<ExpertiseModel>>.internal(
  ExpertiseSelected.new,
  name: r'expertiseSelectedProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$expertiseSelectedHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$ExpertiseSelected = AutoDisposeNotifier<List<ExpertiseModel>>;
// ignore_for_file: unnecessary_raw_strings, subtype_of_sealed_class, invalid_use_of_internal_member, do_not_use_environment, prefer_const_constructors, public_member_api_docs, avoid_private_typedef_functions