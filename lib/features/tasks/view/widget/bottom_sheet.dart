import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_app/features/tasks/view/helper/helper.dart';
import 'package:task_app/features/tasks/view/widget/custom_snackbar.dart';
import 'package:task_app/features/tasks/view/widget/task_chip.dart';

import '../../controller/task_controller.dart';
import '../../controller/date_picker_controller.dart';

void bottomSheet(
    TaskController taskController, DatePickerController datePickerController) {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController assignerController = TextEditingController();

  final RxnString categoryId = RxnString(null);

  Get.bottomSheet(
    Material(
      borderRadius: BorderRadius.circular(20.0),
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Create Task",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Divider(),
              const Text(
                "Title *",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: titleController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    ),
                    hintText: 'Enter task title',
                    hintStyle: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
              const Text(
                "Description",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: descriptionController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    ),
                    hintText: 'Enter task description',
                    hintStyle: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Due Date',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w500),
                        ),
                        Obx(
                          () => TextField(
                            readOnly: true,
                            decoration: InputDecoration(
                              border: const OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)),
                              ),
                              hintText:
                                  datePickerController.selectedDate.value ==
                                          null
                                      ? 'Select Date'
                                      : datePickerController.displayDate,
                              hintStyle: TextStyle(
                                color:
                                    datePickerController.selectedDate.value ==
                                            null
                                        ? Colors.grey
                                        : Colors.black,
                                fontWeight: FontWeight.w400,
                                fontSize: 16,
                              ),
                              prefixIcon:
                                  const Icon(Icons.calendar_today_rounded),
                              suffixIcon: IconButton(
                                icon: const Icon(Icons.calendar_month_rounded),
                                onPressed: () async {
                                  await datePickerController.pickDate();
                                },
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Assigned To',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w500),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextField(
                            controller: assignerController,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)),
                              ),
                              hintText: 'Enter assigner name',
                              hintStyle: TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.w400,
                              ),
                              prefixIcon: Icon(Icons.person_rounded),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
              Container(
                color: Colors.grey[200],
                width: double.infinity,
                padding:
                    const EdgeInsets.symmetric(vertical: 10.0, horizontal: 8.0),
                child: const Text(
                  'Auto Classification:',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const Text(
                          "Category",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w400),
                        ),
                        const SizedBox(width: 15),
                        // Show category from API response or user selection
                        Obx(() {
                          // If user manually selected a category, show that
                          if (taskController
                              .selectedCategory.value.isNotEmpty) {
                            return TaskChip(
                              label: taskController.selectedCategory.value,
                              chipColor: Helper.getCategoryColor(
                                  taskController.selectedCategory.value),
                            );
                          }
                          // If task was created, show the auto-classified category from API
                          if (categoryId.value != null) {
                            final task =
                                taskController.getTaskById(categoryId.value!);
                            final category = task?.category ?? 'general';
                            return TaskChip(
                              label: category,
                              chipColor: Helper.getCategoryColor(category),
                            );
                          }
                          // Default state before task creation
                          return const TaskChip(
                            label: 'general',
                            chipColor: Color(0xff6B7280),
                          );
                        }),
                      ],
                    ),
                    IconButton(
                        onPressed: () {
                          if (titleController.text.isNotEmpty &&
                              descriptionController.text.isNotEmpty) {
                            Get.dialog(
                              AlertDialog(
                                title: const Text('Select Category'),
                                content: SingleChildScrollView(
                                  scrollDirection: Axis.vertical,
                                  child: ListBody(
                                    children: <Widget>[
                                      ListTile(
                                        title: const Text('scheduling'),
                                        onTap: () async {
                                          taskController.selectedCategory
                                              .value = 'scheduling';
                                          if (categoryId.value != null) {
                                            await taskController.updateTask(
                                              taskId: categoryId.value,
                                              updatedData: {
                                                'category': 'scheduling'
                                              },
                                            );
                                            // await taskController.fetchTasks();
                                          }
                                          Get.back();
                                        },
                                      ),
                                      ListTile(
                                        title: const Text('finance'),
                                        onTap: () async {
                                          taskController.selectedCategory
                                              .value = 'finance';
                                          if (categoryId.value != null) {
                                            await taskController.updateTask(
                                              taskId: categoryId.value,
                                              updatedData: {
                                                'category': 'finance'
                                              },
                                            );
                                            // await taskController.fetchTasks();
                                          }
                                          Get.back();
                                        },
                                      ),
                                      ListTile(
                                        title: const Text('technical'),
                                        onTap: () async {
                                          taskController.selectedCategory
                                              .value = 'technical';
                                          if (categoryId.value != null) {
                                            await taskController.updateTask(
                                              taskId: categoryId.value,
                                              updatedData: {
                                                'category': 'technical'
                                              },
                                            );
                                            // await taskController.fetchTasks();
                                          }
                                          Get.back();
                                        },
                                      ),
                                      ListTile(
                                        title: const Text('safety'),
                                        onTap: () async {
                                          taskController.selectedCategory
                                              .value = 'safety';
                                          if (categoryId.value != null) {
                                            await taskController.updateTask(
                                              taskId: categoryId.value,
                                              updatedData: {
                                                'category': 'safety'
                                              },
                                            );
                                            // await taskController.fetchTasks();
                                          }
                                          Get.back();
                                        },
                                      ),
                                      ListTile(
                                        title: const Text('general'),
                                        onTap: () async {
                                          taskController.selectedCategory
                                              .value = 'general';
                                          if (categoryId.value != null) {
                                            await taskController.updateTask(
                                              taskId: categoryId.value,
                                              updatedData: {
                                                'category': 'general'
                                              },
                                            );
                                            // await taskController.fetchTasks();
                                          }
                                          Get.back();
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                                actions: <Widget>[
                                  TextButton(
                                    child: const Text('Close'),
                                    onPressed: () {
                                      Get.back();
                                    },
                                  ),
                                ],
                              ),
                            );
                          } else {
                            CustomSnackbar.showError(
                                message:
                                    'First enter title and description and click save before');
                          }
                        },
                        icon: const Icon(Icons.arrow_forward_ios_rounded))
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Text(
                        "Priority",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w400),
                      ),
                      const SizedBox(width: 15),
                      Obx(() {
                        if (taskController.selectedPriority.value.isNotEmpty) {
                          return TaskChip(
                              label: taskController.selectedPriority.value,
                              chipColor: Helper.getCategoryColor(
                                  taskController.selectedPriority.value));
                        }

                        if (categoryId.value != null) {
                          final task =
                              taskController.getTaskById(categoryId.value!);
                          final priority = task?.priority ?? 'low';
                          return TaskChip(
                              label: priority,
                              chipColor: Helper.getCategoryColor(priority));
                        }

                        return TaskChip(
                            label: 'low',
                            chipColor: Helper.getCategoryColor('low'));
                      }),
                    ],
                  ),
                  IconButton(
                      onPressed: () {
                        if (titleController.value.text.isNotEmpty &&
                            descriptionController.value.text.isNotEmpty) {
                          Get.dialog(
                            AlertDialog(
                              title: const Text("Select Priority"),
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  ListTile(
                                    title: const Text("high"),
                                    onTap: () async {
                                      taskController.selectedPriority.value =
                                          "high";
                                      if (categoryId.value != null) {
                                        await taskController.updateTask(
                                            taskId: categoryId.value,
                                            updatedData: {'priority': 'high'});
                                      }
                                      Get.back();
                                    },
                                  ),
                                  ListTile(
                                    title: const Text('medium'),
                                    onTap: () async {
                                      taskController.selectedPriority.value =
                                          'medium';
                                      if (categoryId.value != null) {
                                        await taskController.updateTask(
                                            taskId: categoryId.value,
                                            updatedData: {
                                              'priority': 'medium'
                                            });
                                      }
                                    },
                                  ),
                                  ListTile(
                                    title: const Text('low'),
                                    onTap: () async {
                                      taskController.selectedPriority.value =
                                          'low';
                                      if (categoryId.value != null) {
                                        await taskController.updateTask(
                                            taskId: categoryId.value,
                                            updatedData: {'priority': 'low'});
                                      }
                                    },
                                  ),
                                ],
                              ),
                            ),
                          );
                        } else {
                          CustomSnackbar.showError(
                              message:
                                  'First enter title and description and click save before');
                        }
                      },
                      icon: const Icon(Icons.arrow_forward_ios_rounded))
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      onPressed: () async {
                        if (titleController.text.isEmpty) {
                          CustomSnackbar.showError();

                          return;
                        }
                        final createdTaskId = await taskController.addTask(
                          addTaskTitle: titleController.text,
                          addTaskDescription: descriptionController.text,
                          addTaskDate: datePickerController.isoFormattedDate,
                          addTaskAssigner: assignerController.text.isEmpty
                              ? null
                              : assignerController.text,
                        );
                        if (createdTaskId != null) {
                          // Fetch tasks to get the auto-classified category from API
                          await taskController.fetchTasks();
                          categoryId.value = createdTaskId;
                        }
                      },
                      child: const Text(
                        "Before saving",
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      onPressed: () async {
                        // Refresh the task list on main screen
                        if (titleController.value.text.isNotEmpty) {
                          await taskController.fetchTasks();

                          // Reset selected category
                          taskController.selectedCategory.value = '';

                          // Clear form fields
                          titleController.clear();
                          descriptionController.clear();
                          assignerController.clear();
                        }

                        Get.back();
                      },
                      child: const Text(
                        'refresh/cancel',
                        style: TextStyle(fontSize: 16, color: Colors.black),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    ),
  );
}
