import 'package:flutter/material.dart';

// ignore_for_file: prefer_const_constructors

import 'package:flutter/foundation.dart';

//flimport 'package:com_policing_incident_app/screens/screen_selector.dart';
import 'package:flutter/material.dart';
import 'package:food_diet_app/providers/persistance_data/user_adapter.dart';
import 'package:food_diet_app/routes/app_routes.dart';
import 'package:google_fonts/google_fonts.dart';
//import 'package:flutter_inappwebview/flutter_inappwebview.dart';

import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

bool isViewed = false;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SharedPreferences preferences = await SharedPreferences.getInstance();
  isViewed = preferences.getBool('isViewed') ?? false;
  await preferences.setBool('isViewed', true);
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: ((context) => UserAdapter())),
  ], child: MyApp()));
}

class MyApp extends StatefulWidget {
  MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final AppRoutes appRoutes = AppRoutes();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Community Policing and Incident Repoting app  ',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme:
            ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 76, 175, 80)),
        textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme),
        useMaterial3: true,
      ),
      onGenerateRoute: appRoutes.controller,
      initialRoute: isViewed == false ? appRoutes.splash : appRoutes.login,
    );
  }
}
