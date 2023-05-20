class TaskModel {
  String id;
  String title;
  String description;
  int date;
  bool status;
  String userId;

  TaskModel(
      {this.id = "",
      required this.title,
      required this.description,
      required this.date,
      required this.userId,
      required this.status});

  TaskModel.fromJson(Map<String, dynamic> json)
      : this(
      id: json['id'],
            title: json['title'],
            description: json['description'],
            date: json['date'],
            userId: json['userId'],
            status: json['status']);

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "title": title,
      "description": description,
      "date": date,
      "userId": userId,
      "status": status,
    };
  }
}
