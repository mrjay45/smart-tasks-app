import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomSnackbar {
  static void showError({
    String title = "Error",
    String message = "Title and description cannot be empty",
  }) {
    Get.snackbar(
      title,
      message,
      titleText: Text(
        title,
        style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white),
      ),
      messageText: Text(
        message,
        style: const TextStyle(fontSize: 16, color: Colors.white),
      ),
      snackPosition: SnackPosition.TOP,
      colorText: Colors.white,
      backgroundColor: Colors.red,
      padding: const EdgeInsets.all(12.0),
      margin: const EdgeInsets.all(10.0),
      icon: const Icon(Icons.warning_amber_rounded,
          color: Colors.white),
      duration: const Duration(seconds: 3),
      borderRadius: 8.0,
      dismissDirection: DismissDirection.horizontal,
    );
  }
}