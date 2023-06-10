// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$userProfileAccessHash() => r'0fd441e29fe5a7337c4c9de9e0805fb0dc0c565b';

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

String _$accessStateHash() => r'c30b11e590b870133ba1de57592557ddb4526257';

/// See also [AccessState].
@ProviderFor(AccessState)
final accessStateProvider =
    NotifierProvider<AccessState, List<AccessStatus>>.internal(
  AccessState.new,
  name: r'accessStateProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$accessStateHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$AccessState = Notifier<List<AccessStatus>>;
// ignore_for_file: unnecessary_raw_strings, subtype_of_sealed_class, invalid_use_of_internal_member, do_not_use_environment, prefer_const_constructors, public_member_api_docs, avoid_private_typedef_functions
