import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:tnpconnect/features/authentication/bloc/auth_bloc.dart';

enum Gender { Male, Female, Other }

enum Year { FE, SE, TE, BE }

enum Branch { CSE, IT, ENTC }

class EnrollmentForm extends StatefulWidget {
  final AuthBloc authBloc;
  const EnrollmentForm({required this.authBloc, super.key});

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
  Branch? branch;
  double? cgpa;
  Year? year;
  int countOfBacklogs = 0;
  bool isInterned = false;
  Gender? gender;
  String companyName = "NA";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TNP.Connect()'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
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
                  child: DropdownButtonFormField<Branch>(
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
                    items: Branch.values.map((Branch value) {
                      return DropdownMenuItem<Branch>(
                        value: value,
                        child: Text(value.toString().split('.').last),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        branch = value!;
                      });
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
                  child: DropdownButtonFormField<Year>(
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
                    items: Year.values.map((Year value) {
                      return DropdownMenuItem<Year>(
                        value: value,
                        child: Text(value.toString().split('.').last),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        year = value!;
                      });
                    },
                    onSaved: (value) => year = value,
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
                        'branch': branch?.toString().split('.').last,
                        'cgpa': cgpa,
                        'year': year?.toString().split('.').last,
                        'countOfBacklogs': countOfBacklogs,
                        'isInterned': isInterned,
                        'gender': gender?.toString().split('.').last,
                        'companyName': companyName,
                      };

                      String jsonData = json.encode(formData);
                      log(jsonData);

                      widget.authBloc.add(EnrollFormEvent(formData));
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
      ),
    );
  }
}
