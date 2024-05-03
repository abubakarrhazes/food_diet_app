// ignore_for_file: public_member_api_docs, sort_constructors_first, non_constant_identifier_names
import 'dart:convert';

import 'package:flutter/material.dart';

class RegisterModel extends ChangeNotifier {
  final String firstName;
  final String lastName;
  final String DOB;
  final String email;
  final String phoneNumber;
  final String region;
  final String password;
  final bool? isDiabetic;
  final bool? wantsToLoseWeight;
  RegisterModel(
      {required this.firstName,
      required this.lastName,
      required this.DOB,
      required this.email,
      required this.phoneNumber,
      required this.password,
      required this.isDiabetic,
      required this.wantsToLoseWeight,
      required this.region});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'firstName': firstName,
      'lastName': lastName,
      'DOB': DOB,
      'email': email,
      'phoneNumber': phoneNumber,
      'region': region,
      'password': password,
      'isDiabetic': isDiabetic,
      'wantsToLoseWeight': wantsToLoseWeight,
    };
  }

  factory RegisterModel.fromMap(Map<String, dynamic> map) {
    return RegisterModel(
      firstName: map['firstName'] as String,
      lastName: map['lastName'] as String,
      DOB: map['DOB'] as String,
      email: map['email'] as String,
      phoneNumber: map['phoneNumber'] as String,
      region: map['state'] as String,
      password: map['password'] as String,
      isDiabetic: map['isDiabetic'] as bool,
      wantsToLoseWeight: map['wantsToLoseWeight'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory RegisterModel.fromJson(String source) =>
      RegisterModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
