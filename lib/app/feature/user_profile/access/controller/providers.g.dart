// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$userProfileAccessReadHash() =>
    r'8adb723e56b409ccef27c861de37074cbb08f3ef';

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

String _$isActiveHash() => r'5adfaee2e5ec17c989bbe966dc78351471030e74';

/// See also [IsActive].
@ProviderFor(IsActive)
final isActiveProvider = AutoDisposeNotifierProvider<IsActive, bool>.internal(
  IsActive.new,
  name: r'isActiveProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$isActiveHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$IsActive = AutoDisposeNotifier<bool>;
String _$officesOriginalHash() => r'a1257a8c55185b02a86454e9771f1d6bf4e55dbf';

/// See also [OfficesOriginal].
@ProviderFor(OfficesOriginal)
final officesOriginalProvider =
    AutoDisposeNotifierProvider<OfficesOriginal, List<OfficeModel>>.internal(
  OfficesOriginal.new,
  name: r'officesOriginalProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$officesOriginalHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$OfficesOriginal = AutoDisposeNotifier<List<OfficeModel>>;
String _$officesSelectedHash() => r'aea32fc0ee3574f01bd57654e17d6c345be63a93';

/// See also [OfficesSelected].
@ProviderFor(OfficesSelected)
final officesSelectedProvider =
    AutoDisposeNotifierProvider<OfficesSelected, List<OfficeModel>>.internal(
  OfficesSelected.new,
  name: r'officesSelectedProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$officesSelectedHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$OfficesSelected = AutoDisposeNotifier<List<OfficeModel>>;
String _$expertisesOriginalHash() =>
    r'09da18758d683d8ab3307e31a782f3e89aae21a0';

/// See also [ExpertisesOriginal].
@ProviderFor(ExpertisesOriginal)
final expertisesOriginalProvider = AutoDisposeNotifierProvider<
    ExpertisesOriginal, List<ExpertiseModel>>.internal(
  ExpertisesOriginal.new,
  name: r'expertisesOriginalProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$expertisesOriginalHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$ExpertisesOriginal = AutoDisposeNotifier<List<ExpertiseModel>>;
String _$expertisesSelectedHash() =>
    r'989cf88a35112d6f6daafa2d9b6a8cd434d0bb87';

/// See also [ExpertisesSelected].
@ProviderFor(ExpertisesSelected)
final expertisesSelectedProvider = AutoDisposeNotifierProvider<
    ExpertisesSelected, List<ExpertiseModel>>.internal(
  ExpertisesSelected.new,
  name: r'expertisesSelectedProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$expertisesSelectedHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$ExpertisesSelected = AutoDisposeNotifier<List<ExpertiseModel>>;
String _$proceduresOriginalHash() =>
    r'735e5db4661c9f29d5fc1bdc743bfcf80527f808';

/// See also [ProceduresOriginal].
@ProviderFor(ProceduresOriginal)
final proceduresOriginalProvider = AutoDisposeNotifierProvider<
    ProceduresOriginal, List<ProcedureModel>>.internal(
  ProceduresOriginal.new,
  name: r'proceduresOriginalProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$proceduresOriginalHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$ProceduresOriginal = AutoDisposeNotifier<List<ProcedureModel>>;
String _$proceduresSelectedHash() =>
    r'5abfe23b1e6660cbd42b976773b5a1648cc91011';

/// See also [ProceduresSelected].
@ProviderFor(ProceduresSelected)
final proceduresSelectedProvider = AutoDisposeNotifierProvider<
    ProceduresSelected, List<ProcedureModel>>.internal(
  ProceduresSelected.new,
  name: r'proceduresSelectedProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$proceduresSelectedHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$ProceduresSelected = AutoDisposeNotifier<List<ProcedureModel>>;
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
String _$userProfileAccessFormHash() =>
    r'465f75cd95599f967a407ef2979a559d79ac609c';

/// See also [UserProfileAccessForm].
@ProviderFor(UserProfileAccessForm)
final userProfileAccessFormProvider = AutoDisposeNotifierProvider<
    UserProfileAccessForm, UserProfileAccessFormState>.internal(
  UserProfileAccessForm.new,
  name: r'userProfileAccessFormProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$userProfileAccessFormHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$UserProfileAccessForm
    = AutoDisposeNotifier<UserProfileAccessFormState>;
// ignore_for_file: unnecessary_raw_strings, subtype_of_sealed_class, invalid_use_of_internal_member, do_not_use_environment, prefer_const_constructors, public_member_api_docs, avoid_private_typedef_functions
