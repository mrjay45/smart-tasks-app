import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../controller/task_controller.dart';
import './widget/task_chip.dart';
import 'helper/helper.dart';
import 'widget/update_alert_box.dart';

class TaskView extends StatelessWidget {
  const TaskView({super.key, required this.taskController});

  final TaskController taskController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xfff0f1f5),
        body: Obx(() {
          if (taskController.isLoading.value) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (taskController.error.value.isNotEmpty) {
            return Center(
              child: Text(
                taskController.error.value,
                style: const TextStyle(color: Colors.red, fontSize: 18),
              ),
            );
          } else {
            return RefreshIndicator(
              color: Colors.red,
              backgroundColor: Colors.white,
              onRefresh: () async {
                await taskController.fetchTasks();
              },
              child: ListView.builder(
                physics: const AlwaysScrollableScrollPhysics(),
                itemCount: taskController.isFiltered.value
                    ? taskController.filteredTasksList.length
                    : taskController.allTasks.length,
                itemBuilder: (context, index) {
                  final task = taskController.isFiltered.value
                      ? taskController.filteredTasksList[index]
                      : taskController.allTasks[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 10.0,
                      horizontal: 15.0,
                    ),
                    child: Slidable(
                      key: Key(index.toString()),
                      endActionPane: ActionPane(
                        motion: const StretchMotion(),
                        children: [
                          SlidableAction(
                            onPressed: (context) {
                              taskController.deleteTask(task.id);
                            },
                            backgroundColor: Colors.red,
                            foregroundColor: Colors.white,
                            icon: Icons.delete,
                            label: 'Delete',
                          ),
                          SlidableAction(
                            onPressed: (context) {
                              Get.dialog(UpdateAlertBox(task: task));
                            },
                            backgroundColor: Colors.blue,
                            foregroundColor: Colors.white,
                            icon: Icons.edit,
                            label: 'Edit',
                          ),
                        ],
                      ),
                      child: GestureDetector(
                        onTap: () {
                          Get.dialog(UpdateAlertBox(task: task));
                        },
                        child: Container(
                          constraints: BoxConstraints(
                            maxWidth: MediaQuery.of(context).size.width * 0.9,
                          ),
                          padding: const EdgeInsets.symmetric(
                            vertical: 15.0,
                            horizontal: 20.0,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            // color: Colors.blueAccent,
                            borderRadius: BorderRadius.circular(15.0),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: -4,
                                blurRadius: 7,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Wrap(
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    flex: 3,
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          task.title,
                                          style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        const SizedBox(height: 10),
                                        Wrap(
                                          spacing: 10,
                                          runSpacing: 5,
                                          children: [
                                            TaskChip(
                                              label: task.category ?? 'General',
                                              chipColor:
                                                  Helper.getCategoryColor(
                                                task.category ?? 'general',
                                              ),
                                            ),
                                            TaskChip(
                                              label: task.priority ?? 'Low',
                                              chipColor:
                                                  Helper.getPriorityColor(
                                                task.priority ?? 'low',
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    flex: 2,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                task.dueDate != null
                                                    ? '${task.dueDate!.day} ${Helper.getMonthName(task.dueDate!.month)}'
                                                    : 'No Due Date',
                                                style: const TextStyle(
                                                  fontSize: 16,
                                                  color: Color(0xff5c6a7a),
                                                  fontWeight: FontWeight.w500,
                                                ),
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                              const SizedBox(height: 5),
                                              Row(
                                                children: [
                                                  const Icon(
                                                    Icons.person,
                                                    size: 16,
                                                    color: Color(0xff5c6a7a),
                                                  ),
                                                  const SizedBox(width: 5),
                                                  Expanded(
                                                    child: Text(
                                                      task.assignedTo ??
                                                          'Unassigned',
                                                      style: const TextStyle(
                                                        fontSize: 16,
                                                        color:
                                                            Color(0xff5c6a7a),
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                      maxLines: 1,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(width: 10),
                                        SvgPicture.asset(
                                          width: 50,
                                          height: 50,
                                          Helper.getStatusIcon(
                                              task.status ?? 'pending'),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            );
          }
        }));
  }
}
