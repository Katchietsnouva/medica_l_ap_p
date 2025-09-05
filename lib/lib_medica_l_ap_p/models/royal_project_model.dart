// models/Royal_project_model.dart
// Defines the data structures for the application.

class RoyalFormDataType {
  RoyalPersonalDetailsType personalDetails;
  List<RoyalDependant> dependants;
  String plan; // "Basic" or "Premium"
  RoyalPaymentDetails paymentDetails;

  RoyalFormDataType({
    required this.personalDetails,
    required this.dependants,
    required this.plan,
    required this.paymentDetails,
  });
}

class RoyalPersonalDetailsType {
  String fullName;
  String dob;
  String gender;
  String idNumber;
  String email;
  String address;
  String churchBranch;
  // String phone;
  String? profilePictureUrl;
  List<String> phoneNumbers;
  String? paymentPhoneNumber;

  RoyalPersonalDetailsType({
    required this.fullName,
    required this.dob,
    required this.gender,
    required this.idNumber,
    required this.email,
    required this.address,
    required this.churchBranch,
    // required this.phone,
    this.profilePictureUrl,
    required this.phoneNumbers,
    this.paymentPhoneNumber,
  });
}

class RoyalDependant {
  String id;
  String name;
  String dob;
  String relationship;
  String idNumber;

  RoyalDependant({
    required this.id,
    required this.name,
    required this.dob,
    required this.relationship,
    required this.idNumber,
  });
}

class RoyalPaymentDetails {
  String? cardName;
  String cardNumber;
  String expiryDate;
  String cvc;

  RoyalPaymentDetails({
    this.cardName,
    required this.cardNumber,
    required this.expiryDate,
    required this.cvc,
  });
}
