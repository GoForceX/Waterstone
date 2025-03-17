import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:waterstone/main.dart';
import 'package:waterstone/utils/api/prefetch.dart';
import 'package:waterstone/utils/api/schedule/schedule.dart';
import 'package:waterstone/utils/api/schedule/schema.dart';
import 'package:auto_route/auto_route.dart';

@RoutePage()
class SchedulePage extends ConsumerStatefulWidget {
  const SchedulePage({super.key});

  @override
  ConsumerState<SchedulePage> createState() => _SchedulePageState();
}

class _SchedulePageState extends ConsumerState<SchedulePage> {
  static const double _slotHeight = 60.0;
  int _currentWeekIndex = 0;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _currentWeekIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Use getAllScheduleProvider to get combined schedule
    AsyncValue<WeeklySchedule> schedule = ref.watch(getAllScheduleProvider);

    return Scaffold(
      body: SafeArea(
        child: schedule.when(
          data: (data) {
            // Find the current week when data is loaded
            _initCurrentWeek(data.hubsSchedules);
            return _buildScheduleView(context, data);
          },
          error: (err, stack) {
            logger.e(err);
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline, size: 48, color: Colors.red),
                  const SizedBox(height: 16),
                  const Text('获取课表失败', style: TextStyle(fontSize: 16)),
                  TextButton(
                    onPressed: () {
                      ref.invalidate(hubsSessionStatusProvider);
                      ref.invalidate(getAllScheduleProvider);
                    },
                    child: const Text('重试'),
                  ),
                ],
              ),
            );
          },
          loading: () {
            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }

  // Update the method to accept WeeklyScheduleHubs list
  void _initCurrentWeek(List<WeeklyScheduleHubs> weeklySchedules) {
    if (weeklySchedules.isEmpty || _pageController.hasClients) {
      return;
    }

    final now = DateTime.now();
    int currentWeekIndex = 0;

    // Try to find the current week by date
    for (int i = 0; i < weeklySchedules.length; i++) {
      if (weeklySchedules[i].startDate != null) {
        try {
          final weekStart = DateTime.parse(weeklySchedules[i].startDate!);
          final weekEnd = weekStart.add(const Duration(days: 6));

          if (now.isAfter(weekStart.subtract(const Duration(days: 1))) &&
              now.isBefore(weekEnd.add(const Duration(days: 1)))) {
            currentWeekIndex = i;
            break;
          }
        } catch (e) {
          logger.e("Error parsing date: ${e.toString()}");
        }
      }
    }

    // Update the current week index and jump to that page
    setState(() {
      _currentWeekIndex = currentWeekIndex;
      _pageController = PageController(initialPage: currentWeekIndex);
    });
  }

  // Update the method to accept the new WeeklySchedule type
  Widget _buildScheduleView(BuildContext context, WeeklySchedule schedule) {
    List<WeeklyScheduleHubs> weeklySchedules = schedule.hubsSchedules;
    // If no data, show a message
    if (weeklySchedules.isEmpty) {
      return const Center(child: Text('没有课表数据'));
    }

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back_ios),
                onPressed:
                    _currentWeekIndex > 0
                        ? () {
                          _pageController.previousPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                          );
                        }
                        : null,
              ),
              Text(
                '第${weeklySchedules[_currentWeekIndex].weekIndex}周',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              IconButton(
                icon: const Icon(Icons.arrow_forward_ios),
                onPressed:
                    _currentWeekIndex < weeklySchedules.length - 1
                        ? () {
                          _pageController.nextPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                          );
                        }
                        : null,
              ),
            ],
          ),
        ),
        Expanded(
          child: PageView.builder(
            controller: _pageController,
            itemCount: weeklySchedules.length,
            onPageChanged: (index) {
              setState(() {
                _currentWeekIndex = index;
              });
            },
            itemBuilder: (context, index) {
              // Pass both the WeeklyScheduleHubs and the relevant EPIC courses
              return _buildSchedulePageContent(
                context,
                weeklySchedules[index],
                schedule.epicSchedules,
                weeklySchedules[index].weekIndex ?? 0,
              );
            },
          ),
        ),
      ],
    );
  }

  // Update to include EPIC schedules for the current week
  Widget _buildSchedulePageContent(
    BuildContext context,
    WeeklyScheduleHubs hubsSchedule,
    List<ClassScheduleEPIC> epicSchedules,
    int weekIndex,
  ) {
    final dayLabels = ['一', '二', '三', '四', '五', '六', '日'];

    // Parse start date of the week to generate individual dates
    DateTime? startDate;
    try {
      if (hubsSchedule.startDate != null) {
        startDate = DateTime.parse(hubsSchedule.startDate!);
      }
    } catch (e) {
      logger.e("Error parsing date: ${e.toString()}");
    }

    return Column(
      children: [
        // Fixed day header row
        Container(
          color: Theme.of(context).primaryColor.withAlpha(25),
          child: Column(
            children: [
              // Date row
              Row(
                children: [
                  const SizedBox(
                    width: 40, // Width for time column
                  ),
                  ...List.generate(7, (index) {
                    String dateText = '';
                    if (startDate != null) {
                      final date = startDate.add(Duration(days: index));
                      dateText = "${date.month}/${date.day}";
                    }

                    return Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        decoration: BoxDecoration(
                          border: Border(
                            left: BorderSide(
                              color: Theme.of(context).dividerColor,
                              width: 0.5,
                            ),
                          ),
                        ),
                        child: Center(
                          child: Text(
                            dateText,
                            style: TextStyle(
                              fontSize: 12,
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
                ],
              ),
              // Weekday row
              Row(
                children: [
                  SizedBox(
                    width: 40, // Width for time column
                    child: Center(
                      child: Text(
                        '节次',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                    ),
                  ),
                  ...List.generate(7, (index) {
                    return Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        decoration: BoxDecoration(
                          border: Border(
                            left: BorderSide(
                              color: Theme.of(context).dividerColor,
                              width: 0.5,
                            ),
                            top: BorderSide(
                              color: Theme.of(context).dividerColor,
                              width: 0.5,
                            ),
                          ),
                        ),
                        child: Center(
                          child: Text(
                            '周${dayLabels[index]}',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
                ],
              ),
            ],
          ),
        ),

        // Scrollable grid part
        Expanded(
          child: SingleChildScrollView(
            child: SizedBox(
              height: 12 * _slotHeight,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Time column
                  SizedBox(
                    width: 40,
                    child: Column(
                      children: List.generate(12, (index) {
                        return Container(
                          height: _slotHeight,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            border: Border(
                              top: BorderSide(
                                color: Theme.of(context).dividerColor,
                                width: 0.5,
                              ),
                            ),
                          ),
                          child: Text('${index + 1}'),
                        );
                      }),
                    ),
                  ),

                  // Days columns
                  ...List.generate(7, (dayIndex) {
                    // Get HUBS classes for this day
                    List<ClassScheduleHubs>? dayHubsClasses;
                    switch (dayIndex) {
                      case 0:
                        dayHubsClasses = hubsSchedule.monday;
                        break;
                      case 1:
                        dayHubsClasses = hubsSchedule.tuesday;
                        break;
                      case 2:
                        dayHubsClasses = hubsSchedule.wednesday;
                        break;
                      case 3:
                        dayHubsClasses = hubsSchedule.thursday;
                        break;
                      case 4:
                        dayHubsClasses = hubsSchedule.friday;
                        break;
                      case 5:
                        dayHubsClasses = hubsSchedule.saturday;
                        break;
                      case 6:
                        dayHubsClasses = hubsSchedule.sunday;
                        break;
                      default:
                        dayHubsClasses = null;
                    }

                    // Get EPIC classes for this day and week
                    List<ClassScheduleEPIC> dayEpicClasses = [];
                    for (var epicClass in epicSchedules) {
                      if ((epicClass.startWeek == weekIndex ||
                              epicClass.endWeek == weekIndex) &&
                          epicClass.weekday == (dayIndex + 1).toString()) {
                        dayEpicClasses.add(epicClass);
                      }
                    }

                    return Expanded(
                      child: Container(
                        height: 12 * _slotHeight,
                        decoration: BoxDecoration(
                          border: Border(
                            top: BorderSide(
                              color: Theme.of(context).dividerColor,
                              width: 0.5,
                            ),
                            left: BorderSide(
                              color: Theme.of(context).dividerColor,
                              width: 0.5,
                            ),
                          ),
                        ),
                        child: Stack(
                          children: [
                            ...(_buildClassesForDay(context, dayHubsClasses)),
                            ...(_buildEpicClassesForDay(
                              context,
                              dayEpicClasses,
                            )),
                          ],
                        ),
                      ),
                    );
                  }),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  // Keep existing method for HUBS classes
  List<Widget> _buildClassesForDay(
    BuildContext context,
    List<ClassScheduleHubs>? classes,
  ) {
    if (classes == null || classes.isEmpty) {
      return [];
    }

    List<Widget> widgets = [];

    for (var classItem in classes) {
      if (classItem.startLessonIndex == null ||
          classItem.endLessonIndex == null) {
        continue;
      }

      int startSlot =
          (int.tryParse(classItem.startLessonIndex!) ?? 1) -
          1; // Convert to 0-based index
      int spanCount =
          (int.tryParse(classItem.endLessonIndex!) ?? 0) -
          (int.tryParse(classItem.startLessonIndex!) ?? 0) +
          1;

      // Some validation to avoid layout issues
      if (startSlot < 0) startSlot = 0;
      if (startSlot >= 12) continue; // Out of our display range
      if (startSlot + spanCount > 12) spanCount = 12 - startSlot;

      widgets.add(
        Positioned(
          top: startSlot * _slotHeight, // Using the constant
          left: 0,
          right: 0,
          height: spanCount * _slotHeight, // Using the constant
          child: Padding(
            padding: const EdgeInsets.all(2.0),
            child: _buildClassCard(context, classItem),
          ),
        ),
      );
    }

    return widgets;
  }

  // Add new method for EPIC classes
  List<Widget> _buildEpicClassesForDay(
    BuildContext context,
    List<ClassScheduleEPIC> classes,
  ) {
    if (classes.isEmpty) {
      return [];
    }

    List<Widget> widgets = [];

    for (var classItem in classes) {
      if (classItem.startLessonIndex == null ||
          classItem.endLessonIndex == null) {
        continue;
      }

      int startSlot = (int.tryParse(classItem.startLessonIndex!) ?? 1) - 1;
      int spanCount =
          (int.tryParse(classItem.endLessonIndex!) ?? 0) -
          (int.tryParse(classItem.startLessonIndex!) ?? 0) +
          1;

      // Some validation to avoid layout issues
      if (startSlot < 0) startSlot = 0;
      if (startSlot >= 12) continue; // Out of our display range
      if (startSlot + spanCount > 12) spanCount = 12 - startSlot;

      widgets.add(
        Positioned(
          top: startSlot * _slotHeight,
          left: 0,
          right: 0,
          height: spanCount * _slotHeight,
          child: Padding(
            padding: const EdgeInsets.all(2.0),
            child: _buildEpicClassCard(context, classItem),
          ),
        ),
      );
    }

    return widgets;
  }

  Widget _buildClassCard(BuildContext context, ClassScheduleHubs classItem) {
    final theme = Theme.of(context);

    // Generate a consistent color based on the class name
    final int hashCode = classItem.courseName?.hashCode ?? 0;
    final List<Color> colors = [
      Colors.blue.shade100,
      Colors.green.shade100,
      Colors.amber.shade100,
      Colors.purple.shade100,
      Colors.cyan.shade100,
      Colors.orange.shade100,
      Colors.teal.shade100,
    ];
    final Color cardColor = colors[hashCode.abs() % colors.length];

    return Card(
      margin: EdgeInsets.zero,
      color: cardColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: BorderSide(color: theme.primaryColor.withAlpha(75), width: 0.5),
      ),
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 2.0, horizontal: 4.0),
        child: LayoutBuilder(
          builder: (context, constraints) {
            // Calculate available height for text
            final double availableHeight = constraints.maxHeight;
            // Estimate how many lines can fit (considering spacing and the extra field)
            final int maxLines = ((availableHeight - 14) / 12).floor();
            // Ensure at least 1 line for each text widget
            final int mainTextLines = maxLines > 2 ? maxLines - 1 : 1;

            return Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Course name with auto-wrap and dynamic max lines
                Expanded(
                  child: Text(
                    '${classItem.courseName ?? '未知课程'}${classItem.classroomName != null ? '\n@${classItem.classroomName}' : ''}',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 10,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: mainTextLines,
                  ),
                ),
                // Empty text field for future use
                const Text(
                  '',
                  style: TextStyle(fontSize: 9, color: Colors.black54),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  // Add new card builder for EPIC classes
  Widget _buildEpicClassCard(
    BuildContext context,
    ClassScheduleEPIC classItem,
  ) {
    final theme = Theme.of(context);

    // Use a different color scheme for EPIC classes
    final int hashCode = classItem.courseName?.hashCode ?? 0;
    final List<Color> colors = [
      Colors.pink.shade100,
      Colors.indigo.shade100,
      Colors.deepPurple.shade100,
      Colors.lime.shade100,
      Colors.brown.shade100,
      Colors.deepOrange.shade100,
      Colors.lightBlue.shade100,
    ];
    final Color cardColor = colors[hashCode.abs() % colors.length];

    return Card(
      margin: EdgeInsets.zero,
      color: cardColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: BorderSide(color: theme.primaryColor.withAlpha(75), width: 0.5),
      ),
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 2.0, horizontal: 4.0),
        child: LayoutBuilder(
          builder: (context, constraints) {
            final double availableHeight = constraints.maxHeight;
            final int maxLines = ((availableHeight - 14) / 12).floor();
            final int mainTextLines = maxLines > 2 ? maxLines - 1 : 1;

            return Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    '${classItem.courseName ?? '未知课程'}${classItem.classroomName != null ? '\n@${classItem.classroomName}' : ''}',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 10,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: mainTextLines,
                  ),
                ),
                Text(
                  classItem.teacherName ?? '',
                  style: const TextStyle(fontSize: 9, color: Colors.black54),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
