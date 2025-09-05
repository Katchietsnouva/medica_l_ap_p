// data/beno_mock_user_database.dart
import 'package:uuid/uuid.dart';
import '../models/beno_project_model.dart';

class BenoMockUserDataType {
  String password;
  bool hasPaid;
  BenoFormDataType formData;

  BenoMockUserDataType({
    required this.password,
    required this.hasPaid,
    required this.formData,
  });
}

final Map<String, BenoMockUserDataType> benoMockUserDatabase = {
  "100100": BenoMockUserDataType(
    password: "100100",
    hasPaid: true,
    formData: BenoFormDataType(
      plan: "Premium",
      sectionA: SectionA(
        employerName: "Acme Ltd",
        occupation: "Software Engineer",
        memberFullName: "Jane Doe",
        memberNumber: "MBR-00123",
        dateOfBirth: "1995-02-12",
        dateOfAppointment: "2020-01-01",
        dateOfAdmission: "2024-02-01",
        dateOfCommencement: "2020-03-01",
        kraPin: "A123456789Z",
        idNo: "100100",
        phone: "+254711111111",
        email: "andrew@gmail.com",
        voluntaryAmount: 5000,
        voluntaryPercent: 10.0,
      ),
      sectionB: SectionB(
        accountName: "Jane Doe",
        bankName: "KCB",
        bankBranch: "Upper Hill",
        accountNumber: "011234567890",
        townCity: "Nairobi",
        bankCode: "01",
        branchCode: "123",
        swiftCode: "KCBLKENX",
        sortCodeIban: "KEN-123-456",
      ),
      sectionC: SectionC(
        beneficiaries: [
          Beneficiary(
            id: const Uuid().v4(),
            name: "John Doe",
            email: "john@example.com",
            mobile: "+254722000222",
            dateOfBirth: "2015-06-01",
            idNo: null,
            relationshipToMember: "Son",
            sharePercent: 60,
          ),
          Beneficiary(
            id: const Uuid().v4(),
            name: "Alice Doe",
            email: null,
            mobile: "+254700111222",
            dateOfBirth: "1990-09-09",
            idNo: "29123456",
            relationshipToMember: "Sister",
            sharePercent: 40,
          ),
        ],
        guardians: [
          Guardian(
            id: const Uuid().v4(),
            name: "Mary Doe",
            email: "mary@example.com",
            mobile: "+254733000333",
            idNo: "28900123",
            relationshipToMember: "Mother",
          ),
          Guardian(
            id: const Uuid().v4(),
            name: "Peter Doe",
            email: null,
            mobile: "+254710000000",
            idNo: null,
            relationshipToMember: "Uncle",
          ),
        ],
      ),
    ),
  ),
  "200200": BenoMockUserDataType(
    password: "200200",
    hasPaid: false,
    formData: BenoFormDataType(
      plan: "Basic",
      sectionA: SectionA(
        employerName: "Springfield Holdings",
        occupation: "Accountant",
        memberFullName: "Mary Jane",
        memberNumber: "200200",
        dateOfBirth: "1992-05-20",
        dateOfAppointment: "2019-06-01",
        dateOfAdmission: "2019-07-01",
        dateOfCommencement: "2019-08-01",
        kraPin: "B987654321C",
        idNo: "200200",
        phone: "+254722222222",
        email: "mary@gmail.com",
      ),
      sectionB: SectionB(
        accountName: "Mary Jane",
        bankName: "KCB",
        bankBranch: "Savannah",
        accountNumber: "0987654321",
        townCity: "Nairobi",
        bankCode: "011",
        branchCode: "456",
        swiftCode: "KCBLKENX",
        sortCodeIban: "654321",
      ),
      sectionC: SectionC(),
    ),
  ),
  "300300": BenoMockUserDataType(
    password: "300300",
    hasPaid: false,
    formData: BenoFormDataType(
      plan: "Basic",
      sectionA: SectionA(
        employerName: "Ndogo Inc",
        occupation: "Teacher",
        memberFullName: "John Ndege",
        memberNumber: "300300",
        dateOfBirth: "1988-03-12",
        dateOfAppointment: "2018-01-01",
        dateOfAdmission: "2018-02-01",
        dateOfCommencement: "2018-03-01",
        kraPin: "C123987654Z",
        idNo: "300300",
        phone: "+254722222222",
        email: "john@gmail.com",
      ),
      sectionB: SectionB(
        accountName: "John Ndege",
        bankName: "Cooperative Bank",
        bankBranch: "Kisumu Ndogo",
        accountNumber: "4561237890",
        townCity: "Kisumu",
        bankCode: "012",
        branchCode: "789",
        swiftCode: "COPBKENA",
        sortCodeIban: "321654",
      ),
      sectionC: SectionC(),
    ),
  ),
};

