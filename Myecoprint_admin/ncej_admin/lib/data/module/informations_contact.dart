
class InformationContact {
  int infoContactId;
  int storeId;
  String? email;
  String landPhone;
  DateTime? createdAt;
  DateTime? updatedAt;
  DateTime? deletedAt;

  InformationContact({
    required this.infoContactId,
    required this.storeId,
    this.email,
    required this.landPhone,
  
  });

  factory InformationContact.fromJson(Map<String, dynamic> json) {
    return InformationContact(
      infoContactId: json['info_contact_id']as int? ??0,
      storeId: json['store_id']as int? ??0,
      email: json['email']as String? ?? '',
      landPhone: json['land_phone']as String? ?? '',

    );
  }

  Map<String, dynamic> toJson() {
    return {
      'info_contact_id': infoContactId,
      'store_id': storeId,
      'email': email,
      'land_phone': landPhone,
 
    };
  }
}
