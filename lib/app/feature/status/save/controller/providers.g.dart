// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$statusReadHash() => r'bf3b93379da95c4cf0e608f9aa8eeb168ff63144';

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

typedef StatusReadRef = AutoDisposeFutureProviderRef<StatusModel?>;

/// See also [statusRead].
@ProviderFor(statusRead)
const statusReadProvider = StatusReadFamily();

/// See also [statusRead].
class StatusReadFamily extends Family<AsyncValue<StatusModel?>> {
  /// See also [statusRead].
  const StatusReadFamily();

  /// See also [statusRead].
  StatusReadProvider call({
    required String? id,
  }) {
    return StatusReadProvider(
      id: id,
    );
  }

  @override
  StatusReadProvider getProviderOverride(
    covariant StatusReadProvider provider,
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
  String? get name => r'statusReadProvider';
}

/// See also [statusRead].
class StatusReadProvider extends AutoDisposeFutureProvider<StatusModel?> {
  /// See also [statusRead].
  StatusReadProvider({
    required this.id,
  }) : super.internal(
          (ref) => statusRead(
            ref,
            id: id,
          ),
          from: statusReadProvider,
          name: r'statusReadProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$statusReadHash,
          dependencies: StatusReadFamily._dependencies,
          allTransitiveDependencies:
              StatusReadFamily._allTransitiveDependencies,
        );

  final String? id;

  @override
  bool operator ==(Object other) {
    return other is StatusReadProvider && other.id == id;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, id.hashCode);

    return _SystemHash.finish(hash);
  }
}

String _$statusFormHash() => r'6b50879dbf1fb83f64d5b52c31ea89bb7d5ca299';

/// See also [StatusForm].
@ProviderFor(StatusForm)
final statusFormProvider =
    AutoDisposeNotifierProvider<StatusForm, StatusFormState>.internal(
  StatusForm.new,
  name: r'statusFormProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$statusFormHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$StatusForm = AutoDisposeNotifier<StatusFormState>;
// ignore_for_file: unnecessary_raw_strings, subtype_of_sealed_class, invalid_use_of_internal_member, do_not_use_environment, prefer_const_constructors, public_member_api_docs, avoid_private_typedef_functions
