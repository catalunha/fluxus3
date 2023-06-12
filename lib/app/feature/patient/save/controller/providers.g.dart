// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$patientReadHash() => r'c433608a12ca3a3d37161d62b85c000e91537467';

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

typedef PatientReadRef = AutoDisposeFutureProviderRef<PatientModel?>;

/// See also [patientRead].
@ProviderFor(patientRead)
const patientReadProvider = PatientReadFamily();

/// See also [patientRead].
class PatientReadFamily extends Family<AsyncValue<PatientModel?>> {
  /// See also [patientRead].
  const PatientReadFamily();

  /// See also [patientRead].
  PatientReadProvider call({
    required String? id,
  }) {
    return PatientReadProvider(
      id: id,
    );
  }

  @override
  PatientReadProvider getProviderOverride(
    covariant PatientReadProvider provider,
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
  String? get name => r'patientReadProvider';
}

/// See also [patientRead].
class PatientReadProvider extends AutoDisposeFutureProvider<PatientModel?> {
  /// See also [patientRead].
  PatientReadProvider({
    required this.id,
  }) : super.internal(
          (ref) => patientRead(
            ref,
            id: id,
          ),
          from: patientReadProvider,
          name: r'patientReadProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$patientReadHash,
          dependencies: PatientReadFamily._dependencies,
          allTransitiveDependencies:
              PatientReadFamily._allTransitiveDependencies,
        );

  final String? id;

  @override
  bool operator ==(Object other) {
    return other is PatientReadProvider && other.id == id;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, id.hashCode);

    return _SystemHash.finish(hash);
  }
}

String _$patientIsFemaleHash() => r'c99834fc266b56c1b6d5e2976e70c57549d4ec45';

/// See also [PatientIsFemale].
@ProviderFor(PatientIsFemale)
final patientIsFemaleProvider =
    AutoDisposeNotifierProvider<PatientIsFemale, bool>.internal(
  PatientIsFemale.new,
  name: r'patientIsFemaleProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$patientIsFemaleHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$PatientIsFemale = AutoDisposeNotifier<bool>;
String _$patientFormHash() => r'bf463024a8fd0a3648769b8827b6f99a32d0dc7c';

/// See also [PatientForm].
@ProviderFor(PatientForm)
final patientFormProvider =
    AutoDisposeNotifierProvider<PatientForm, PatientFormState>.internal(
  PatientForm.new,
  name: r'patientFormProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$patientFormHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$PatientForm = AutoDisposeNotifier<PatientFormState>;
// ignore_for_file: unnecessary_raw_strings, subtype_of_sealed_class, invalid_use_of_internal_member, do_not_use_environment, prefer_const_constructors, public_member_api_docs, avoid_private_typedef_functions
