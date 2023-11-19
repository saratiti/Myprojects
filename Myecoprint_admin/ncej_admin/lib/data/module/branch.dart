

class Branche {
 final int branchId;
 final int storeId;
 final String email;
 final String password;
 final String location;


  Branche({
    required this.branchId,
    required this.storeId,
    required this.email,
    required this.password,
    required this.location,
 
  });

  factory Branche.fromJson(Map<String, dynamic> json) {
    return Branche(
      branchId: json['branch_id']as int? ??0,
      storeId: json['store_id']as int? ??0,
      email: json['email']as String? ?? '',
      password: json['password']as String? ?? '',
      location: json['location']as String? ?? '',
 
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'branch_id': branchId.toString(),
      'store_id': storeId.toString(),
      'email': email,
      'password': password,
      'location': location,

    };
  }
}

