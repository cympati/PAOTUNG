class Notifications {
  int id;
  String name;
  String dateTime;

  Notifications({
    required this.id,
    required this.name,
    required this.dateTime
  });

  factory Notifications.fromJson(Map<String, dynamic> json) {
    return Notifications(
      id: json["id"], 
      name: json["name"],
      dateTime: json["date_time"]
      );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id, 
      "name": name,
      "dateTime": dateTime
      };
  }
}

class NotificationResponse{
  //String message;
  bool success;
  String code;
  List<Notifications> data;

  NotificationResponse(this.success, this.code, this.data, );

  factory NotificationResponse.fromJson(Map<String, dynamic> json) {
    var notification = json['data'] != null ? json['data'] as List  : List.empty();
    List<Notifications> tempNotification = notification.map((e) => Notifications.fromJson(e)).toList();
    
    return NotificationResponse(
      json['success'], 
      json['code'], 
      tempNotification, 
      //json['message'],
      );
  }
}

class AddNotiResponse {
  bool success;
  String message;
  Notifications data;
  //String userId;

  AddNotiResponse({
    required this.success,
    required this.message,
    required this.data,
    
  });

  factory AddNotiResponse.fromJson(Map<String, dynamic> json) {
    return AddNotiResponse(
      success: json['success'],
      message: json['message'],
      //userId: json['userId'],
      data: Notifications.fromJson(json['data']),
    );
  }
}
