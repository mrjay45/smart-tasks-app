import 'dart:ui';

class Helper {
  static getMonthName(int month) {
    if (month == 1) return 'Jan';
    if (month == 2) return 'Feb';
    if (month == 3) return 'Mar';
    if (month == 4) return 'Apr';
    if (month == 5) return 'May';
    if (month == 6) return 'Jun';
    if (month == 7) return 'Jul';
    if (month == 8) return 'Aug';
    if (month == 9) return 'Sep';
    if (month == 10) return 'Oct';
    if (month == 11) return 'Nov';
    return 'Dec';
  }

  static Color getCategoryColor(String category) {
    switch (category.toLowerCase()) {
      case 'scheduling':
        return const Color(0xff3B82F6);
      case 'finance':
        return const Color(0xff22C55E);
      case 'technical':
        return const Color(0xff8B5CF6);
      case 'safety':
        return const Color(0xffEF4444);
      default:
        return const Color(0xff6B7280);
    }
  }

  static Color getPriorityColor(String priority) {
    switch (priority.toLowerCase()) {
      case 'high':
        return const Color(0xffd90707);
      case 'medium':
        return const Color(0xfff97316);
      default:
        return const Color(0xff10b981);
    }
  }

  static String getStatusIcon(String status) {
    switch (status.toLowerCase()) {
      case 'completed':
        return 'assets/complete.svg';
      case 'in progress' || 'in_progress':
        return 'assets/in_progress.svg';
      default:
        return 'assets/pending.svg';
    }
  }
}
