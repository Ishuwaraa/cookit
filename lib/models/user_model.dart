class UserModel {

  final String userId;

  UserModel({required this.userId});
}

class UserData {

  final String userId;
  final String name;
  final String email;
  final String profilePicUrl;

  UserData({required this.userId, required this.name, required this.email, required this.profilePicUrl});
}