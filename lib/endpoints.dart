class Endpoints {
  static const String domain = 'http://10.0.2.2:5000/api/';
  static const String hospital = domain + 'Hospitals';
  static const String users = domain + 'Users';
  static const String baby = domain + 'Babies';
  static const String incubator = domain + 'Incubators';
  static const String employees = domain + 'Employees';
  static const String login = users + '/login';
  static const String register = users + '/register';
  static const String doctorId = users + '/doctorId';
  static const String nurseId = users + '/nurseId';
  static const String adminId = users + '/adminId';
  static const String motherId = users + '/motherId';
  static const String pictures = domain + 'Pictures';
}
