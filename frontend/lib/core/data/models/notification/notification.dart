class Notifications {
  int id;
  String name;

  Notifications({
    required this.id,
    required this.name,
  });

  factory Notifications.fromJson(Map<String, dynamic> json) {
    return Notifications(id: json["id"], name: json["name"]);
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id, 
      "name": name
      };
  }
}
