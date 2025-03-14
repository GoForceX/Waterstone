import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:waterstone/components/info_card.dart';
import 'package:waterstone/main.dart';
import 'package:waterstone/utils/api/physics/physics.dart';

import '../../../utils/api/physics/schema.dart';

@RoutePage()
class PhysicsExperimentSchedulePage extends ConsumerWidget {
  const PhysicsExperimentSchedulePage({super.key});

  Widget _buildAppointmentCard(PhysicsExperimentAppointment appointment) {
    return InfoCard(
      title: appointment.courseName,
      subtitle: appointment.roomName,
      rows: [
        InfoCardRow(
          label: '上课时间:',
          value:
              '第${appointment.weekNum}周 周${_getWeekdayText(appointment.weekDay)} ${appointment.sessionName}',
        ),
        InfoCardRow(label: '开始时间:', value: appointment.startTime),
        InfoCardRow(label: '授课教师:', value: appointment.userName),
        InfoCardRow(label: '实验台号:', value: '${appointment.roomTestNum}'),
        _buildStatusBadge(appointment.status, appointment.isWithdraw),
      ],
    );
  }

  Widget _buildStatusBadge(int status, int withdraw) {
    Color color;
    String text;

    if (status == 1 && withdraw == 0) {
      color = Colors.green;
      text = "已预约";
    } else if (status == 1 && withdraw == 1) {
      color = Colors.red;
      text = "已结束";
    } else {
      color = Colors.orange;
      text = "未知状态";
    }

    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        margin: const EdgeInsets.only(top: 8),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: color),
        ),
        child: Text(
          text,
          style: TextStyle(color: color, fontWeight: FontWeight.w500),
        ),
      ),
    );
  }

  String _getWeekdayText(int weekday) {
    switch (weekday) {
      case 1:
        return "一";
      case 2:
        return "二";
      case 3:
        return "三";
      case 4:
        return "四";
      case 5:
        return "五";
      case 6:
        return "六";
      case 7:
        return "日";
      default:
        return weekday.toString();
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    AsyncValue schedule = ref.watch(getPhysicsExperimentScheduleProvider);
    return Scaffold(
      body: schedule.when(
        data: (data) {
          final items = data as List<PhysicsExperimentAppointment>;
          return items.isEmpty
              ? const Center(child: Text('暂无课表'))
              : ListView.builder(
                padding: const EdgeInsets.only(top: 12, bottom: 16),
                itemCount: items.length,
                itemBuilder:
                    (context, index) => _buildAppointmentCard(items[index]),
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
                const Text('获取实验课表失败', style: TextStyle(fontSize: 16)),
                TextButton(
                  onPressed: () {
                    ref.invalidate(prefetchSessionProvider);
                    ref.invalidate(getPhysicsExperimentScheduleProvider);
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
