
class Contact {
  int contactId;
  int storeId;
  String? phoneNumber;
  String branch;


  Contact({
    required this.contactId,
    required this.storeId,
    this.phoneNumber,
    required this.branch,
 
  });

  factory Contact.fromJson(Map<String, dynamic> json) {
    return Contact(
      contactId: json['contact_id']as int? ??0,
      storeId: json['store_id']as int? ??0,
      phoneNumber: json['phone_number']as String? ?? '',
      branch: json['branch'],
 
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'contact_id': contactId,
      'store_id': storeId,
      'phone_number': phoneNumber,
      'branch': branch,
 
    };
  }
}
