// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$expertiseReadHash() => r'c1a7083ed2779647e4d489e9e857d1ac6aa6e1ac';

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

typedef ExpertiseReadRef = AutoDisposeFutureProviderRef<ExpertiseModel?>;

/// See also [expertiseRead].
@ProviderFor(expertiseRead)
const expertiseReadProvider = ExpertiseReadFamily();

/// See also [expertiseRead].
class ExpertiseReadFamily extends Family<AsyncValue<ExpertiseModel?>> {
  /// See also [expertiseRead].
  const ExpertiseReadFamily();

  /// See also [expertiseRead].
  ExpertiseReadProvider call({
    required String? id,
  }) {
    return ExpertiseReadProvider(
      id: id,
    );
  }

  @override
  ExpertiseReadProvider getProviderOverride(
    covariant ExpertiseReadProvider provider,
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
  String? get name => r'expertiseReadProvider';
}

/// See also [expertiseRead].
class ExpertiseReadProvider extends AutoDisposeFutureProvider<ExpertiseModel?> {
  /// See also [expertiseRead].
  ExpertiseReadProvider({
    required this.id,
  }) : super.internal(
          (ref) => expertiseRead(
            ref,
            id: id,
          ),
          from: expertiseReadProvider,
          name: r'expertiseReadProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$expertiseReadHash,
          dependencies: ExpertiseReadFamily._dependencies,
          allTransitiveDependencies:
              ExpertiseReadFamily._allTransitiveDependencies,
        );

  final String? id;

  @override
  bool operator ==(Object other) {
    return other is ExpertiseReadProvider && other.id == id;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, id.hashCode);

    return _SystemHash.finish(hash);
  }
}

String _$expertiseFormHash() => r'c9b6f00613b94088b5e0d557f322f039d17cf99e';

/// See also [ExpertiseForm].
@ProviderFor(ExpertiseForm)
final expertiseFormProvider =
    AutoDisposeNotifierProvider<ExpertiseForm, ExpertiseFormState>.internal(
  ExpertiseForm.new,
  name: r'expertiseFormProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$expertiseFormHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$ExpertiseForm = AutoDisposeNotifier<ExpertiseFormState>;
// ignore_for_file: unnecessary_raw_strings, subtype_of_sealed_class, invalid_use_of_internal_member, do_not_use_environment, prefer_const_constructors, public_member_api_docs, avoid_private_typedef_functions
