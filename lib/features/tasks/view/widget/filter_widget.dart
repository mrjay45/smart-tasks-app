import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_app/features/tasks/controller/task_controller.dart';

class FilterWidget extends StatelessWidget {
  FilterWidget({super.key});

  final TaskController taskController = Get.find<TaskController>();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AlertDialog(
            title: const Text('Select Filtered'),
            titleTextStyle: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
            content: Column(
              children: [
                DropdownMenu(
                  expandedInsets: EdgeInsets.zero,
                  label: const Text('Select Category'),
                  dropdownMenuEntries: const [
                    DropdownMenuEntry(value: 'scheduling', label: 'scheduling'),
                    DropdownMenuEntry(value: 'finance', label: 'finance'),
                    DropdownMenuEntry(value: 'technical', label: 'technical'),
                    DropdownMenuEntry(value: 'safety', label: 'safety'),
                    DropdownMenuEntry(value: 'general', label: 'general'),
                  ],
                  onSelected: (val) {
                    taskController.filterCategory.value = val;
                  },
                ),
                const SizedBox(height: 16),
                DropdownMenu(
                  expandedInsets: EdgeInsets.zero,
                  label: const Text('Select Priority'),
                  dropdownMenuEntries: const [
                    DropdownMenuEntry(value: 'low', label: 'low'),
                    DropdownMenuEntry(value: 'medium', label: 'medium'),
                    DropdownMenuEntry(value: 'high', label: 'high'),
                  ],
                  onSelected: (val) {
                    taskController.filterPriority.value = val;
                  },
                ),
                const SizedBox(height: 16),
                DropdownMenu(
                  expandedInsets: EdgeInsets.zero,
                  label: const Text('Select Status'),
                  dropdownMenuEntries: const [
                    DropdownMenuEntry(value: 'pending', label: 'pending'),
                    DropdownMenuEntry(
                        value: 'in_progress', label: 'in_progress'),
                    DropdownMenuEntry(value: 'completed', label: 'completed'),
                  ],
                  onSelected: (val) {
                    taskController.filterStatus.value = val;
                  },
                ),
              ],
            ),
            actions: [
              ElevatedButton(
                style: const ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(
                    Color(0xff226bde),
                  ),
                  foregroundColor: WidgetStatePropertyAll(
                    Colors.white,
                  ),
                ),
                onPressed: () async {
                  Get.back();
                  await taskController.filterTask();

                  taskController.filterCategory.value = null;
                  taskController.filterPriority.value = null;
                  taskController.filterStatus.value = null;
                },
                child: const Text('Filter'),
              ),
              TextButton(
                onPressed: () {
                  Get.back();
                },
                child: const Text('Close'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
