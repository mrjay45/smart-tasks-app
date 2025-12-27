import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_app/features/tasks/view/widget/filter_widget.dart';

import '../controller/date_picker_controller.dart';
import '../controller/task_controller.dart';
import './widget/bottom_sheet.dart';
import 'task_view.dart';
import 'widget/task_status_summary.dart';

class TaskHomeView extends StatelessWidget {
  TaskHomeView({super.key});

  final TaskController taskController = Get.put(TaskController());
  final DatePickerController datePickerController =
      Get.put(DatePickerController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff0f1f5),
      appBar: AppBar(
        title: const Text('Task Home View'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => bottomSheet(taskController, datePickerController),
        child: const Icon(Icons.add),
      ),
      body: Column(
        children: [
          // shows pending, in progress, completed counts
          TaskStatusSummary(),

          // custom search bar
          Container(
            margin: const EdgeInsets.all(16),
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: -4,
                  blurRadius: 10,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: TextField(
              textAlignVertical: TextAlignVertical.center,
              decoration: InputDecoration(
                icon: const Icon(
                  Icons.search,
                  size: 28,
                ),
                hintText: 'Search tasks',
                border: InputBorder.none,
                suffixIcon: IconButton(
                  onPressed: () {
                    Get.dialog(
                      FilterWidget(),
                    );
                  },
                  icon: const Icon(Icons.filter_list_rounded),
                ),
              ),
              onSubmitted: (value) {
                // Implement search functionality here
                if (value.isNotEmpty) {
                  taskController.isFiltered.value = true;
                  taskController.filteredTasksList.value =
                      taskController.allTasks.where((task) {
                    return task.title
                            .toLowerCase()
                            .contains(value.toLowerCase()) ||
                        (task.description ?? '')
                            .toLowerCase()
                            .contains(value.toLowerCase());
                  }).toList();
                } else {
                  taskController.isFiltered.value = false;
                }
              },
            ),
          ),

          Expanded(
            child: TaskView(taskController: taskController),
          ),
        ],
      ),
    );
  }
}
