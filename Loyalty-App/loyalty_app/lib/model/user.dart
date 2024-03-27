class User {
 int ?id;
  String username;
  String email;
  String fullName;
  String?password;
  late String image;
  String phone;

  User({
    this.id,
    required this.username,
    required this.email,
    required this.image,
    required this.fullName,
    required this.phone,
    this.password,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      
      id: json['user_id'] as int? ??0,
      username: json['username']?? '',
       email: json['email']?? '', 
       image: json['profile_picture']?? '',
       fullName: json['full_name']?? '',
       password: json['password']?? '',
        phone:json["phone"]?? '',);
        
  }

Map<String, dynamic> toJson() {
  return {
   
    "username": username,
    "email": email,
    "password": password ?? '',
    "full_name": fullName,
    "phone": phone,
  
  };
}

}