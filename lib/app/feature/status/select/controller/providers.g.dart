// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$statusSelectHash() => r'18bbe2ab287a5aebfee5ae4f8b2f072328ff792a';

/// See also [statusSelect].
@ProviderFor(statusSelect)
final statusSelectProvider = FutureProvider<List<StatusModel>>.internal(
  statusSelect,
  name: r'statusSelectProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$statusSelectHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef StatusSelectRef = FutureProviderRef<List<StatusModel>>;
String _$statusSelectedHash() => r'f73ee5befc19c1355c0b0ad47d991f7ec19cb647';

/// See also [StatusSelected].
@ProviderFor(StatusSelected)
final statusSelectedProvider =
    AutoDisposeNotifierProvider<StatusSelected, List<StatusModel>>.internal(
  StatusSelected.new,
  name: r'statusSelectedProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$statusSelectedHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$StatusSelected = AutoDisposeNotifier<List<StatusModel>>;
// ignore_for_file: unnecessary_raw_strings, subtype_of_sealed_class, invalid_use_of_internal_member, do_not_use_environment, prefer_const_constructors, public_member_api_docs, avoid_private_typedef_functions
