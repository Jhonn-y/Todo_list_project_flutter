// ignore_for_file: public_member_api_docs, sort_constructors_first
class TaskModel {
  final int id;
  final String description;
  final DateTime dateTime;
  final bool isFinished;

  TaskModel({required this.id, required this.description, required this.dateTime, required this.isFinished});

  factory TaskModel.loadFromDB(Map<String, dynamic> task){
    return TaskModel(
      id: task['id'],
      description: task['description'],
      dateTime: DateTime.parse(task['date_time']),
      isFinished: task['ended'] == 1,
    );
  }

  TaskModel copyWith({
    int? id,
    String? description,
    DateTime? dateTime,
    bool? isFinished,
  }) {
    return TaskModel(
      id: id ?? this.id,
      description: description ?? this.description,
      dateTime: dateTime ?? this.dateTime,
      isFinished: isFinished ?? this.isFinished,
    );
  }
}
