// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$userProfileSelectHash() => r'4500c03f18afcbc895461985bd22afa1b961f66a';

/// See also [userProfileSelect].
@ProviderFor(userProfileSelect)
final userProfileSelectProvider =
    AutoDisposeFutureProvider<List<UserProfileModel>>.internal(
  userProfileSelect,
  name: r'userProfileSelectProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$userProfileSelectHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef UserProfileSelectRef
    = AutoDisposeFutureProviderRef<List<UserProfileModel>>;
String _$userProfileSelectedHash() =>
    r'3200cbbe95dba09fb12b29a048ef6187271016c2';

/// See also [UserProfileSelected].
@ProviderFor(UserProfileSelected)
final userProfileSelectedProvider = AutoDisposeNotifierProvider<
    UserProfileSelected, List<UserProfileModel>>.internal(
  UserProfileSelected.new,
  name: r'userProfileSelectedProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$userProfileSelectedHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$UserProfileSelected = AutoDisposeNotifier<List<UserProfileModel>>;
// ignore_for_file: unnecessary_raw_strings, subtype_of_sealed_class, invalid_use_of_internal_member, do_not_use_environment, prefer_const_constructors, public_member_api_docs, avoid_private_typedef_functions
