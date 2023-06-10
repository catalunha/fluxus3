// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$userProfileAccessHash() => r'196cb32f0e71a8b8f511703250ab082e00a1b66c';

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

typedef UserProfileAccessRef = AutoDisposeFutureProviderRef<UserProfileModel>;

/// See also [userProfileAccess].
@ProviderFor(userProfileAccess)
const userProfileAccessProvider = UserProfileAccessFamily();

/// See also [userProfileAccess].
class UserProfileAccessFamily extends Family<AsyncValue<UserProfileModel>> {
  /// See also [userProfileAccess].
  const UserProfileAccessFamily();

  /// See also [userProfileAccess].
  UserProfileAccessProvider call({
    required String id,
  }) {
    return UserProfileAccessProvider(
      id: id,
    );
  }

  @override
  UserProfileAccessProvider getProviderOverride(
    covariant UserProfileAccessProvider provider,
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
  String? get name => r'userProfileAccessProvider';
}

/// See also [userProfileAccess].
class UserProfileAccessProvider
    extends AutoDisposeFutureProvider<UserProfileModel> {
  /// See also [userProfileAccess].
  UserProfileAccessProvider({
    required this.id,
  }) : super.internal(
          (ref) => userProfileAccess(
            ref,
            id: id,
          ),
          from: userProfileAccessProvider,
          name: r'userProfileAccessProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$userProfileAccessHash,
          dependencies: UserProfileAccessFamily._dependencies,
          allTransitiveDependencies:
              UserProfileAccessFamily._allTransitiveDependencies,
        );

  final String id;

  @override
  bool operator ==(Object other) {
    return other is UserProfileAccessProvider && other.id == id;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, id.hashCode);

    return _SystemHash.finish(hash);
  }
}

String _$officeSelectedHash() => r'2b4a0c74fb4276abc53d94c42d57a4d72afe6a17';

/// See also [OfficeSelected].
@ProviderFor(OfficeSelected)
final officeSelectedProvider =
    AutoDisposeNotifierProvider<OfficeSelected, List<OfficeModel>>.internal(
  OfficeSelected.new,
  name: r'officeSelectedProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$officeSelectedHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$OfficeSelected = AutoDisposeNotifier<List<OfficeModel>>;
String _$expertiseSelectedHash() => r'180f8b53a181bca3c4a01d9fc9dbb3caa7f4fa52';

/// See also [ExpertiseSelected].
@ProviderFor(ExpertiseSelected)
final expertiseSelectedProvider = AutoDisposeNotifierProvider<ExpertiseSelected,
    List<ExpertiseModel>>.internal(
  ExpertiseSelected.new,
  name: r'expertiseSelectedProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$expertiseSelectedHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$ExpertiseSelected = AutoDisposeNotifier<List<ExpertiseModel>>;
String _$procedureSelectedHash() => r'f39d3000e26752a81b511aeb4025789d65642f52';

/// See also [ProcedureSelected].
@ProviderFor(ProcedureSelected)
final procedureSelectedProvider = AutoDisposeNotifierProvider<ProcedureSelected,
    List<ProcedureModel>>.internal(
  ProcedureSelected.new,
  name: r'procedureSelectedProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$procedureSelectedHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$ProcedureSelected = AutoDisposeNotifier<List<ProcedureModel>>;
String _$accessStateHash() => r'6abae2092f2629d56bf4b1617f0c61e54369b45a';

/// See also [AccessState].
@ProviderFor(AccessState)
final accessStateProvider =
    AutoDisposeNotifierProvider<AccessState, List<AccessStatus>>.internal(
  AccessState.new,
  name: r'accessStateProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$accessStateHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$AccessState = AutoDisposeNotifier<List<AccessStatus>>;
// ignore_for_file: unnecessary_raw_strings, subtype_of_sealed_class, invalid_use_of_internal_member, do_not_use_environment, prefer_const_constructors, public_member_api_docs, avoid_private_typedef_functions
