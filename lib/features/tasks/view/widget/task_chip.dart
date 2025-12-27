import 'package:flutter/material.dart';

class TaskChip extends StatelessWidget {
  const TaskChip(
      {super.key,
      required this.label,
      required this.chipColor,
      this.chipTextColor = Colors.white});

  final String label;
  final Color chipColor;
  final Color? chipTextColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 2.0,
        horizontal: 15.0,
      ),
      decoration: BoxDecoration(
        color: chipColor,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: chipTextColor,
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
