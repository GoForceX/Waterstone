import 'package:auto_route/auto_route.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:native_dio_adapter/native_dio_adapter.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:waterstone/main.gr.dart';

import 'constants.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await BaseSingleton.singleton.init();
  runApp(ProviderScope(child: MyApp()));
}

Logger logger = Logger(
  printer: PrettyPrinter(
    methodCount: 5,
    errorMethodCount: 8,
    lineLength: 120 * 10,
    colors: true,
    printEmojis: true,
    dateTimeFormat: DateTimeFormat.dateAndTime,
  ),
);

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final _appRouter = AppRouter();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Waterstone',
      routerConfig: _appRouter.config(),
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.orange),
        useMaterial3: true,
      ),
    );
  }
}

@AutoRouterConfig(replaceInRouteName: 'Screen|Page,Route')
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
    AutoRoute(
      page: MainRoute.page,
      path: '/',
      children: [
        AutoRoute(page: ToolsRoute.page, path: 'tools'),
        AutoRoute(page: UserRoute.page, path: 'user'),
      ],
    ),
    AutoRoute(
      page: PhysicsExperimentRoute.page,
      path: '/tools/physics_experiment',
    ),
  ];
}

class BaseSingleton {
  BaseSingleton._();

  static final BaseSingleton _singleton = BaseSingleton._();
  final Dio dio = Dio();
  late final CookieJar cookieJar;
  late final SharedPreferences sharedPreferences;
  late final PackageInfo packageInfo;

  static BaseSingleton get singleton => _singleton;

  init() async {
    dio.options.responseType = ResponseType.plain;

    getApplicationSupportDirectory().then((value) {
      String dataPath = value.path;
      cookieJar = PersistCookieJar(
        storage: FileStorage(dataPath),
        ignoreExpires: true,
      );
      dio.interceptors.add(CookieManager(cookieJar));
    });

    dio
      ..options.followRedirects = false
      ..options.validateStatus =
          (status) => status != null && status >= 200 && status < 400;

    dio.options.headers = commonHeaders;
    dio.httpClientAdapter = NativeAdapter();

    sharedPreferences = await SharedPreferences.getInstance();
    PackageInfo.fromPlatform().then((value) => packageInfo = value);
  }
}
