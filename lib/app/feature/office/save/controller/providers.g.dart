// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$officeReadHash() => r'e6cf469e3798472d15dea950ed215ad25db7cb09';

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

typedef OfficeReadRef = AutoDisposeFutureProviderRef<OfficeModel?>;

/// See also [officeRead].
@ProviderFor(officeRead)
const officeReadProvider = OfficeReadFamily();

/// See also [officeRead].
class OfficeReadFamily extends Family<AsyncValue<OfficeModel?>> {
  /// See also [officeRead].
  const OfficeReadFamily();

  /// See also [officeRead].
  OfficeReadProvider call({
    required String? id,
  }) {
    return OfficeReadProvider(
      id: id,
    );
  }

  @override
  OfficeReadProvider getProviderOverride(
    covariant OfficeReadProvider provider,
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
  String? get name => r'officeReadProvider';
}

/// See also [officeRead].
class OfficeReadProvider extends AutoDisposeFutureProvider<OfficeModel?> {
  /// See also [officeRead].
  OfficeReadProvider({
    required this.id,
  }) : super.internal(
          (ref) => officeRead(
            ref,
            id: id,
          ),
          from: officeReadProvider,
          name: r'officeReadProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$officeReadHash,
          dependencies: OfficeReadFamily._dependencies,
          allTransitiveDependencies:
              OfficeReadFamily._allTransitiveDependencies,
        );

  final String? id;

  @override
  bool operator ==(Object other) {
    return other is OfficeReadProvider && other.id == id;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, id.hashCode);

    return _SystemHash.finish(hash);
  }
}

String _$officeFormHash() => r'b55ff31c29056344e4ac317e1393d6c799be2d2c';

/// See also [OfficeForm].
@ProviderFor(OfficeForm)
final officeFormProvider =
    AutoDisposeNotifierProvider<OfficeForm, OfficeFormState>.internal(
  OfficeForm.new,
  name: r'officeFormProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$officeFormHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$OfficeForm = AutoDisposeNotifier<OfficeFormState>;
// ignore_for_file: unnecessary_raw_strings, subtype_of_sealed_class, invalid_use_of_internal_member, do_not_use_environment, prefer_const_constructors, public_member_api_docs, avoid_private_typedef_functions
