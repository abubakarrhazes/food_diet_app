import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:food_diet_app/config/config.dart';
import 'package:food_diet_app/models/user.dart';
import 'package:food_diet_app/providers/persistance_data/preferences.dart';
import 'package:food_diet_app/screens/login_screen/models/login_model.dart';
import 'package:food_diet_app/screens/onboard_screen/onboard.dart';
import 'package:food_diet_app/screens/register_screen/models/register_model.dart';
import 'package:food_diet_app/utils/utils.dart';
import 'package:http/http.dart' as http;

class AuthServices {
  bool _isLoading = false;
  String _resMessage = '';
  final Utils utils = Utils();
  final requestBaseUrl = Config.AuthBaseUrl;

  //Getters
  bool get isLoading => _isLoading;
  String get resMessage => _resMessage;
  Future<void> registerUser(
      RegisterModel registerModel, BuildContext context) async {
    _isLoading = true;

    String url = '$requestBaseUrl/auth/signup';

    final requestHeaders = {
      'Accept': 'application/vnd.api+json',
      'Content-Type': 'application/json',
    };

    final body = registerModel.toJson();

    try {
      http.Response response =
          await http.post(Uri.parse(url), headers: requestHeaders, body: body);

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        _isLoading = false;

        print("Register Successfully: $responseData");
        _resMessage = responseData['message'];
        utils.successShowToast(context, _resMessage);
        Navigator.pushNamedAndRemoveUntil(
            context, appRoutes.login, (route) => false);
      } else {
        final res = json.decode(response.body);

        _resMessage = res['message'];

        utils.showToast(context, _resMessage);

        print(res);
        _isLoading = false;
      }
    } on SocketException catch (_) {
      _isLoading = false;
      _resMessage = "Internet connection is not available`";
      utils.showToast(context, _resMessage);
    } catch (e) {
      print(":::: ${e.toString()}");
    }
    return null;
  }

  void forgotPassword(forgotPasswordModel, BuildContext context) {}

  Future<User?> loginUser(LoginModel loginModel, BuildContext context) async {
    _isLoading = true;

    String url = '$requestBaseUrl/auth/login';

    final requestHeaders = {
      'Accept': 'application/vnd.api+json',
      'Content-Type': 'application/json',
    };

    final body = loginModel.toJson();

    try {
      http.Response response =
          await http.post(Uri.parse(url), headers: requestHeaders, body: body);

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        _isLoading = false;

        print("Login Succes : $responseData");

        _resMessage = responseData['message'];

        utils.successShowToast(context, _resMessage);

        print(_resMessage);
        User user =
            User.fromMap(responseData['data']['user'] as Map<String, dynamic>);

        final preferences = await Preferences.getInstance();
        preferences.setAccessToken(responseData['data']['accessToken']);
        // preferences.setUserId(user.data!.user!.id!);

        return user;
      } else {
        final res = json.decode(response.body);

        _resMessage = res['message'];

        utils.showToast(context, _resMessage);

        print(res);
        _isLoading = false;
      }
    } on SocketException catch (_) {
      _isLoading = false;
      _resMessage = "Internet connection is not available`";
      utils.showToast(context, _resMessage);
    } catch (e) {
      print(":::: ${e.toString()}");
    }
    return null;
  }
}
