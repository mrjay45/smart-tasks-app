class TaskModel {
  String id;
  String title;
  String? description;
  DateTime? createdAt;
  String? category;
  String? priority;
  String? status;
  String? assignedTo;
  DateTime? dueDate;
  ExtractedEntities? extractedEntities;
  List<String>? suggestedActions;
  DateTime? updatedAt;

  TaskModel({
    required this.id,
    required this.title,
    this.description,
    this.createdAt,
    this.category,
    this.priority,
    this.status,
    this.assignedTo,
    this.dueDate,
    this.extractedEntities,
    this.suggestedActions,
    this.updatedAt,
  });

  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      createdAt:
          json['created_at'] != null ? DateTime.parse(json['created_at']) : null,
      category: json['category'],
      priority: json['priority'],
      status: json['status'],
      assignedTo: json['assigned_to'],
      dueDate: json['due_date'] != null ? DateTime.parse(json['due_date']) : null,
      extractedEntities: json['extracted_entities'] != null
          ? ExtractedEntities.fromJson(json['extracted_entities'])
          : null,
      suggestedActions: json['suggested_actions'] != null
          ? List<String>.from(json['suggested_actions'])
          : null,
      updatedAt:
          json['updated_at'] != null ? DateTime.parse(json['updated_at']) : null,
    );
  }
}

class ExtractedEntities {
  String? date;
  String? action;
  String? person;
  String? location;
  String? time;

  ExtractedEntities({
    this.date,
    this.action,
    this.person,
    this.location,
    this.time,
  });
  factory ExtractedEntities.fromJson(Map<String, dynamic> json) {
    return ExtractedEntities(
      date: json['date'],
      action: json['action'],
      person: json['person'],
      location: json['location'],
      time: json['time'],
    );
  }
}
