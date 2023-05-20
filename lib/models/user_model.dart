class UserModel {
  static const String COLLECTION_NAME = 'Users';
  String name;
  String email;
  String age;
  String id;

  UserModel(
      {required this.name,
      required this.email,
      required this.age,
      this.id = ""});

  UserModel.fromJson(Map<String, dynamic> json)
      : this(
          id: json['id'],
          name: json['name'],
          email: json['email'],
          age: json['age'],
        );

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "email": email,
      "age": age,
    };
  }
}
