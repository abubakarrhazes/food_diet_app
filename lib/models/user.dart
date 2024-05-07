import 'dart:convert';

import 'package:flutter/material.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class User extends ChangeNotifier {
  final String id;
  final String firstName;
  final String lastName;
  final String email;
  final String dateOfBirth;
  final String phoneNumber;
  final String region;
  final bool isDiabetic;
  final bool isTryingToLoseWeight;
  final int weight;
  final String role;
  final int height;
  final String accessToken;
  User({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.dateOfBirth,
    required this.phoneNumber,
    required this.region,
    required this.isDiabetic,
    required this.isTryingToLoseWeight,
    required this.weight,
    required this.role,
    required this.height,
    required this.accessToken,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      '_id': id,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'dateOfBirth': dateOfBirth,
      'phoneNumber': phoneNumber,
      'region': region,
      'isDiabetic': isDiabetic,
      'isTryingToLoseWeight': isTryingToLoseWeight,
      'weight': weight,
      'role': role,
      'height': height,
      'accessToken': accessToken,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    if (map['_id'] == null) {
      throw Exception("User ID is null");
    }
    return User(
      id: map['_id'] as String,
      firstName: map['firstName'] as String? ?? 'N/A',
      lastName: map['lastName'] as String? ?? 'N/A',
      email: map['email'] as String? ?? 'N/A',
      dateOfBirth: map['dateOfBirth'] as String? ?? 'N/A',
      phoneNumber: map['phoneNumber'].toString(),
      region: map['region'] as String? ?? 'N/A',
      isDiabetic: map['isDiabetic'] as bool? ?? false,
      isTryingToLoseWeight: map['isTryingToLoseWeight'] as bool? ?? false,
      weight: map['weight'] as int? ?? 0,
      role: map['role'] as String? ?? 'N/A',
      height: map['height'] as int? ?? 0,
      accessToken: map['accessToken'] as String? ?? 'N/A',
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) =>
      User.fromMap(json.decode(source) as Map<String, dynamic>);
}
