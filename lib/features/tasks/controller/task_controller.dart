import 'package:get/get.dart';
import 'package:task_app/core/api/api_service.dart';
import 'package:task_app/features/tasks/model/task_model.dart';

class TaskController extends GetxController {
  RxList<TaskModel> allTasks = <TaskModel>[].obs;
  RxBool isLoading = false.obs;
  RxString error = ''.obs;
  RxBool isFiltered = false.obs;

  RxString selectedCategory = ''.obs;
  RxString selectedPriority = ''.obs;

  RxList<TaskModel> filteredTasksList = <TaskModel>[].obs;
  RxnString filterStatus = RxnString(null);
  RxnString filterCategory = RxnString(null);
  RxnString filterPriority = RxnString(null);

  RxInt pendingCount = 0.obs;
  RxInt inProgressCount = 0.obs;
  RxInt completedCount = 0.obs;

  ApiService apiService = ApiService();

  @override
  void onInit() {
    super.onInit();
    fetchTasks();
  }

  Future<void> fetchTasks() async {
    try {
      isLoading.value = true;
      error.value = '';
      final fetchTasks = await apiService.fetchTasks();
      allTasks.assignAll(fetchTasks);
      pendingCount.value =
          allTasks.where((task) => task.status == 'pending').length;
      inProgressCount.value =
          allTasks.where((task) => task.status == 'in_progress').length;
      completedCount.value =
          allTasks.where((task) => task.status == 'completed').length;
      isFiltered.value = false;
    } catch (e) {
      error.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  Future<String?> addTask({
    required String addTaskTitle,
    required String addTaskDescription,
    String? addTaskDate,
    String? addTaskAssigner,
  }) async {
    try {
      isLoading.value = true;
      error.value = '';

      final Map<String, dynamic> taskData = {
        "title": addTaskTitle,
        "description": addTaskDescription,
        "due_date": addTaskDate,
        "assigned_to": addTaskAssigner,
      };
      final String? taskId = await apiService.createTask(taskData);

      return taskId; // Return the created task ID
    } catch (e) {
      error.value = e.toString();
      return null;
    } finally {
      isLoading.value = false;
    }
  }

  getTaskById(String taskId) {
    try {
      return allTasks.firstWhere((task) => task.id == taskId);
    } catch (e) {
      return null;
    }
  }

  Future<void> updateTask({
    required String? taskId,
    required Map<String, dynamic> updatedData,
  }) async {
    try {
      print('Updating task: $taskId with data: $updatedData');
      await apiService.updateTask(taskId, updatedData);
      print('Task updated successfully in controller');
      // Refresh local task list so UI reflects the updated data
      await fetchTasks();
    } catch (e) {
      print('Error in updateTask controller: $e');
      error.value = e.toString();
    }
  }

  Future<void> filterTask() async {
    try {
      isLoading.value = true;
      error.value = '';
      final filteredTasks = await apiService.filterTasksByStatus(
          status: filterStatus.value,
          category: filterCategory.value,
          priority: filterPriority.value);
      filteredTasksList.assignAll(filteredTasks ?? []);
      print('Filtered Tasks: $filteredTasksList');
      isFiltered.value = true;
    } catch (e) {
      error.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  deleteTask(String? id) async {
    try {
      isLoading.value = true;
      error.value = '';
      await apiService.deleteTask(id);
      allTasks.removeWhere((task) => task.id == id);
      pendingCount.value =
          allTasks.where((task) => task.status == 'pending').length;
      inProgressCount.value =
          allTasks.where((task) => task.status == 'in_progress').length;
      completedCount.value =
          allTasks.where((task) => task.status == 'completed').length;
    } catch (e) {
      error.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  int getNumberOfTasksByStatus(String status) {
    return allTasks.where((task) => task.status == status).length;
  }
}
