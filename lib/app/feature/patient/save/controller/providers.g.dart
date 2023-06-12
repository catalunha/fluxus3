// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$patientReadHash() => r'4136eac4b3b5549d2812c138ecfbb82bc23d67c1';

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

String _$patientIsActiveHash() => r'1360090ec64d08513de2a8549d787433dac5cb08';

/// See also [PatientIsActive].
@ProviderFor(PatientIsActive)
final patientIsActiveProvider =
    AutoDisposeNotifierProvider<PatientIsActive, bool>.internal(
  PatientIsActive.new,
  name: r'patientIsActiveProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$patientIsActiveHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$PatientIsActive = AutoDisposeNotifier<bool>;
String _$patientFormHash() => r'ff8b4efacd1117be7728960f9769650cf8f9c55f';

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
