class Student {
  String enrollmentNo;
  String name;
  String rollNo;
  String email;
  String prnNo;
  String branch;
  String cgpa;
  String year;
  String countOfBacklogs;
  bool isInterned;
  String gender;
  String companyName;

  Student({
    required this.enrollmentNo,
    required this.name,
    required this.rollNo,
    required this.email,
    required this.prnNo,
    required this.branch,
    required this.cgpa,
    required this.year,
    this.countOfBacklogs = '0',
    this.isInterned = false,
    required this.gender,
    this.companyName = "NA",
  });

  Map<String, dynamic> toJson() {
    return {
      'enrollmentNo': enrollmentNo,
      'name': name,
      'rollNo': rollNo,
      'email': email,
      'prnNo': prnNo,
      'branch': branch.toString().split('.').last,
      'cgpa': cgpa,
      'year': year.toString().split('.').last,
      'countOfBacklogs': countOfBacklogs,
      'isInterned': isInterned,
      'gender': gender.toString().split('.').last,
      'companyName': companyName,
    };
  }

  factory Student.fromJson(Map<String, dynamic> json) {
    return Student(
      enrollmentNo: json['enrollmentNo'],
      name: json['name'],
      rollNo: json['rollNo'],
      email: json['email'],
      prnNo: json['prnNo'],
      branch: json['branch'],
      cgpa: json['cgpa'].toString(),
      year: json['year'],
      countOfBacklogs: json['countOfBacklogs'].toString(),
      isInterned: json['isInterned'],
      gender: json['gender'],
      companyName: json['companyName'],
    );
  }
}
