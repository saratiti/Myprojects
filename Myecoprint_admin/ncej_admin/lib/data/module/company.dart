
class Company {
  final int companyId;
  final String companyName;
  final String companyType;
  final String password;
  final String image;
  final String contact;

  Company({
    required this.companyId,
    required this.companyName,
    required this.companyType,
    required this.password,
    required this.image,
    required this.contact,
  });

  factory Company.fromJson(Map<String, dynamic> json) {
    return Company(
      companyId: json['company_id'],
      companyName: json['company_name'],
      companyType: json['company_type'],
      password: json['password'],
      image: json['image'],
      contact: json['contact'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'company_id': companyId,
      'company_name': companyName,
      'company_type': companyType,
      'password': password,
      'image': image,
      'contact': contact,
    };
  }
}
