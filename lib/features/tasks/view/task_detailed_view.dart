import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/task_controller.dart';
import 'helper/helper.dart';
import 'widget/task_chip.dart';

class TaskDetailedView extends StatelessWidget {
  TaskDetailedView({super.key, required this.taskId});

  final String taskId;
  final TaskController _taskController = Get.find<TaskController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final task = _taskController.getTaskById(taskId);

      if (task == null) {
        return Center(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Text('Task not found',
                style: Theme.of(context).textTheme.bodyLarge),
          ),
        );
      }

      return AlertDialog(
        title: const Text('Task Details'),
        content: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: 650.0,
            ),
            child: Column(
              // mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 24,
                      child: Text(
                        task.assignedTo.isNotEmpty
                            ? task.assignedTo[0].toUpperCase()
                            : '?',
                        style:
                            const TextStyle(fontSize: 20, color: Colors.white),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          task.title,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'Assigned to: ${task.assignedTo}',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Wrap(
                  runSpacing: 8,
                  children: [
                    Row(
                      children: [
                        TaskChip(
                          label: task.category,
                          chipColor: Helper.getCategoryColor(task.category),
                        ),
                        const SizedBox(width: 8),
                        TaskChip(
                          label: task.status,
                          chipColor: Helper.getStatusColor(task.status),
                        ),
                        const SizedBox(width: 8),
                        TaskChip(
                          label: task.priority,
                          chipColor: Helper.getPriorityColor(task.priority),
                        ),
                      ],
                    ),
                    Text(
                      task.dueDate != null
                          ? '${task.dueDate!.day} ${Helper.getMonthName(task.dueDate!.month)} ${task.dueDate!.year}'
                          : 'No Due Date',
                      style: const TextStyle(fontSize: 14),
                    ),
                  ],
                ),
                const Divider(height: 32),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Category',
                        style: TextStyle(fontWeight: FontWeight.w500)),
                    TaskChip(
                      label: task.category,
                      chipColor: Helper.getCategoryColor(task.category),
                    ),
                  ],
                ),
                const Divider(height: 32),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Priority',
                        style: TextStyle(fontWeight: FontWeight.w500)),
                    TaskChip(
                      label: task.priority,
                      chipColor: Helper.getPriorityColor(task.priority),
                    ),
                  ],
                ),
                const Divider(height: 32),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Status',
                        style: TextStyle(fontWeight: FontWeight.w500)),
                    TaskChip(
                      label: task.status,
                      chipColor: Helper.getStatusColor(task.status),
                    ),
                  ],
                ),
                const Divider(height: 32),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Row(
                      children: [
                        Icon(Icons.calendar_today_rounded, size: 16),
                        SizedBox(width: 5),
                        Text('Due Date',
                            style: TextStyle(fontWeight: FontWeight.w500)),
                      ],
                    ),
                    Row(
                      children: [
                        const Icon(Icons.date_range, size: 16),
                        const SizedBox(width: 5),
                        Text(
                          task.dueDate != null
                              ? '${task.dueDate!.day} ${Helper.getMonthName(task.dueDate!.month)} ${task.dueDate!.year}'
                              : 'No Due Date',
                        ),
                      ],
                    ),
                  ],
                ),
                const Divider(height: 32),
                Text('Description',
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Colors.grey[700],
                        fontSize: 16)),
                const SizedBox(height: 8),
                Text(
                  task.description.isNotEmpty
                      ? task.description
                      : 'No description provided.',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontSize: 14),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
