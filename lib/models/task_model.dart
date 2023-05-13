class TaskModel {
  String id;
  String title;
  String description;
  int date;
  bool status;

  TaskModel(
      {this.id = "",
      required this.title,
      required this.description,
      required this.date,
      required this.status});

  TaskModel.fromJson(Map<String, dynamic> json)
      : this(
            id: json['id'],
            title: json['title'],
            description: json['description'],
            date: json['date'],
            status: json['status']);

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "title": title,
      "description": description,
      "date": date,
      "status": status,
    };
  }
}
