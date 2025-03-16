import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:waterstone/components/login_status.dart';
import 'package:waterstone/main.gr.dart';

import '../../utils/api/auth.dart';

class ToolRoute {
  const ToolRoute({required this.route, required this.title});

  final PageRouteInfo route;
  final String title;
}

final List<ToolRoute> toolRoutes = [
  ToolRoute(route: PhysicsExperimentRoute(), title: '大学物理实验'),
  // ToolRoute(route: ScheduleRoute(), title: '实时课程表'),
];

@RoutePage()
class ToolsPage extends ConsumerWidget {
  const ToolsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    AsyncValue loginStatus = ref.watch(loginStatusProvider);

    return ListView(
      children: [
        loginStatus.when(
          data: (data) {
            if (data) {
              return LoginStatus(status: LoginStatusEnum.loggedIn);
            }
            return LoginStatus(status: LoginStatusEnum.loggedOut);
          },
          error: (error, stack) {
            return LoginStatus(status: LoginStatusEnum.loading);
          },
          loading: () {
            return LoginStatus(status: LoginStatusEnum.loading);
          },
        ),
        TextField(
          decoration: InputDecoration(
            labelText: "搜索",
            prefixIcon: Icon(Icons.search),
          ),
        ),
        GridView.count(
          physics: NeverScrollableScrollPhysics(),
          crossAxisCount: 2,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          childAspectRatio: 2,
          padding: EdgeInsets.all(10),
          shrinkWrap: true,
          children: [
            for (var toolRoute in toolRoutes)
              Card(
                child: InkWell(
                  onTap: () {
                    AutoRouter.of(context).push(toolRoute.route);
                  },
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Center(
                      child: Text(
                        toolRoute.title,
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ],
    );
  }
}
