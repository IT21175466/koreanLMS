class Student {
  final String userID;
  final String firstName;
  final String lastName;
  final String email;
  final String nic;
  final String phoneNum;
  final String dateOfBirth;
  final String date;
  final String deviceID;
  final List<String> batches;
  final List<String> classes;
  final List<String> terms;

  Student({
    required this.userID,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.nic,
    required this.phoneNum,
    required this.date,
    required this.dateOfBirth,
    required this.deviceID,
    required this.batches,
    required this.classes,
    required this.terms,
  });

  factory Student.fromJson(Map<String, dynamic> json) {
    return Student(
      userID: json['UserID'].toString(),
      firstName: json['FirstName'].toString(),
      lastName: json['LastName'].toString(),
      email: json['Email'].toString(),
      nic: json['NIC'].toString(),
      phoneNum: json['PhoneNumber'].toString(),
      dateOfBirth: json['DateOfBirth'].toString(),
      date: json['Registed_Date'],
      deviceID: json['Device_ID'].toString(),
      batches: json['Batches'],
      classes: json['Classes'],
      terms: json['Terms'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'UserID': userID,
      'FirstName': firstName,
      'LastName': lastName,
      'Email': email,
      'NIC': nic,
      'PhoneNumber': phoneNum,
      'DateOfBirth': dateOfBirth,
      'Device_ID': deviceID,
      'Registed_Date': DateTime.now().toString(),
      'Batches': batches,
      'Classes': classes,
      'Terms': terms,
    };
  }
}
