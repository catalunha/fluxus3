// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$userProfileAccessReadHash() =>
    r'02bdfdc69568249ea0b64475866f7fc7bbe26a6d';

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

typedef UserProfileAccessReadRef
    = AutoDisposeFutureProviderRef<UserProfileModel>;

/// See also [userProfileAccessRead].
@ProviderFor(userProfileAccessRead)
const userProfileAccessReadProvider = UserProfileAccessReadFamily();

/// See also [userProfileAccessRead].
class UserProfileAccessReadFamily extends Family<AsyncValue<UserProfileModel>> {
  /// See also [userProfileAccessRead].
  const UserProfileAccessReadFamily();

  /// See also [userProfileAccessRead].
  UserProfileAccessReadProvider call({
    required String id,
  }) {
    return UserProfileAccessReadProvider(
      id: id,
    );
  }

  @override
  UserProfileAccessReadProvider getProviderOverride(
    covariant UserProfileAccessReadProvider provider,
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
  String? get name => r'userProfileAccessReadProvider';
}

/// See also [userProfileAccessRead].
class UserProfileAccessReadProvider
    extends AutoDisposeFutureProvider<UserProfileModel> {
  /// See also [userProfileAccessRead].
  UserProfileAccessReadProvider({
    required this.id,
  }) : super.internal(
          (ref) => userProfileAccessRead(
            ref,
            id: id,
          ),
          from: userProfileAccessReadProvider,
          name: r'userProfileAccessReadProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$userProfileAccessReadHash,
          dependencies: UserProfileAccessReadFamily._dependencies,
          allTransitiveDependencies:
              UserProfileAccessReadFamily._allTransitiveDependencies,
        );

  final String id;

  @override
  bool operator ==(Object other) {
    return other is UserProfileAccessReadProvider && other.id == id;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, id.hashCode);

    return _SystemHash.finish(hash);
  }
}

String _$officeOriginalHash() => r'46f408c09f6a36dfc9b4d7cf54097099f59c9115';

/// See also [OfficeOriginal].
@ProviderFor(OfficeOriginal)
final officeOriginalProvider =
    AutoDisposeNotifierProvider<OfficeOriginal, List<OfficeModel>>.internal(
  OfficeOriginal.new,
  name: r'officeOriginalProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$officeOriginalHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$OfficeOriginal = AutoDisposeNotifier<List<OfficeModel>>;
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
String _$userProfileAccessSaveHash() =>
    r'cbc84b5e2c969e7c63aa93aa4274f3e8bf3bd38a';

/// See also [UserProfileAccessSave].
@ProviderFor(UserProfileAccessSave)
final userProfileAccessSaveProvider =
    AutoDisposeNotifierProvider<UserProfileAccessSave, dynamic>.internal(
  UserProfileAccessSave.new,
  name: r'userProfileAccessSaveProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$userProfileAccessSaveHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$UserProfileAccessSave = AutoDisposeNotifier<dynamic>;
// ignore_for_file: unnecessary_raw_strings, subtype_of_sealed_class, invalid_use_of_internal_member, do_not_use_environment, prefer_const_constructors, public_member_api_docs, avoid_private_typedef_functions
