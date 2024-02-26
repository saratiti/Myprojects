
class Company {
  final int companyId;
  final String companyName;
  final String companyType;
  final String password;
  String? image;
  final String contact;

  Company({
    required this.companyId,
    required this.companyName,
    required this.companyType,
    required this.password,
    required this.image,
    required this.contact,
  });

  factory Company.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      throw ArgumentError('json must not be null');
    }
    return Company(
      companyId: json['company_id'] ?? 0,
      companyName: json['company_name'] ?? '',
      companyType: json['company_type'] ?? '',
      password: json['password'] ?? '',
      image: json['image'] ?? '',
      contact: json['contact'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'company_id': companyId.toString(),
      'company_name': companyName.toString(),
      'company_type': companyType.toString(),
      'password': password.toString(),
      'image': image ?? '',
      'contact': contact.toString(),
    };
  }
}
