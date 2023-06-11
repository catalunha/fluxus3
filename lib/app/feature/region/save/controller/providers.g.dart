// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$regionReadHash() => r'2a8cc7bb9e0344278cabcaa6925c2690bde3663e';

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

typedef RegionReadRef = AutoDisposeFutureProviderRef<RegionModel?>;

/// See also [regionRead].
@ProviderFor(regionRead)
const regionReadProvider = RegionReadFamily();

/// See also [regionRead].
class RegionReadFamily extends Family<AsyncValue<RegionModel?>> {
  /// See also [regionRead].
  const RegionReadFamily();

  /// See also [regionRead].
  RegionReadProvider call({
    required String? id,
  }) {
    return RegionReadProvider(
      id: id,
    );
  }

  @override
  RegionReadProvider getProviderOverride(
    covariant RegionReadProvider provider,
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
  String? get name => r'regionReadProvider';
}

/// See also [regionRead].
class RegionReadProvider extends AutoDisposeFutureProvider<RegionModel?> {
  /// See also [regionRead].
  RegionReadProvider({
    required this.id,
  }) : super.internal(
          (ref) => regionRead(
            ref,
            id: id,
          ),
          from: regionReadProvider,
          name: r'regionReadProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$regionReadHash,
          dependencies: RegionReadFamily._dependencies,
          allTransitiveDependencies:
              RegionReadFamily._allTransitiveDependencies,
        );

  final String? id;

  @override
  bool operator ==(Object other) {
    return other is RegionReadProvider && other.id == id;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, id.hashCode);

    return _SystemHash.finish(hash);
  }
}

String _$regionFormHash() => r'bca51cc5ac7ce01e54646f3bfd2aa87713aa02c6';

/// See also [RegionForm].
@ProviderFor(RegionForm)
final regionFormProvider =
    AutoDisposeNotifierProvider<RegionForm, RegionFormState>.internal(
  RegionForm.new,
  name: r'regionFormProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$regionFormHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$RegionForm = AutoDisposeNotifier<RegionFormState>;
// ignore_for_file: unnecessary_raw_strings, subtype_of_sealed_class, invalid_use_of_internal_member, do_not_use_environment, prefer_const_constructors, public_member_api_docs, avoid_private_typedef_functions
