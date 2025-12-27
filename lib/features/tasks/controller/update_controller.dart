import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_app/core/api/api_service.dart';
import 'package:task_app/features/tasks/controller/task_controller.dart';

// {
//   "status": "string",
//   "assigned_to": "string",
//   "due_date": "2025-12-26T15:31:59.166Z",
//   "category": "string",
//   "priority": "string"
// }

class UpdateController extends GetxController {
  RxnString initialStatus = RxnString(null);
  RxnString assignedTo = RxnString(null);
  RxnString dueDate = RxnString(null);
  RxnString category = RxnString(null);
  RxnString priority = RxnString(null);

  TextEditingController assignedToController = TextEditingController();

  updateTaskData(String? taskId, Map<String, dynamic> updatedData) async {
    try {
      await ApiService().updateTask(taskId, updatedData);
      // Refresh the central task list so UI updates without a hot restart
      try {
        final TaskController taskController = Get.find<TaskController>();
        await taskController.fetchTasks();
      } catch (_) {
        // If TaskController isn't registered, ignore silently
      }
    } catch (e) {
      throw Exception('Error updating task: $e');
    }
  }
}
