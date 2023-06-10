// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$regionSelectHash() => r'54e67c3a3aba5b3fc1b31d16d5df60d2c5b1accd';

/// See also [regionSelect].
@ProviderFor(regionSelect)
final regionSelectProvider = FutureProvider<List<RegionModel>>.internal(
  regionSelect,
  name: r'regionSelectProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$regionSelectHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef RegionSelectRef = FutureProviderRef<List<RegionModel>>;
String _$regionSelectedHash() => r'961c9d16b44de359e7d58642ae983d3250261921';

/// See also [RegionSelected].
@ProviderFor(RegionSelected)
final regionSelectedProvider =
    AutoDisposeNotifierProvider<RegionSelected, List<RegionModel>>.internal(
  RegionSelected.new,
  name: r'regionSelectedProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$regionSelectedHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$RegionSelected = AutoDisposeNotifier<List<RegionModel>>;
// ignore_for_file: unnecessary_raw_strings, subtype_of_sealed_class, invalid_use_of_internal_member, do_not_use_environment, prefer_const_constructors, public_member_api_docs, avoid_private_typedef_functions
