// ignore_for_file: prefer_const_constructors, unused_field, curly_braces_in_flow_control_structures, avoid_unnecessary_containers, prefer_const_literals_to_create_immutables, sort_child_properties_last, non_constant_identifier_names

import 'dart:convert';
import 'dart:ffi';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:food_diet_app/providers/auth/auth_services.dart';
import 'package:food_diet_app/screens/onboard_screen/onboard.dart';
import 'package:food_diet_app/screens/register_screen/models/register_model.dart';
import 'package:food_diet_app/utils/color_constants.dart';
import 'package:food_diet_app/widgets/avatar.dart';
import 'package:food_diet_app/widgets/button_widget.dart';
import 'package:food_diet_app/widgets/my_input_field.dart';

const MaterialColor black = MaterialColor(
  0xFF000000,
  <int, Color>{
    50: Color(0xFFEEEEEE),
    100: Color(0xFFBBBBBB),
    200: Color(0xFF999999),
    300: Color(0xFF555555),
    400: Color(0xFF333333),
    500: Color(0xFF000000),
    600: Color(0xFF000000),
    700: Color(0xFF000000),
    800: Color(0xFF000000),
    900: Color(0xFF000000),
  },
);

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  bool _isDiabetic = false;
  bool _wantsToLoseWeight = false;

  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailNameController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();

  final TextEditingController _dateOfBithController = TextEditingController();

  final TextEditingController _regionController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();
  String region = 'North';
  DateTime selectedDate = DateTime.now();
  List<String> regionSelection = [
    'North',
    'West',
    'South',
    'East',
  ];

  String? imagePath;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(1900),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
      _dateOfBithController.text =
          selectedDate.toLocal().toString().split(' ')[0];
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  /*

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(1900),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        _controllers['dateOfBirth']!.text = DateFormat('yyyy-MM-dd').format(_selectedDate);
      });
    }
  }
  */

  void _registerUser() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);
      try {
        AuthServices().registerUser(
          RegisterModel(
            firstName: _firstNameController.text,
            lastName: _lastNameController.text,
            DOB: _dateOfBithController.text,
            email: _emailNameController.text,
            phoneNumber: _phoneNumberController.text,
            region: _regionController.text,
            password: _passwordController.text,
            isDiabetic: _isDiabetic,
            wantsToLoseWeight: _wantsToLoseWeight,
          ),
          context,
        );
      } catch (e) {
        print("Failed to register: $e");
      } finally {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F3F3),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 12),
          children: [
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Create an Account',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w800,
                          color: KprimaryColor,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          Expanded(
                            child: MyInputField(
                              hintText: 'Firsname',
                              controller: _firstNameController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'FirstName Required';
                                }
                                return null;
                              },
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: MyInputField(
                              hintText: 'Lastname',
                              controller: _lastNameController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'LastName Required';
                                }
                                return null;
                              },
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      MyInputField(
                          hintText: 'Email',
                          keyboardType: TextInputType.emailAddress,
                          controller: _emailNameController,
                          validator: (value) {
                            RegExp emailRegExp = RegExp(
                                r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$");

                            if (value == null || value.isEmpty) {
                              return 'Email can\'t be empty';
                            } else if (!emailRegExp.hasMatch(value)) {
                              return 'Enter a correct email';
                            }
                            return null;
                          }),
                      const SizedBox(height: 15),
                      MyInputField(
                        hintText: 'Phone',
                        keyboardType: TextInputType.phone,
                        controller: _phoneNumberController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Phone Required';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 15),
                      MyInputField(
                          hintText: 'Date Of Birth',
                          keyboardType: TextInputType.datetime,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Date Of Birth Required';
                            }
                            return null;
                          },
                          onTap: () {
                            _selectDate(context).toString();
                          },
                          controller: _dateOfBithController),
                      const SizedBox(height: 15),
                      Text(
                        'Choose Region',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 10,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      SizedBox(
                        child: Column(
                          children: [
                            DropdownButton(
                              value: region,
                              items: regionSelection.map((String item) {
                                return DropdownMenuItem(
                                    value: item, child: Text(item));
                              }).toList(),
                              onChanged: (String? newval) {
                                setState(() {
                                  region = newval!;
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 15),
                      MyInputField(
                        hintText: 'Enter Your Height',
                        keyboardType: TextInputType.phone,
                        controller: _phoneNumberController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return ' Required';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 15),
                      MyInputField(
                        hintText: 'Enter Your Weight',
                        keyboardType: TextInputType.phone,
                        controller: _phoneNumberController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return ' Required';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 15),
                      MyInputField(
                        hintText: 'Password',
                        isPassword: true,
                        keyboardType: TextInputType.visiblePassword,
                        controller: _passwordController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Password Required';
                          }
                          return null;
                        },
                      ),
                      _buildCheckBox('Are You Diabetic ?', _isDiabetic,
                          (bool newValue) {
                        setState(() {
                          _isDiabetic = newValue;
                        });
                      }),
                      _buildCheckBox(
                          'Want to Lose Weight ?', _wantsToLoseWeight,
                          (bool newValue) {
                        setState(() {
                          _wantsToLoseWeight = newValue;
                        });
                      }),
                      const SizedBox(height: 20),
                      ButtonWidget(
                        text: _isLoading
                            ? 'Creating Please Wait...'
                            : 'Create Account',
                        onPress: _registerUser,
                      ),
                      _buildLoginPrompt(),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCheckBox(String title, bool value, Function(bool) onChanged) {
    return CheckboxListTile(
      title: Text(title),
      value: value,
      onChanged: (newValue) {
        onChanged(newValue!);
      },
      controlAffinity: ListTileControlAffinity.leading,
    );
  }

  Widget _buildLoginPrompt() {
    return Padding(
      padding: const EdgeInsets.only(top: 24, bottom: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Already have an account? '),
          GestureDetector(
            onTap: () => Navigator.pushNamed(context, appRoutes.login),
            child: Text(
              'Login Here',
              style: TextStyle(
                color: KprimaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
