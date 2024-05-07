// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:food_diet_app/config/config.dart';
import 'package:food_diet_app/models/food.dart';
import 'package:food_diet_app/screens/pages/product_detail_page.dart';
import 'package:http/http.dart' as http;
import 'package:food_diet_app/providers/persistance_data/preferences.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

String region = 'north';

List<String> regionSelection = [
  'north',
  'west',
  'south',
  'east',
];

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

  String url = '$requestBaseUrl/food/query?region=$region';
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

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: SingleChildScrollView(
            child: Column(
              children: [
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
                            print(" Region Selected $region");
                          });
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      FutureBuilder<Map<String, List<Food>>>(
                        future: fetchMeals(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Center(child: CircularProgressIndicator());
                          } else if (snapshot.hasError) {
                            return Center(
                                child: Text('Error: ${snapshot.error}'));
                          } else if (!snapshot.hasData ||
                              snapshot.data!.isEmpty) {
                            return Center(child: Text('No meals available.'));
                          } else {
                            return buildMealsView(snapshot.data!);
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            fetchMeals();
          },
          tooltip: 'Refresh Meals',
          child: Icon(Icons.refresh),
        ),
      ),
    );
  }

  Widget buildMealsView(Map<String, List<Food>> mealsByType) {
    List<Widget> mealWidgets = ['breakfast', 'lunch', 'dinner']
        .map(
            (type) => mealsByType[type] != null && mealsByType[type]!.isNotEmpty
                ? Column(
                    children: [
                      _buildMealTypeLabel(type),
                      _buildHorizontalListView(mealsByType[type]!),
                    ],
                  )
                : SizedBox.shrink())
        .toList();
    return SingleChildScrollView(
      child: Column(children: mealWidgets),
    );
  }

  Widget _buildMealTypeLabel(String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        label,
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildHorizontalListView(List<Food> meals) {
    return Container(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: meals.length,
        itemBuilder: (context, index) {
          Food meal = meals[index];
          return GestureDetector(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => ProductDetailPage(food: meal),
              ));
            },
            child: Container(
              width: 160,
              margin: EdgeInsets.symmetric(horizontal: 5.0),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.network(meal.image, width: 100, fit: BoxFit.cover),
                  SizedBox(height: 10),
                  Text(meal.name,
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  Text(meal.description, overflow: TextOverflow.ellipsis),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
