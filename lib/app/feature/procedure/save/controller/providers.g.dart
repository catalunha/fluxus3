// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$procedureReadHash() => r'45de2ed9cefe0967f810f9eedf424119bd8da955';

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

typedef ProcedureReadRef = AutoDisposeFutureProviderRef<ProcedureModel?>;

/// See also [procedureRead].
@ProviderFor(procedureRead)
const procedureReadProvider = ProcedureReadFamily();

/// See also [procedureRead].
class ProcedureReadFamily extends Family<AsyncValue<ProcedureModel?>> {
  /// See also [procedureRead].
  const ProcedureReadFamily();

  /// See also [procedureRead].
  ProcedureReadProvider call({
    required String? id,
  }) {
    return ProcedureReadProvider(
      id: id,
    );
  }

  @override
  ProcedureReadProvider getProviderOverride(
    covariant ProcedureReadProvider provider,
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
  String? get name => r'procedureReadProvider';
}

/// See also [procedureRead].
class ProcedureReadProvider extends AutoDisposeFutureProvider<ProcedureModel?> {
  /// See also [procedureRead].
  ProcedureReadProvider({
    required this.id,
  }) : super.internal(
          (ref) => procedureRead(
            ref,
            id: id,
          ),
          from: procedureReadProvider,
          name: r'procedureReadProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$procedureReadHash,
          dependencies: ProcedureReadFamily._dependencies,
          allTransitiveDependencies:
              ProcedureReadFamily._allTransitiveDependencies,
        );

  final String? id;

  @override
  bool operator ==(Object other) {
    return other is ProcedureReadProvider && other.id == id;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, id.hashCode);

    return _SystemHash.finish(hash);
  }
}

String _$expertiseSelectedHash() => r'bac9151c12448c63599c78ad21dca3bd329b1f89';

/// See also [ExpertiseSelected].
@ProviderFor(ExpertiseSelected)
final expertiseSelectedProvider =
    AutoDisposeNotifierProvider<ExpertiseSelected, ExpertiseModel?>.internal(
  ExpertiseSelected.new,
  name: r'expertiseSelectedProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$expertiseSelectedHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$ExpertiseSelected = AutoDisposeNotifier<ExpertiseModel?>;
String _$procedureFormHash() => r'4b665dacea878d523eccb432acb5d0296d67cb27';

/// See also [ProcedureForm].
@ProviderFor(ProcedureForm)
final procedureFormProvider =
    AutoDisposeNotifierProvider<ProcedureForm, ProcedureFormState>.internal(
  ProcedureForm.new,
  name: r'procedureFormProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$procedureFormHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$ProcedureForm = AutoDisposeNotifier<ProcedureFormState>;
// ignore_for_file: unnecessary_raw_strings, subtype_of_sealed_class, invalid_use_of_internal_member, do_not_use_environment, prefer_const_constructors, public_member_api_docs, avoid_private_typedef_functions
