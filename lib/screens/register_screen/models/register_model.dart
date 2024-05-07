// ignore_for_file: public_member_api_docs, sort_constructors_first, non_constant_identifier_names
import 'dart:convert';

import 'package:flutter/material.dart';

class RegisterModel extends ChangeNotifier {
  final String firstName;
  final String lastName;
  final String email;
  final String dateOfBirth;
  final String password;
  final String phoneNumber;
  final String region;
  final bool? isDiabetic;
  final bool? isTryingToLoseWeight;
  final String? weight;
  final String? height;

  RegisterModel({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.dateOfBirth,
    required this.password,
    required this.phoneNumber,
    required this.region,
    this.isDiabetic,
    this.isTryingToLoseWeight,
    this.weight,
    this.height,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'dateOfBirth': dateOfBirth,
      'password': password,
      'phoneNumber': phoneNumber,
      'region': region,
      'isDiabetic': isDiabetic,
      'isTryingToLoseWeight': isTryingToLoseWeight,
      'weight': weight,
      'height': height,
    };
  }

  factory RegisterModel.fromMap(Map<String, dynamic> map) {
    return RegisterModel(
      firstName: map['firstName'] as String,
      lastName: map['lastName'] as String,
      email: map['email'] as String,
      dateOfBirth: map['dateOfBirth'] as String,
      password: map['password'] as String,
      phoneNumber: map['phoneNumber'].toString(),
      region: map['region'] as String,
      isDiabetic: map['isDiabetic'] != null ? map['isDiabetic'] as bool : null,
      isTryingToLoseWeight: map['isTryingToLoseWeight'] != null
          ? map['isTryingToLoseWeight'] as bool
          : null,
      weight: map['weight'] != null ? map['weight'] as String : null,
      height: map['height'] != null ? map['height'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory RegisterModel.fromJson(String source) =>
      RegisterModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
