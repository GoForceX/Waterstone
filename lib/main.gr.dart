// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i5;
import 'package:waterstone/pages/main.dart' as _i1;
import 'package:waterstone/pages/main/tools.dart' as _i3;
import 'package:waterstone/pages/main/user.dart' as _i4;
import 'package:waterstone/pages/tools/physics_experiment.dart' as _i2;

/// generated route for
/// [_i1.MainPage]
class MainRoute extends _i5.PageRouteInfo<void> {
  const MainRoute({List<_i5.PageRouteInfo>? children})
    : super(MainRoute.name, initialChildren: children);

  static const String name = 'MainRoute';

  static _i5.PageInfo page = _i5.PageInfo(
    name,
    builder: (data) {
      return const _i1.MainPage();
    },
  );
}

/// generated route for
/// [_i2.PhysicsExperimentPage]
class PhysicsExperimentRoute extends _i5.PageRouteInfo<void> {
  const PhysicsExperimentRoute({List<_i5.PageRouteInfo>? children})
    : super(PhysicsExperimentRoute.name, initialChildren: children);

  static const String name = 'PhysicsExperimentRoute';

  static _i5.PageInfo page = _i5.PageInfo(
    name,
    builder: (data) {
      return const _i2.PhysicsExperimentPage();
    },
  );
}

/// generated route for
/// [_i3.ToolsPage]
class ToolsRoute extends _i5.PageRouteInfo<void> {
  const ToolsRoute({List<_i5.PageRouteInfo>? children})
    : super(ToolsRoute.name, initialChildren: children);

  static const String name = 'ToolsRoute';

  static _i5.PageInfo page = _i5.PageInfo(
    name,
    builder: (data) {
      return const _i3.ToolsPage();
    },
  );
}

/// generated route for
/// [_i4.UserPage]
class UserRoute extends _i5.PageRouteInfo<void> {
  const UserRoute({List<_i5.PageRouteInfo>? children})
    : super(UserRoute.name, initialChildren: children);

  static const String name = 'UserRoute';

  static _i5.PageInfo page = _i5.PageInfo(
    name,
    builder: (data) {
      return const _i4.UserPage();
    },
  );
}
