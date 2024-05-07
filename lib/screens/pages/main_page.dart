// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, non_constant_identifier_names, unnecessary_string_interpolations

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_diet_app/config/config.dart';
import 'package:food_diet_app/providers/persistance_data/user_adapter.dart';
import 'package:food_diet_app/utils/color_constants.dart';
import 'package:food_diet_app/widgets/avatar.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> with TickerProviderStateMixin {
  List imges = [
    //'https://thumbs.dreamstime.com/b/man-s-balance-9894256.jpg',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQsoW52_EyFAL5csJNxB6PEbREOeUbidSj9uw&usqp=CAU',
    //'https://images.squarespace-cdn.com/content/v1/5452d441e4b0c188b51fef1a/1433027071399-PM7KLRE8MLWCEI7W7AK6/image-asset.jpeg',
    'https://thumbs.dreamstime.com/b/female-lawyer-office-portrait-boutique-law-firm-signing-documents-54969196.jpg',
    'https://thumbs.dreamstime.com/b/depressed-young-crying-woman-victim-domestic-violence-abuse-domestic-violence-depressed-young-crying-woman-victim-172161533.jpg',
    'https://thumbs.dreamstime.com/b/communication-background-table-top-vintage-old-red-telephone-receiver-business-womans-hand-holding-handset-against-130105092.jpg'
  ];

  List imgs = [
    'https://cdn-icons-png.flaticon.com/512/3321/3321770.png',
    'https://cdn-icons-png.flaticon.com/512/8562/8562995.png',
    'https://cdn-icons-png.flaticon.com/512/5862/5862869.png',
    'https://cdn-icons-png.flaticon.com/512/8972/8972994.png',
  ];
  final requestBaseUrl = Config.AuthBaseUrl;
  bool loading = true;

  List jibby = [
    'Breakfast',
    'Launch',
    'Dinner',
    'Emergency call',
  ];

  List exploreMore = [
    'Search  Case',
    'Cases Stats',
    'Hotmaps Indicators',
    'More Info'
  ];

  @override
  void initState() {
    super.initState();
  }

  var pickedIndex = 3;

  @override
  Widget build(BuildContext context) {
    final userAdapter = Provider.of<UserAdapter>(context);
    TabController _tabController = TabController(length: 3, vsync: this);

    return SafeArea(
      child: Scaffold(
          body: SingleChildScrollView(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
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
            const SizedBox(height: 20),
            //40
            Container(
                margin: const EdgeInsets.only(left: 20),
                child: Text(
                  'PolCop',
                  style: TextStyle(
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                      foreground: Paint()
                        ..shader = const LinearGradient(colors: <Color>[
                          Color.fromARGB(255, 41, 167, 226),
                          Colors.deepPurpleAccent,
                          Colors.indigo,
                        ]).createShader(
                            const Rect.fromLTWH(0.0, 0.0, 200.0, 100.0))),
                )),
            const SizedBox(height: 15), //30
            Container(
                child: Align(
              alignment: Alignment.centerLeft,
              child: TabBar(
                  labelPadding: const EdgeInsets.only(
                    left: 20,
                    right: 20,
                  ),
                  labelColor: Colors.black,
                  unselectedLabelColor: Colors.grey,
                  controller: _tabController,
                  isScrollable: true,
                  indicatorSize: TabBarIndicatorSize.label,
                  indicator: const CircleTabIndicator(
                      color: Color.fromRGBO(41, 30, 83, 1), radius: 4),
                  tabs: const [
                    Tab(text: 'What we offer'),
                    Tab(
                      text: 'Police Stations',
                    ),
                  ]),
            )),
            const SizedBox(height: 10),
            Container(
                padding: const EdgeInsets.only(left: 20),
                height: 300,
                width: double.maxFinite,
                child: TabBarView(controller: _tabController, children: [
                  ListView.builder(
                    itemCount: 4,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (BuildContext context, int index) {
                      return InkWell(
                        onTap: () {
                          /*
                          if (index == 0) {
                            //Navigator.pushNamed(context, routes.report_crime);
                          } else if (index == 1) {
                            //Navigator.pushNamed(context, routes.report_incident);
                          } else if (index == 2) {
                            Navigator.pushNamed(context, routes.blog);
                          } else {
                            Navigator.pushNamed(
                                context, routes.emergency_request);
                          }
                          */
                        },
                        child: Container(
                          padding: const EdgeInsets.only(right: 80, top: 15),
                          margin: const EdgeInsets.only(right: 25),
                          width: 200,
                          height: 300,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.white,
                              image: DecorationImage(
                                  image: NetworkImage(imges[
                                      index]), //AssetImage('assets/images/'+images.keys.elementAt()),
                                  fit: BoxFit.cover,
                                  colorFilter: const ColorFilter.mode(
                                    Color.fromARGB(126, 255, 255, 255),
                                    BlendMode.darken,
                                  ))),
                          child: Padding(
                            padding: const EdgeInsets.only(
                              left: 10,
                              top: 5,
                            ),
                            child: Text(
                              jibby[index],
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  /*
                  SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        const Text(
                          'Registered Police Stations',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 20),
                        FutureBuilder<>(
                          future: reportCrimeProvider.getStation(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Center(child: CircularProgressIndicator());
                            } else if (snapshot.hasError) {
                              return Center(
                                  child: Text('Error: ${snapshot.error}'));
                            } else {
                              return SingleChildScrollView(
                                child: ListView.builder(
                                  shrinkWrap:
                                      true, // Important: Make sure to set shrinkWrap to true
                                  itemCount: snapshot.data!.data!.length,
                                  itemBuilder: (context, index) {
                                    return InkWell(
                                      splashColor: Colors.grey,
                                      onTap: () {
                                        Navigator.pushNamed(
                                            context, '/lawyer_1');
                                      },
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                            left: 10, right: 20),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            const Image(
                                              image: AssetImage(
                                                  'assets/images/police.png'),
                                              height: 80,
                                              width: 80,
                                            ),
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: <Widget>[
                                                Text(
                                                  '${snapshot.data!.data![index].name}',
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                SizedBox(height: 5),
                                                Text(
                                                  '${snapshot.data!.data![index].address}',
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 12,
                                                  ),
                                                ),
                                                SizedBox(height: 5),
                                                Text(
                                                  '${snapshot.data!.data![index].telephone}',
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 12,
                                                  ),
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              );
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                  */

                  // donations screen
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        const Text('Make Donations',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.bold)),
                        const SizedBox(height: 10),
                        Expanded(
                          child: ListView(
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            children: <Widget>[
                              ListTile(
                                onTap: () {
                                  Navigator.pushNamed(context, '/donation_1');
                                },
                                trailing: const Icon(Icons.more_vert),
                                leading: Image.asset(
                                    'assets/images/prison1.jpg',
                                    height: 80,
                                    width: 80),
                                title: const Padding(
                                  padding: EdgeInsets.symmetric(vertical: 5),
                                  child: Text(
                                    'Chikurubi Maximum Prison',
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                subtitle: const Text(
                                  'Zimbabwe',
                                  style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey),
                                ),
                              ),
                              const SizedBox(height: 10),
                              ListTile(
                                onTap: () {
                                  Navigator.pushNamed(context, '/donation_2');
                                },
                                trailing: const Icon(Icons.more_vert),
                                leading: Image.asset('assets/images/vad.jpg',
                                    height: 80, width: 80),
                                title: const Padding(
                                  padding: EdgeInsets.symmetric(vertical: 5),
                                  child: Text(
                                    'Voice for african development initiative',
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                subtitle: const Text(
                                  'South Africa',
                                  style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey),
                                ),
                              ),
                              const SizedBox(height: 10),
                              ListTile(
                                onTap: () {
                                  Navigator.pushNamed(context, '/donation_3');
                                },
                                trailing: const Icon(Icons.more_vert),
                                leading: Image.asset(
                                    'assets/images/prison2.jpg',
                                    height: 80,
                                    width: 80),
                                title: const Padding(
                                  padding: EdgeInsets.symmetric(vertical: 5),
                                  child: Text(
                                    'The Mukobeko Maximum Prison',
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                subtitle: const Text(
                                  'Zambia',
                                  style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey),
                                ),
                              ),
                              const SizedBox(height: 10),
                              ListTile(
                                onTap: () {
                                  Navigator.pushNamed(context, '/ donation_4');
                                },
                                trailing: const Icon(Icons.more_vert),
                                leading: Image.asset('assets/images/ngo1.png',
                                    height: 80, width: 80),
                                title: const Padding(
                                  padding: EdgeInsets.symmetric(vertical: 5),
                                  child: Text(
                                    'Nigeria network of NGO\'s',
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                subtitle: const Text(
                                  'Nigeria',
                                  style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey),
                                ),
                              ),
                              const SizedBox(height: 10),
                              ListTile(
                                onTap: () {
                                  Navigator.pushNamed(context, '/donation_5');
                                },
                                trailing: const Icon(Icons.more_vert),
                                leading: Image.asset(
                                    'assets/images/prison3.jpg',
                                    height: 80,
                                    width: 80),
                                title: const Padding(
                                  padding: EdgeInsets.symmetric(vertical: 5),
                                  child: Text(
                                    'Kirikiri Maximum Security Prison',
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                subtitle: const Text(
                                  'Nigeria',
                                  style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey),
                                ),
                              ),
                              const SizedBox(height: 10),
                              const ListTile(
                                title: Text(
                                  'Do you own an organisation for rendering help?',
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        const SizedBox(height: 20), //40
                        Container(
                          child: Column(
                            children: [
                              InkWell(
                                onTap: () {
                                  Navigator.pushNamed(
                                      context, '/donationScreen');
                                },
                                child: Center(
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: Container(
                                      width: 180,
                                      height: 40,
                                      decoration: BoxDecoration(
                                        color: Colors.indigo,
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                      child: Center(
                                        child: Container(
                                          margin: const EdgeInsets.only(
                                              left: 20, right: 20),
                                          child: const Center(
                                            child: Text(
                                              'Register',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 20),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  )
                  // End of donations screen
                ])),
            const SizedBox(height: 20), //20
            Container(
                margin: const EdgeInsets.only(left: 20, right: 20),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text('Explore more',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.bold)),
                      Text('See all', style: TextStyle(color: Colors.grey)),
                    ])),
            const SizedBox(height: 11), //20
            Container(
              width: double.maxFinite,
              height: 100,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 4,
                itemBuilder: (BuildContext context, int index) {
                  return InkWell(
                    onTap: () {},
                    child: Container(
                      margin: const EdgeInsets.only(right: 10),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Container(
                              width: 80,
                              height: 80,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                image: DecorationImage(
                                    image: NetworkImage(imgs[
                                        index]), //AssetImage('assets/images/'+images.keys.elementAt()),
                                    fit: BoxFit.cover),
                              ),
                            ),
                            Text(
                              exploreMore[index],
                              style: TextStyle(
                                  color: KprimaryColor,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            )
          ]))),
    );
  }
}

class CircleTabIndicator extends Decoration {
  const CircleTabIndicator({
    required this.color,
    required this.radius,
  });

  final Color color;
  final double radius;

  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) {
    return _CirclePainter(color: color, radius: radius);
  }
}

class _CirclePainter extends BoxPainter {
  const _CirclePainter({
    required this.color,
    required this.radius,
  });

  final Color color;
  final double radius;
  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    Paint _paint = Paint();
    _paint.color = color;
    _paint.isAntiAlias = true;
    final Offset circleOffset = Offset(
        configuration.size!.width / 2 - radius / 2,
        configuration.size!.height - radius);

    canvas.drawCircle(offset + circleOffset, radius, _paint);
  }
}
