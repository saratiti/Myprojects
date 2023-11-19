class User {
 int ?id;
  String username;
  String email;
  String fullName;
  String? password;
  late String image;
  String phone;

  User({
    this.id,
    required this.username,
    required this.email,
    required this.image,
    required this.fullName,
    required this.phone,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      
      id: json['user_id'] as int? ??0,
      username: json['username']?? '',
       email: json['email']?? '', 
       image: '',
       fullName: json['full_name']?? '',
        phone:json["phone"]?? '',);
  }

  Map<String, dynamic> toJson() {
  return {
    "user_id": id.toString(),
   
  };
}
}