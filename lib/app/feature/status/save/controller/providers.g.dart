// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$roomReadHash() => r'4136eac4b3b5549d2812c138ecfbb82bc23d67c1';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

typedef RoomReadRef = AutoDisposeFutureProviderRef<RoomModel?>;

/// See also [roomRead].
@ProviderFor(roomRead)
const roomReadProvider = RoomReadFamily();

/// See also [roomRead].
class RoomReadFamily extends Family<AsyncValue<RoomModel?>> {
  /// See also [roomRead].
  const RoomReadFamily();

  /// See also [roomRead].
  RoomReadProvider call({
    required String? id,
  }) {
    return RoomReadProvider(
      id: id,
    );
  }

  @override
  RoomReadProvider getProviderOverride(
    covariant RoomReadProvider provider,
  ) {
    return call(
      id: provider.id,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'roomReadProvider';
}

/// See also [roomRead].
class RoomReadProvider extends AutoDisposeFutureProvider<RoomModel?> {
  /// See also [roomRead].
  RoomReadProvider({
    required this.id,
  }) : super.internal(
          (ref) => roomRead(
            ref,
            id: id,
          ),
          from: roomReadProvider,
          name: r'roomReadProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$roomReadHash,
          dependencies: RoomReadFamily._dependencies,
          allTransitiveDependencies: RoomReadFamily._allTransitiveDependencies,
        );

  final String? id;

  @override
  bool operator ==(Object other) {
    return other is RoomReadProvider && other.id == id;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, id.hashCode);

    return _SystemHash.finish(hash);
  }
}

String _$roomIsActiveHash() => r'1360090ec64d08513de2a8549d787433dac5cb08';

/// See also [RoomIsActive].
@ProviderFor(RoomIsActive)
final roomIsActiveProvider =
    AutoDisposeNotifierProvider<RoomIsActive, bool>.internal(
  RoomIsActive.new,
  name: r'roomIsActiveProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$roomIsActiveHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$RoomIsActive = AutoDisposeNotifier<bool>;
String _$roomFormHash() => r'ff8b4efacd1117be7728960f9769650cf8f9c55f';

/// See also [RoomForm].
@ProviderFor(RoomForm)
final roomFormProvider =
    AutoDisposeNotifierProvider<RoomForm, RoomFormState>.internal(
  RoomForm.new,
  name: r'roomFormProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$roomFormHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$RoomForm = AutoDisposeNotifier<RoomFormState>;
// ignore_for_file: unnecessary_raw_strings, subtype_of_sealed_class, invalid_use_of_internal_member, do_not_use_environment, prefer_const_constructors, public_member_api_docs, avoid_private_typedef_functions
