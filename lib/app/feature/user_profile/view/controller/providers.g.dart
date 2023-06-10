// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$userProfileViewHash() => r'b0568bb70f2dcb37428ac4ee2f808dbf4fc037fe';

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

typedef UserProfileViewRef = AutoDisposeFutureProviderRef<UserProfileModel>;

/// See also [userProfileView].
@ProviderFor(userProfileView)
const userProfileViewProvider = UserProfileViewFamily();

/// See also [userProfileView].
class UserProfileViewFamily extends Family<AsyncValue<UserProfileModel>> {
  /// See also [userProfileView].
  const UserProfileViewFamily();

  /// See also [userProfileView].
  UserProfileViewProvider call({
    required String id,
  }) {
    return UserProfileViewProvider(
      id: id,
    );
  }

  @override
  UserProfileViewProvider getProviderOverride(
    covariant UserProfileViewProvider provider,
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
  String? get name => r'userProfileViewProvider';
}

/// See also [userProfileView].
class UserProfileViewProvider
    extends AutoDisposeFutureProvider<UserProfileModel> {
  /// See also [userProfileView].
  UserProfileViewProvider({
    required this.id,
  }) : super.internal(
          (ref) => userProfileView(
            ref,
            id: id,
          ),
          from: userProfileViewProvider,
          name: r'userProfileViewProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$userProfileViewHash,
          dependencies: UserProfileViewFamily._dependencies,
          allTransitiveDependencies:
              UserProfileViewFamily._allTransitiveDependencies,
        );

  final String id;

  @override
  bool operator ==(Object other) {
    return other is UserProfileViewProvider && other.id == id;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, id.hashCode);

    return _SystemHash.finish(hash);
  }
}
// ignore_for_file: unnecessary_raw_strings, subtype_of_sealed_class, invalid_use_of_internal_member, do_not_use_environment, prefer_const_constructors, public_member_api_docs, avoid_private_typedef_functions
