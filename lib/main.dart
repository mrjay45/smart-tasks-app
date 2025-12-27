import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_app/core/api/api_service.dart';
import 'package:task_app/features/tasks/view/task_home_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Task App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: TaskHomeView(),
    );
  }
}
