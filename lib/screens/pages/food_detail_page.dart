import 'package:flutter/material.dart';
import 'package:food_diet_app/models/food.dart';
// Assuming you have a Food class defined in food.dart

class FoodDetailPage extends StatelessWidget {
  final Food food;

  const FoodDetailPage({Key? key, required this.food}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(food.name),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.network(food.image, height: 250, fit: BoxFit.cover),
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(food.name, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                  SizedBox(height: 10),
                  Text(food.description),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
