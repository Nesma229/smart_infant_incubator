import '../const/roles.dart';

class UserDataModel {
  final String id, adminId, name, userName, email;

  final UserRoles role;
  final String? userImageID,
      ssn,
      phoneNumber,
      hospitalName,
      hospitalPhone,
      university,
      degreeOfPromotion,
      specialization;
  final DateTime? birthDay;
  final List? babayCodes, babyId, incubatorsId, doctorId, nurseId;
  UserDataModel({
    required this.id,
    required this.adminId,
    required this.name,
    required this.userName,
    required this.email,
    required this.phoneNumber,
    required this.ssn,
    required this.userImageID,
    required this.hospitalName,
    required this.hospitalPhone,
    required this.role,
    required this.birthDay,
    required this.university,
    required this.degreeOfPromotion,
    required this.specialization,
    required this.babayCodes,
    required this.incubatorsId,
    required this.doctorId,
    required this.nurseId,
    required this.babyId,
  });
  factory UserDataModel.fromJson(Map<String, dynamic> map) {
    return UserDataModel(
        id: map['id'],
        adminId: map['adminId'],
        name: map['name'],
        userName: map['userName'],
        email: map['email'],
        phoneNumber: map['phoneNumber'],
        ssn: map['ssn'],
        userImageID: map['userImgeId'],
        hospitalName: map['hospitalName'],
        hospitalPhone: map['hospitalPhone'],
        role: UserRoles.values[map['type'] as int],
        birthDay: DateTime.tryParse(map['birthDate'] ?? ''),
        university: map['university'],
        degreeOfPromotion: map['degreeOfPromotion'],
        specialization: map['specialization'],
        babayCodes: map['babyCodes'],
        incubatorsId: map['incubatorsId'],
        doctorId: map['doctorsId'],
        nurseId: map['nursesId'],
        babyId: map['babiesId']);
  }
}
