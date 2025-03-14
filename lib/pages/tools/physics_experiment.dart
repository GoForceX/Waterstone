import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:waterstone/main.dart';
import 'package:waterstone/utils/api/physics.dart';

@RoutePage()
class PhysicsExperimentPage extends ConsumerWidget {
  const PhysicsExperimentPage({super.key});

  Widget _buildExperimentCard(PhysicsExperimentRecord record) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8, left: 12, right: 12),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              record.courseName,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 4),
            Text(record.roomName, style: const TextStyle(color: Colors.grey)),
            const Divider(height: 16),
            _buildInfoRow('实验成绩:', record.experimentScore.toString()),
            _buildInfoRow('报告成绩:', (record.reportScore ?? '--').toString()),
            _buildInfoRow('签到时间:', record.signTime),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(color: Colors.grey)),
          Text(value, style: const TextStyle(fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    AsyncValue records = ref.watch(getPhysicsExperimentRecordsProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('物理实验'), centerTitle: true),
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
                  onPressed:
                      () => ref.refresh(getPhysicsExperimentRecordsProvider),
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
