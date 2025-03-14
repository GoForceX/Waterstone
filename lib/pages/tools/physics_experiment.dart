import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../main.gr.dart';

@RoutePage()
class PhysicsExperimentPage extends ConsumerWidget {
  const PhysicsExperimentPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AutoTabsScaffold(
      appBarBuilder:
          (BuildContext ctx, TabsRouter router) =>
              AppBar(title: const Text('物理实验'), centerTitle: true),
      routes: [
        PhysicsExperimentRecordsRoute(),
        PhysicsExperimentScheduleRoute(),
      ],
      bottomNavigationBuilder: (_, tabsRouter) {
        return BottomNavigationBar(
          iconSize: 32,
          selectedFontSize: 15,
          unselectedFontSize: 15,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.history), label: '成绩'),
            BottomNavigationBarItem(
              icon: Icon(Icons.calendar_month_outlined),
              label: '课表',
            ),
          ],
          currentIndex: tabsRouter.activeIndex,
          onTap: tabsRouter.setActiveIndex,
        );
      },
    );
  }
}
