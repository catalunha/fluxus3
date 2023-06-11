// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$healthPlanTypeReadHash() =>
    r'e277281bd5b334f416ca7cde5b5e50003e902e0a';

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

typedef HealthPlanTypeReadRef
    = AutoDisposeFutureProviderRef<HealthPlanTypeModel?>;

/// See also [healthPlanTypeRead].
@ProviderFor(healthPlanTypeRead)
const healthPlanTypeReadProvider = HealthPlanTypeReadFamily();

/// See also [healthPlanTypeRead].
class HealthPlanTypeReadFamily
    extends Family<AsyncValue<HealthPlanTypeModel?>> {
  /// See also [healthPlanTypeRead].
  const HealthPlanTypeReadFamily();

  /// See also [healthPlanTypeRead].
  HealthPlanTypeReadProvider call({
    required String? id,
  }) {
    return HealthPlanTypeReadProvider(
      id: id,
    );
  }

  @override
  HealthPlanTypeReadProvider getProviderOverride(
    covariant HealthPlanTypeReadProvider provider,
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
  String? get name => r'healthPlanTypeReadProvider';
}

/// See also [healthPlanTypeRead].
class HealthPlanTypeReadProvider
    extends AutoDisposeFutureProvider<HealthPlanTypeModel?> {
  /// See also [healthPlanTypeRead].
  HealthPlanTypeReadProvider({
    required this.id,
  }) : super.internal(
          (ref) => healthPlanTypeRead(
            ref,
            id: id,
          ),
          from: healthPlanTypeReadProvider,
          name: r'healthPlanTypeReadProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$healthPlanTypeReadHash,
          dependencies: HealthPlanTypeReadFamily._dependencies,
          allTransitiveDependencies:
              HealthPlanTypeReadFamily._allTransitiveDependencies,
        );

  final String? id;

  @override
  bool operator ==(Object other) {
    return other is HealthPlanTypeReadProvider && other.id == id;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, id.hashCode);

    return _SystemHash.finish(hash);
  }
}

String _$healthPlanTypeFormHash() =>
    r'e524d70307fb2ce4b7e37b4992ae0d14bbab1601';

/// See also [HealthPlanTypeForm].
@ProviderFor(HealthPlanTypeForm)
final healthPlanTypeFormProvider = AutoDisposeNotifierProvider<
    HealthPlanTypeForm, HealthPlanTypeFormState>.internal(
  HealthPlanTypeForm.new,
  name: r'healthPlanTypeFormProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$healthPlanTypeFormHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$HealthPlanTypeForm = AutoDisposeNotifier<HealthPlanTypeFormState>;
// ignore_for_file: unnecessary_raw_strings, subtype_of_sealed_class, invalid_use_of_internal_member, do_not_use_environment, prefer_const_constructors, public_member_api_docs, avoid_private_typedef_functions
