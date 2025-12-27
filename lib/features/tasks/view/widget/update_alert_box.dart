import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_app/features/tasks/view/helper/helper.dart';

import '../../controller/date_picker_controller.dart';
import '../../controller/update_controller.dart';
import '../../model/task_model.dart';

class UpdateAlertBox extends StatelessWidget {
  UpdateAlertBox({super.key, required this.task});
  final TaskModel task;

  final UpdateController updateController = Get.put(UpdateController());
  final datePickerController = Get.find<DatePickerController>();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Center(
        child: Text(
          'Update Task',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w600,
              ),
        ),
      ),
      content: SizedBox(
        width: MediaQuery.of(context).size.width * 0.9,
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height * 0.8,
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Assign to / Title
                Card(
                  elevation: 0,
                  color: Colors.grey[50],
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Assign to',
                            style: Theme.of(context)
                                .textTheme
                                .labelLarge
                                ?.copyWith(fontWeight: FontWeight.w600)),
                        const SizedBox(height: 6),
                        Text(task.assignedTo ?? 'Unassigned',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(color: Colors.black87)),
                        const SizedBox(height: 10),
                        TextField(
                          controller: updateController.assignedToController,
                          decoration: InputDecoration(
                            isDense: true,
                            filled: true,
                            fillColor: Colors.white,
                            hintText: 'Enter Assign to',
                            hintStyle: TextStyle(color: Colors.grey[600]),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(color: Colors.grey[300]!),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 10),

                // Status
                Card(
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Status',
                            style: Theme.of(context)
                                .textTheme
                                .labelLarge
                                ?.copyWith(fontWeight: FontWeight.w600)),
                        const SizedBox(height: 6),
                        Text('Current: ${task.status ?? 'unknown'}',
                            style: Theme.of(context).textTheme.bodySmall),
                        const SizedBox(height: 10),
                        Obx(
                          () => Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              SizedBox(
                                width: double.infinity,
                                child: DropdownMenu<String>(
                                  expandedInsets: EdgeInsets.zero,
                                  label: const Text('Select status'),
                                  dropdownMenuEntries: const [
                                    DropdownMenuEntry(
                                        value: 'pending', label: 'pending'),
                                    DropdownMenuEntry(
                                        value: 'in_progress',
                                        label: 'in progress'),
                                    DropdownMenuEntry(
                                        value: 'completed', label: 'completed'),
                                  ],
                                  initialSelection:
                                      updateController.initialStatus.value ??
                                          task.status,
                                  onSelected: (val) {
                                    updateController.initialStatus.value = val;
                                    print('Selected status: $val');
                                  },
                                ),
                              ),
                              Align(
                                alignment: Alignment.centerRight,
                                child: TextButton(
                                  onPressed: () {
                                    updateController.initialStatus.value = null;
                                  },
                                  child: const Text('Clear'),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 10),

                // Due date
                Card(
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Due Date',
                            style: Theme.of(context)
                                .textTheme
                                .labelLarge
                                ?.copyWith(fontWeight: FontWeight.w600)),
                        const SizedBox(height: 6),
                        Text(
                          task.dueDate != null
                              ? '${task.dueDate!.day} ${Helper.getMonthName(task.dueDate!.month)} ${task.dueDate!.year}'
                              : 'No Due Date',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                        const SizedBox(height: 10),
                        Obx(
                          () => Row(
                            children: [
                              Expanded(
                                child: TextField(
                                  readOnly: true,
                                  decoration: InputDecoration(
                                    isDense: true,
                                    filled: true,
                                    fillColor: Colors.white,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                    hintText: datePickerController
                                                .selectedDate.value ==
                                            null
                                        ? 'Select Date'
                                        : datePickerController.displayDate,
                                    hintStyle: TextStyle(
                                      color: datePickerController
                                                  .selectedDate.value ==
                                              null
                                          ? Colors.grey
                                          : Colors.black,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 16,
                                    ),
                                    prefixIcon: const Icon(
                                        Icons.calendar_today_rounded),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8),
                              IconButton(
                                tooltip: 'Pick date',
                                icon: const Icon(Icons.calendar_month_rounded),
                                onPressed: () async {
                                  await datePickerController.pickDate();
                                },
                              ),
                              IconButton(
                                tooltip: 'Clear date',
                                icon: const Icon(Icons.clear_rounded),
                                onPressed: () {
                                  datePickerController.selectedDate.value =
                                      null;
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 10),

                // Priority and Category side-by-side on wider screens
                Row(
                  children: [
                    Expanded(
                      child: Card(
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Priority',
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelLarge
                                      ?.copyWith(fontWeight: FontWeight.w600)),
                              const SizedBox(height: 6),
                              Text('Current: ${task.priority ?? 'none'}',
                                  style: Theme.of(context).textTheme.bodySmall),
                              const SizedBox(height: 10),
                              DropdownMenu<String>(
                                expandedInsets: EdgeInsets.zero,
                                dropdownMenuEntries: const [
                                  DropdownMenuEntry(value: 'low', label: 'low'),
                                  DropdownMenuEntry(
                                      value: 'medium', label: 'medium'),
                                  DropdownMenuEntry(
                                      value: 'high', label: 'high'),
                                ],
                                initialSelection: task.priority,
                                onSelected: (val) {
                                  updateController.priority.value = val;
                                  print('Selected priority: $val');
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Card(
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Category',
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelLarge
                                      ?.copyWith(fontWeight: FontWeight.w600)),
                              const SizedBox(height: 6),
                              Text('Current: ${task.category ?? 'none'}',
                                  style: Theme.of(context).textTheme.bodySmall),
                              const SizedBox(height: 10),
                              DropdownMenu<String>(
                                expandedInsets: EdgeInsets.zero,
                                dropdownMenuEntries: const [
                                  DropdownMenuEntry(
                                      value: 'scheduling', label: 'scheduling'),
                                  DropdownMenuEntry(
                                      value: 'finance', label: 'finance'),
                                  DropdownMenuEntry(
                                      value: 'technical', label: 'technical'),
                                  DropdownMenuEntry(
                                      value: 'safety', label: 'safety'),
                                  DropdownMenuEntry(
                                      value: 'general', label: 'general'),
                                ],
                                initialSelection: task.category,
                                onSelected: (val) {
                                  updateController.category.value = val;
                                  print('Selected category: $val');
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
              ],
            ),
          ),
        ),
      ),
      actions: [
        ElevatedButton(
          onPressed: () async {
            final Map<String, dynamic> updatedData = {};
            if (updateController.assignedToController.text.isNotEmpty) {
              updatedData['assigned_to'] =
                  updateController.assignedToController.text;
            }
            if (updateController.initialStatus.value != null) {
              updatedData['status'] = updateController.initialStatus.value;
            }
            if (datePickerController.selectedDate.value != null) {
              updatedData['due_date'] =
                  datePickerController.selectedDate.value!.toIso8601String();
            }
            if (updateController.category.value != null) {
              updatedData['category'] = updateController.category.value;
            }
            if (updateController.priority.value != null) {
              updatedData['priority'] = updateController.priority.value;
            }

            datePickerController.selectedDate.value = null;
            Get.back();
            await updateController.updateTaskData(task.id, updatedData);
          },
          child: const Text('Update'),
        ),
        TextButton(
          onPressed: () {
            datePickerController.selectedDate.value = null;
            Get.back();
          },
          child: const Text('Close'),
        ),
      ],
    );
  }
}
