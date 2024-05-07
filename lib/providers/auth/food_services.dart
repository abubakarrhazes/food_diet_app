import 'dart:convert';
import 'package:food_diet_app/config/config.dart';
import 'package:food_diet_app/providers/persistance_data/preferences.dart';
import 'package:http/http.dart' as http;

import 'package:food_diet_app/models/food.dart';

class FoodServices {
  final requestBaseUrl = Config.AuthBaseUrl;
  



  Future<Map<String, List<Food>>> fetchMeals() async {
    final preferences = await Preferences.getInstance();
    String? token = await preferences.getAccessToken();
    String? userId = await preferences.getUserId();

    print('JWT Token $token');
    print('User Id $userId');

    final requestHeaders = {
      'Accept': 'application/vnd.api+json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token '
    };

    String url = '$requestBaseUrl/food';
    var response = await http.get(Uri.parse(url), headers: requestHeaders);
    if (response.statusCode == 200) {
      var data = json.decode(response.body)['data'] as List;
      Map<String, List<Food>> mealsByType = {
        'breakfast': [],
        'lunch': [],
        'dinner': [],
      };

      for (var item in data) {
        Food food = Food.fromJson(item);
        mealsByType[food.mealType]?.add(food);
      }

      return mealsByType;
    } else {
      throw Exception('Failed to load meals');
    }
  }
}
