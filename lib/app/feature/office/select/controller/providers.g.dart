// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$officeSelectHash() => r'f226355b42512d66a7d3ffc51f12c1f970bfaada';

/// See also [officeSelect].
@ProviderFor(officeSelect)
final officeSelectProvider =
    AutoDisposeFutureProvider<List<OfficeModel>>.internal(
  officeSelect,
  name: r'officeSelectProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$officeSelectHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef OfficeSelectRef = AutoDisposeFutureProviderRef<List<OfficeModel>>;
String _$officeSelectedHash() => r'd63687112c76b93b7ed61e555400b4f2b2e25055';

/// See also [OfficeSelected].
@ProviderFor(OfficeSelected)
final officeSelectedProvider =
    AutoDisposeNotifierProvider<OfficeSelected, List<OfficeModel>>.internal(
  OfficeSelected.new,
  name: r'officeSelectedProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$officeSelectedHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$OfficeSelected = AutoDisposeNotifier<List<OfficeModel>>;
// ignore_for_file: unnecessary_raw_strings, subtype_of_sealed_class, invalid_use_of_internal_member, do_not_use_environment, prefer_const_constructors, public_member_api_docs, avoid_private_typedef_functions
