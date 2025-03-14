import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:waterstone/components/info_card.dart';
import 'package:waterstone/main.dart';
import 'package:waterstone/utils/api/physics/physics.dart';

import '../../../utils/api/physics/schema.dart';

@RoutePage()
class PhysicsExperimentRecordsPage extends ConsumerWidget {
  const PhysicsExperimentRecordsPage({super.key});

  Widget _buildExperimentCard(PhysicsExperimentRecord record) {
    return InfoCard(
      title: record.courseName,
      subtitle: record.roomName,
      rows: [
        InfoCardRow(label: '实验成绩:', value: record.experimentScore.toString()),
        InfoCardRow(
          label: '报告成绩:',
          value: (record.reportScore ?? '--').toString(),
        ),
        InfoCardRow(label: '签到时间:', value: record.signTime),
      ],
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    AsyncValue records = ref.watch(getPhysicsExperimentRecordsProvider);
    return Scaffold(
      body: records.when(
        data: (data) {
          final items = data as List<PhysicsExperimentRecord>;
          return items.isEmpty
              ? const Center(child: Text('暂无实验记录'))
              : ListView.builder(
                padding: const EdgeInsets.only(top: 12, bottom: 16),
                itemCount: items.length,
                itemBuilder:
                    (context, index) => _buildExperimentCard(items[index]),
              );
        },
        error: (error, stack) {
          logger.e((error, stack));
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.error_outline, size: 48, color: Colors.red),
                const SizedBox(height: 16),
                const Text('获取实验列表失败', style: TextStyle(fontSize: 16)),
                TextButton(
                  onPressed: () {
                    ref.invalidate(prefetchSessionProvider);
                    ref.invalidate(getPhysicsExperimentRecordsProvider);
                  },
                  child: const Text('重试'),
                ),
              ],
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
