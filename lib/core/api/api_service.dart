import 'package:dio/dio.dart';

import '../../core/constants/app_constants.dart';
import '../../features/tasks/model/task_model.dart';

class ApiService {
  final Dio _dio = Dio();

  Future<List<TaskModel>> fetchTasks() async {
    print('Fetching tasks from API'); // Debug log
    try {
      final response = await _dio.get(
        AppConstants.apiBaseUrl + AppConstants.tasksGetEndpoint,
      );
      if (response.statusCode == 200 && response.data is List) {
        return (response.data as List)
            .map((json) => TaskModel.fromJson(json as Map<String, dynamic>))
            .toList();
      } else {
        throw Exception('Failed to load tasks: Invalid response');
      }
    } catch (e) {
      throw Exception('Failed to load tasks: $e');
    }
  }

  Future<String?> createTask(Map<String, dynamic> taskData) async {
    print('Sending task data: $taskData'); // Debug log
    try {
      final response = await _dio.post(
        AppConstants.apiBaseUrl + AppConstants.tasksPostEndpoint,
        data: taskData,
      );
      if (response.statusCode == 200) {
        print('Task created successfully');
        // Return the task ID from the response
        if (response.data != null && response.data is Map) {
          return response.data['id']?.toString();
        }
        return null;
      } else {
        throw Exception('Failed to create task: ${response.statusCode}');
      }
    } catch (e) {
      print('Error creating task: $e'); // Debug log
      rethrow;
    }
  }

  Future<void> updateTask(
      String? taskId, Map<String, dynamic> updatedData) async {
    try {
      final url =
          '${AppConstants.apiBaseUrl}${AppConstants.tasksUpdateEndpoint}/$taskId';
      final response = await _dio.patch(
        url,
        data: updatedData,
      );
      if (response.statusCode == 200) {
        print('Task updated successfully');
      } else {
        throw Exception('Failed to update task: ${response.statusCode}');
      }
    } catch (e) {
      print('Error updating task: $e');
      rethrow;
    }
  }

  Future<List<TaskModel>?> filterTasksByStatus(
      {String? status, String? category, String? priority}) async {
    try {
      const String url =
          '${AppConstants.apiBaseUrl}${AppConstants.tasksGetEndpoint}';
      final Map<String, dynamic> queryParameters = {};
      if (status != null && status.isNotEmpty) {
        queryParameters['status'] = status;
      }
      if (category != null && category.isNotEmpty) {
        queryParameters['category'] = category;
      }
      if (priority != null && priority.isNotEmpty) {
        queryParameters['priority'] = priority;
      }

      final response = await _dio.get(
        url,
        queryParameters: queryParameters.isEmpty ? null : queryParameters,
      );

      if (response.statusCode == 200) {
        return (response.data as List)
            .map((json) => TaskModel.fromJson(json as Map<String, dynamic>))
            .toList();
      }
      return null;
    } catch (e) {
      print('Error filtering tasks: $e');
      rethrow;
    }
  }

  Future<void> deleteTask(String? id) async {
    try {
      final url =
          '${AppConstants.apiBaseUrl}${AppConstants.tasksDeleteEndpoint}/$id';
      final response = await _dio.delete(url);

      if (response.statusCode == 200) {
        print('Task deleted successfully');
      } else {
        throw Exception('Failed to delete task: ${response.statusCode}');
      }
    } catch (e) {
      print('Error deleting task: $e');
      rethrow;
    }
  }
}
