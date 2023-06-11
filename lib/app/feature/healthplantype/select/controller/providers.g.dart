// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$healthPlanTypeSelectHash() =>
    r'ff06cd999d52d3b89155ae74a3ef22be5278e150';

/// See also [healthPlanTypeSelect].
@ProviderFor(healthPlanTypeSelect)
final healthPlanTypeSelectProvider =
    FutureProvider<List<HealthPlanTypeModel>>.internal(
  healthPlanTypeSelect,
  name: r'healthPlanTypeSelectProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$healthPlanTypeSelectHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef HealthPlanTypeSelectRef = FutureProviderRef<List<HealthPlanTypeModel>>;
String _$healthPlanTypeSelectedHash() =>
    r'5c7cba5eafab255f8ea3db4e902f85f3440c37db';

/// See also [HealthPlanTypeSelected].
@ProviderFor(HealthPlanTypeSelected)
final healthPlanTypeSelectedProvider = AutoDisposeNotifierProvider<
    HealthPlanTypeSelected, List<HealthPlanTypeModel>>.internal(
  HealthPlanTypeSelected.new,
  name: r'healthPlanTypeSelectedProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$healthPlanTypeSelectedHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$HealthPlanTypeSelected
    = AutoDisposeNotifier<List<HealthPlanTypeModel>>;
// ignore_for_file: unnecessary_raw_strings, subtype_of_sealed_class, invalid_use_of_internal_member, do_not_use_environment, prefer_const_constructors, public_member_api_docs, avoid_private_typedef_functions