// // data/beno_mock_user_database.dart
// // Simulates a backend database with mock user data.
// import '../models/beno_project_model.dart';

// class BenoMockUserDataType {
//   String password;
//   bool hasPaid;
//   BenoFormDataType formData;

//   BenoMockUserDataType({
//     required this.password,
//     required this.hasPaid,
//     required this.formData,
//   });
// }

// final Map<String, BenoMockUserDataType> benoMockUserDatabase = {
//   "100100": BenoMockUserDataType(
//     password: "100100",
//     hasPaid: true,
//     formData: BenoFormDataType(
//       personalDetails: BenoPersonalDetailsType(
//           fullName: "Andrew Moses",
//           dob: "1990-01-15",
//           gender: "Male",
//           idNumber: "100100",
//           email: "andrew@gmail.com",
//           // phone: "+254711111111",
//           phoneNumbers: ["+254711111111", "+2547222222222"],
//           paymentPhoneNumber: "+254711111111",
//           address: "Greens Field",
//           churchBranch: "Deliverance CHurch Donholm"),
//       plan: "Premium",
//       dependants: [
//         BenoDependant(
//             id: "_abc123",
//             name: "Jane Doe",
//             relationship: "Spouse",
//             dob: "1992-05-20",
//             idNumber: "22224545")
//       ],
//       paymentDetails:
//           BenoPaymentDetails(cardNumber: "", expiryDate: "", cvc: ""),
//     ),
//   ),
//   "200200": BenoMockUserDataType(
//     password: "200200",
//     hasPaid: false,
//     formData: BenoFormDataType(
//       personalDetails: BenoPersonalDetailsType(
//           fullName: "Mary Jane",
//           dob: "1992-05-20",
//           gender: "Female",
//           idNumber: "200200",
//           email: "mary@gmail.com",
//           // phone: "+254722222222",
//           phoneNumbers: ["+254722222222"],
//           paymentPhoneNumber: "+254722222222",
//           address: "Spring Field",
//           churchBranch: "Deliverance CHurch Donholm"),
//       plan: "Basic",
//       dependants: [],
//       paymentDetails:
//           BenoPaymentDetails(cardNumber: "", expiryDate: "", cvc: ""),
//     ),
//   ),
//   "300300": BenoMockUserDataType(
//     password: "300300",
//     hasPaid: false,
//     formData: BenoFormDataType(
//       personalDetails: BenoPersonalDetailsType(
//           fullName: "John Ndege",
//           dob: "1992-05-20",
//           gender: "Female",
//           idNumber: "300300",
//           email: "mary@gmail.com",
//           // phone: "+254722222222",
//           phoneNumbers: ["+254722222222"],
//           paymentPhoneNumber: "+254722222222",
//           address: "Kisumu Ndogo",
//           churchBranch: "Deliverance CHurch Donholm"),
//       plan: "Basic",
//       dependants: [],
//       paymentDetails:
//           BenoPaymentDetails(cardNumber: "", expiryDate: "", cvc: ""),
//     ),
//   ),
// };
// // New Dohnolm
// // Savannah
