// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'schedule.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$currentSemesterIDFromHubsHash() =>
    r'9a57f9f8b4d9f8fcabdbfcd97e6094b8cbdd6f62';

/// See also [currentSemesterIDFromHubs].
@ProviderFor(currentSemesterIDFromHubs)
final currentSemesterIDFromHubsProvider =
    AutoDisposeFutureProvider<String>.internal(
      currentSemesterIDFromHubs,
      name: r'currentSemesterIDFromHubsProvider',
      debugGetCreateSourceHash:
          const bool.fromEnvironment('dart.vm.product')
              ? null
              : _$currentSemesterIDFromHubsHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef CurrentSemesterIDFromHubsRef = AutoDisposeFutureProviderRef<String>;
String _$getSemesterScheduleFromHubsHash() =>
    r'59b06e54366321e7423d78dd1eac242ca20db5ee';

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

/// See also [getSemesterScheduleFromHubs].
@ProviderFor(getSemesterScheduleFromHubs)
const getSemesterScheduleFromHubsProvider = GetSemesterScheduleFromHubsFamily();

/// See also [getSemesterScheduleFromHubs].
class GetSemesterScheduleFromHubsFamily
    extends Family<AsyncValue<List<WeeklyScheduleHubs>>> {
  /// See also [getSemesterScheduleFromHubs].
  const GetSemesterScheduleFromHubsFamily();

  /// See also [getSemesterScheduleFromHubs].
  GetSemesterScheduleFromHubsProvider call(String? semesterID) {
    return GetSemesterScheduleFromHubsProvider(semesterID);
  }

  @override
  GetSemesterScheduleFromHubsProvider getProviderOverride(
    covariant GetSemesterScheduleFromHubsProvider provider,
  ) {
    return call(provider.semesterID);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'getSemesterScheduleFromHubsProvider';
}

/// See also [getSemesterScheduleFromHubs].
class GetSemesterScheduleFromHubsProvider
    extends AutoDisposeFutureProvider<List<WeeklyScheduleHubs>> {
  /// See also [getSemesterScheduleFromHubs].
  GetSemesterScheduleFromHubsProvider(String? semesterID)
    : this._internal(
        (ref) => getSemesterScheduleFromHubs(
          ref as GetSemesterScheduleFromHubsRef,
          semesterID,
        ),
        from: getSemesterScheduleFromHubsProvider,
        name: r'getSemesterScheduleFromHubsProvider',
        debugGetCreateSourceHash:
            const bool.fromEnvironment('dart.vm.product')
                ? null
                : _$getSemesterScheduleFromHubsHash,
        dependencies: GetSemesterScheduleFromHubsFamily._dependencies,
        allTransitiveDependencies:
            GetSemesterScheduleFromHubsFamily._allTransitiveDependencies,
        semesterID: semesterID,
      );

  GetSemesterScheduleFromHubsProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.semesterID,
  }) : super.internal();

  final String? semesterID;

  @override
  Override overrideWith(
    FutureOr<List<WeeklyScheduleHubs>> Function(
      GetSemesterScheduleFromHubsRef provider,
    )
    create,
  ) {
    return ProviderOverride(
      origin: this,
      override: GetSemesterScheduleFromHubsProvider._internal(
        (ref) => create(ref as GetSemesterScheduleFromHubsRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        semesterID: semesterID,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<WeeklyScheduleHubs>> createElement() {
    return _GetSemesterScheduleFromHubsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is GetSemesterScheduleFromHubsProvider &&
        other.semesterID == semesterID;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, semesterID.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin GetSemesterScheduleFromHubsRef
    on AutoDisposeFutureProviderRef<List<WeeklyScheduleHubs>> {
  /// The parameter `semesterID` of this provider.
  String? get semesterID;
}

class _GetSemesterScheduleFromHubsProviderElement
    extends AutoDisposeFutureProviderElement<List<WeeklyScheduleHubs>>
    with GetSemesterScheduleFromHubsRef {
  _GetSemesterScheduleFromHubsProviderElement(super.provider);

  @override
  String? get semesterID =>
      (origin as GetSemesterScheduleFromHubsProvider).semesterID;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
