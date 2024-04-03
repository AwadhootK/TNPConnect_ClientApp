import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';

enum Gender { Male, Female, Other }

class EnrollmentForm extends StatefulWidget {
  const EnrollmentForm({super.key});

  @override
  _EnrollmentFormState createState() => _EnrollmentFormState();
}

class _EnrollmentFormState extends State<EnrollmentForm> {
  final _formKey = GlobalKey<FormState>();

  String? enrollmentNo;
  String? name;
  String? rollNo;
  String? email;
  String? prnNo;
  String? branch;
  double? cgpa;
  int? year;
  int countOfBacklogs = 0;
  bool isInterned = false;
  Gender? gender;
  String companyName = "NA";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Enrollment Form',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Enrollment No.',
                    labelStyle: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w100,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.black, width: 0.5),
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter Enrollment No';
                    }

                    return null;
                  },
                  onSaved: (value) => enrollmentNo = value,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Name',
                    labelStyle: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w100,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.black, width: 0.5),
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter Name';
                    }
                    return null;
                  },
                  onSaved: (value) => name = value,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Roll No',
                    labelStyle: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w100,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.black, width: 0.5),
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter Roll No';
                    }
                    return null;
                  },
                  onSaved: (value) => rollNo = value,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Email',
                    labelStyle: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w100,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.black, width: 0.5),
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter Email';
                    }
                    return null;
                  },
                  onSaved: (value) => email = value,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: 'PRN No',
                    labelStyle: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w100,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.black, width: 0.5),
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter PRN No';
                    }
                    return null;
                  },
                  onSaved: (value) => prnNo = value,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Branch',
                    labelStyle: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w100,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.black, width: 0.5),
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter Branch';
                    }
                    return null;
                  },
                  onSaved: (value) => branch = value,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: 'CGPA',
                    labelStyle: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w100,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.black, width: 0.5),
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter CGPA';
                    }
                    return null;
                  },
                  onSaved: (value) => cgpa = double.tryParse(value!),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Year',
                    labelStyle: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w100,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.black, width: 0.5),
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter Year';
                    }
                    return null;
                  },
                  onSaved: (value) => year = int.tryParse(value!),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Count of Backlogs',
                    labelStyle: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w100,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.black, width: 0.5),
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                  ),
                  onSaved: (value) => countOfBacklogs = int.tryParse(value!) ?? 0,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black, width: 0.5),
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: CheckboxListTile(
                    title: const Text(
                      'Is Interned',
                    ),
                    value: isInterned,
                    onChanged: (value) {
                      setState(() {
                        isInterned = value!;
                      });
                    },
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Enter Company Name if Received Internship Already',
                    labelStyle: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w100,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.black, width: 0.5),
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                  ),
                  onSaved: (value) => companyName = value ?? "NA",
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: DropdownButtonFormField<Gender>(
                  decoration: InputDecoration(
                    labelText: 'Gender',
                    labelStyle: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w100,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.black, width: 0.5),
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                  ),
                  items: Gender.values.map((Gender value) {
                    return DropdownMenuItem<Gender>(
                      value: value,
                      child: Text(value.toString().split('.').last),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      gender = value!;
                    });
                  },
                  onSaved: (value) => gender = value,
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  print('Validating form...');
                  //! add validation
                  if (true) {
                    _formKey.currentState!.save();

                    print('Form validated and saved.');
                    print('Enrollment No: $enrollmentNo');
                    print('Name: $name');
                    print('Roll No: $rollNo');
                    print('Email: $email');
                    print('PRN No: $prnNo');
                    print('Branch: $branch');
                    print('CGPA: $cgpa');
                    print('Year: $year');
                    print('Count of Backlogs: $countOfBacklogs');
                    print('Is Interned: $isInterned');
                    print('Gender: ${gender?.toString().split('.').last}');
                    print('Company Name: $companyName');

                    Map<String, dynamic> formData = {
                      'enrollmentNo': enrollmentNo,
                      'name': name,
                      'rollNo': rollNo,
                      'email': email,
                      'prnNo': prnNo,
                      'branch': branch,
                      'cgpa': cgpa,
                      'year': year,
                      'countOfBacklogs': countOfBacklogs,
                      'isInterned': isInterned,
                      'gender': gender?.toString().split('.').last,
                      'companyName': companyName,
                    };

                    String jsonData = json.encode(formData);
                    log(jsonData);
                  } else {
                    log("invalid!");
                  }
                },
                child: const Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
