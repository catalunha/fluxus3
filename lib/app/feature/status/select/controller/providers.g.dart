// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$roomSelectHash() => r'b30aa740128c66e3016a0fff106e2f458594616b';

/// See also [roomSelect].
@ProviderFor(roomSelect)
final roomSelectProvider = FutureProvider<List<RoomModel>>.internal(
  roomSelect,
  name: r'roomSelectProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$roomSelectHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef RoomSelectRef = FutureProviderRef<List<RoomModel>>;
String _$roomSelectedHash() => r'1f14e75736ac234ebd1d17a80e137a9d453b1408';

/// See also [RoomSelected].
@ProviderFor(RoomSelected)
final roomSelectedProvider =
    AutoDisposeNotifierProvider<RoomSelected, List<RoomModel>>.internal(
  RoomSelected.new,
  name: r'roomSelectedProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$roomSelectedHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$RoomSelected = AutoDisposeNotifier<List<RoomModel>>;
// ignore_for_file: unnecessary_raw_strings, subtype_of_sealed_class, invalid_use_of_internal_member, do_not_use_environment, prefer_const_constructors, public_member_api_docs, avoid_private_typedef_functions
