// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:food_diet_app/models/food.dart';
import 'package:food_diet_app/providers/auth/food_services.dart';

import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:food_diet_app/providers/persistance_data/user_adapter.dart';
import 'package:food_diet_app/screens/pages/food_detail_page.dart';
import 'package:food_diet_app/screens/pages/product_detail_page.dart';
import 'package:food_diet_app/widgets/avatar.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future<Map<String, List<Food>>>? mealFuture;
  final FoodServices foodServices = FoodServices();

  @override
  void initState() {
    super.initState();
    fetchMeals();
  }

  void fetchMeals() {
    setState(() {
      mealFuture = foodServices.fetchMeals();
    });
  }

  @override
  Widget build(BuildContext context) {
    final userAdapter = Provider.of<UserAdapter>(context);
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.only(
                  top: 50,
                  left: 20,
                ),
                child: Row(
                  children: <Widget>[
                    Avatar.medium(
                      img: NetworkImage('${userAdapter.user?.email}'),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Text(
                        'Hi ${userAdapter.user!.firstName}',
                        style: const TextStyle(
                            fontSize: 10,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Expanded(child: Container()),
                  ],
                ),
              ),
              Container(
                  margin: const EdgeInsets.only(left: 20),
                  child: Text(
                    'HealthHub ',
                    style: TextStyle(
                        fontSize: 35,
                        fontWeight: FontWeight.bold,
                        foreground: Paint()
                          ..shader = const LinearGradient(colors: <Color>[
                            Color.fromARGB(255, 41, 167, 226),
                            Colors.green,
                            Colors.green,
                          ]).createShader(
                              const Rect.fromLTWH(0.0, 0.0, 200.0, 100.0))),
                  )),
              FutureBuilder<Map<String, List<Food>>>(
                future: mealFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Center(child: Text('No meals available.'));
                  } else {
                    return buildMealsView(snapshot.data!);
                  }
                },
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: fetchMeals,
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
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(meal.name,
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
