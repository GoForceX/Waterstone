// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'schedule.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$currentSemesterIDFromHubsHash() =>
    r'7a2fde28af24d0e175288e91a11ba1e6ee0b8b66';

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
String _$hubsSemesterScheduleHash() =>
    r'd62a12ac687f283528290056b93518dddf4cc0e8';

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

/// See also [hubsSemesterSchedule].
@ProviderFor(hubsSemesterSchedule)
const hubsSemesterScheduleProvider = HubsSemesterScheduleFamily();

/// See also [hubsSemesterSchedule].
class HubsSemesterScheduleFamily
    extends Family<AsyncValue<List<WeeklyScheduleHubs>>> {
  /// See also [hubsSemesterSchedule].
  const HubsSemesterScheduleFamily();

  /// See also [hubsSemesterSchedule].
  HubsSemesterScheduleProvider call(String? semesterID) {
    return HubsSemesterScheduleProvider(semesterID);
  }

  @override
  HubsSemesterScheduleProvider getProviderOverride(
    covariant HubsSemesterScheduleProvider provider,
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
  String? get name => r'hubsSemesterScheduleProvider';
}

/// See also [hubsSemesterSchedule].
class HubsSemesterScheduleProvider
    extends AutoDisposeFutureProvider<List<WeeklyScheduleHubs>> {
  /// See also [hubsSemesterSchedule].
  HubsSemesterScheduleProvider(String? semesterID)
    : this._internal(
        (ref) =>
            hubsSemesterSchedule(ref as HubsSemesterScheduleRef, semesterID),
        from: hubsSemesterScheduleProvider,
        name: r'hubsSemesterScheduleProvider',
        debugGetCreateSourceHash:
            const bool.fromEnvironment('dart.vm.product')
                ? null
                : _$hubsSemesterScheduleHash,
        dependencies: HubsSemesterScheduleFamily._dependencies,
        allTransitiveDependencies:
            HubsSemesterScheduleFamily._allTransitiveDependencies,
        semesterID: semesterID,
      );

  HubsSemesterScheduleProvider._internal(
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
      HubsSemesterScheduleRef provider,
    )
    create,
  ) {
    return ProviderOverride(
      origin: this,
      override: HubsSemesterScheduleProvider._internal(
        (ref) => create(ref as HubsSemesterScheduleRef),
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
    return _HubsSemesterScheduleProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is HubsSemesterScheduleProvider &&
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
mixin HubsSemesterScheduleRef
    on AutoDisposeFutureProviderRef<List<WeeklyScheduleHubs>> {
  /// The parameter `semesterID` of this provider.
  String? get semesterID;
}

class _HubsSemesterScheduleProviderElement
    extends AutoDisposeFutureProviderElement<List<WeeklyScheduleHubs>>
    with HubsSemesterScheduleRef {
  _HubsSemesterScheduleProviderElement(super.provider);

  @override
  String? get semesterID => (origin as HubsSemesterScheduleProvider).semesterID;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
