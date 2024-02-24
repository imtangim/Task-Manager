class TaskModel {
  final String id;
  final String title;
  final String description;
  final String status;
  final String createdDate;

  TaskModel({
    required this.id,
    required this.title,
    required this.description,
    required this.status,
    required this.createdDate,
  });

  // Factory method to create TaskModel from JSON
  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
      id: json['_id'],
      title: json['title'],
      description: json['description'],
      status: json['status'],
      createdDate: json['createdDate'],
    );
  }
  // Method to convert TaskModel to JSON
  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'title': title,
      'description': description,
      'status': status,
      'createdDate': createdDate,
    };
  }
}
