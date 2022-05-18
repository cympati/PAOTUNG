class User {
  String imagePath;
  String email;
  String username;
  int balance;

  User({
    required this.imagePath,
    required this.email,
    required this.username,
    required this.balance,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        imagePath: json["path_profile_picture"],
        email: json["email"],
        username: json["user_name"],
        balance: json["balance"]);
  }
}

class UserResponse {
  bool success;
  String code;
  User data;

  UserResponse({required this.success, required this.code, required this.data});

  factory UserResponse.fromJson(Map<String, dynamic> json) {
    return UserResponse(
        success: json['success'],
        code: json['code'],
        data: User.fromJson(json['data']));
  }
}

class InfoResponse {
  bool success;
  String code;
  String message;

  InfoResponse({required this.success, required this.code, required this.message});

  factory InfoResponse.fromJson(Map<String, dynamic> json) {
    return InfoResponse(
        success: json["success"], code: json["code"] ?? "", message: json["message"]);
  }
}

