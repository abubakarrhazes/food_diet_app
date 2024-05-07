class Food{
  final String id;
  final String name;
  final String description;
  final String region;
  final String image;
  final String mealType;
  final bool isDiabeticFriendly;
  final bool isWeightLossFriendly;
  final int calories;
  final int protein;
  final int carbohydrates;
  final int fats;
  final List<String> vitamins;
  final List<String> minerals;
  final int glycemicIndex;
  final int fiber;

  Food({
    required this.id,
    required this.name,
    required this.description,
    required this.region,
    required this.image,
    required this.mealType,
    required this.isDiabeticFriendly,
    required this.isWeightLossFriendly,
    required this.calories,
    required this.protein,
    required this.carbohydrates,
    required this.fats,
    required this.vitamins,
    required this.minerals,
    required this.glycemicIndex,
    required this.fiber,
  });

  factory Food.fromJson(Map<String, dynamic> json) {
    return Food(
      id: json['_id'],
      name: json['name'],
      description: json['description'],
      region: json['region'],
      image: json['image'],
      mealType: json['mealType'],
      isDiabeticFriendly: json['isDiabeticFriendly'],
      isWeightLossFriendly: json['isWeightLossFriendly'],
      calories: json['calories'],
      protein: json['protein'],
      carbohydrates: json['carbohydrates'],
      fats: json['fats'],
      vitamins: List<String>.from(json['vitamins']),
      minerals: List<String>.from(json['minerals']),
      glycemicIndex: json['glycemicIndex'],
      fiber: json['fiber'],
    );
  }
}
