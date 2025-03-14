import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:waterstone/components/login_status.dart';

import '../../utils/auth.dart';

@RoutePage()
class ToolsPage extends ConsumerWidget {
  const ToolsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    AsyncValue loginStatus = ref.watch(checkLoginStatusProvider);

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
        GridView.count(
          physics: NeverScrollableScrollPhysics(),
          crossAxisCount: 2,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          padding: EdgeInsets.all(10),
          shrinkWrap: true,
          children: [Card(child: Text("114514"))],
        ),
      ],
    );
  }
}
