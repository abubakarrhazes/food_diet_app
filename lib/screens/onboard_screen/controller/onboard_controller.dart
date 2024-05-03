import 'package:food_diet_app/screens/onboard_screen/model/onboard_model.dart';

class OnboardController {
  List<OnboardModel> screens = [
    OnboardModel('assets/images/slider_img_1.png', 'Welcome to FoodDiet ',
        'Your Journey to Healthier Eating Starts Here!'),
    OnboardModel(
        'assets/images/onboard_2.png',
        '🌱 Discover Personalized Meal Plans',
        'Tailored to meet your unique dietary needs and preferences.'),
    OnboardModel('assets/images/onboard_3.png', '💡 Learn As You Go',
        'Gain insights with tips, recipes, and guidance from nutrition experts.'),
  ];
}
