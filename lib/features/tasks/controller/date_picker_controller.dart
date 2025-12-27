import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_app/features/tasks/view/helper/helper.dart';

class DatePickerController extends GetxController {

  Rx<DateTime?> selectedDate = Rx<DateTime?>(null);

  String? get isoFormattedDate {
    if (selectedDate.value == null) return null;
    return selectedDate.value!.toUtc().toIso8601String();
  }

  String get displayDate {
    if (selectedDate.value == null) return 'Select Date';
    final date = selectedDate.value!;
    return '${date.day} ${Helper.getMonthName(date.month)} ${date.year.toString().substring(2)}';
  }


  Future<void> pickDate() async {
    DateTime? pickedDate = await showDatePicker(
      context: Get.context!,
      initialDate: selectedDate.value ?? DateTime.now(),
      firstDate: DateTime(2025),
      lastDate: DateTime(2100),
    );
    if (pickedDate != null) {
      selectedDate.value = pickedDate;
    }
  }

}
