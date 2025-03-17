// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'schedule.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$currentSemesterTimeInfoFromHubsHash() =>
    r'953445d6c263a986d66ee66e6cf1d2f2f805fb9a';

/// See also [currentSemesterTimeInfoFromHubs].
@ProviderFor(currentSemesterTimeInfoFromHubs)
final currentSemesterTimeInfoFromHubsProvider =
    AutoDisposeFutureProvider<SemesterTimeInfo>.internal(
      currentSemesterTimeInfoFromHubs,
      name: r'currentSemesterTimeInfoFromHubsProvider',
      debugGetCreateSourceHash:
          const bool.fromEnvironment('dart.vm.product')
              ? null
              : _$currentSemesterTimeInfoFromHubsHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef CurrentSemesterTimeInfoFromHubsRef =
    AutoDisposeFutureProviderRef<SemesterTimeInfo>;
String _$hubsSemesterScheduleHash() =>
    r'544423d892993928b2492a1a7a4e2ace43c46274';

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

String _$epicClassScheduleHash() => r'8249fc9c5a99b846410c21d1477137107a11ac14';

/// See also [epicClassSchedule].
@ProviderFor(epicClassSchedule)
final epicClassScheduleProvider =
    AutoDisposeFutureProvider<List<ClassScheduleEPIC>>.internal(
      epicClassSchedule,
      name: r'epicClassScheduleProvider',
      debugGetCreateSourceHash:
          const bool.fromEnvironment('dart.vm.product')
              ? null
              : _$epicClassScheduleHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef EpicClassScheduleRef =
    AutoDisposeFutureProviderRef<List<ClassScheduleEPIC>>;
String _$getAllScheduleHash() => r'70d1144b30f1a635ebddf05a60a69127aace08f5';

/// See also [getAllSchedule].
@ProviderFor(getAllSchedule)
final getAllScheduleProvider =
    AutoDisposeFutureProvider<WeeklySchedule>.internal(
      getAllSchedule,
      name: r'getAllScheduleProvider',
      debugGetCreateSourceHash:
          const bool.fromEnvironment('dart.vm.product')
              ? null
              : _$getAllScheduleHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef GetAllScheduleRef = AutoDisposeFutureProviderRef<WeeklySchedule>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
