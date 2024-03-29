import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:patterns/generalFunctions/random_id_generator.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

_launchURL() async {
  const url = 'https://www.instagram.com/patterns.jo/';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

class _HomeViewState extends State<HomeView> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  void initState() {
    super.initState();
    lookupUserDetails();
  }

  lookupUserDetails() async {
    final response = await http
        .get(Uri.parse('https://api.ipregistry.co?key=rq5ak2pcm1sjudhd'));

    if (response.statusCode == 200) {
      Map<String, dynamic> userDetails = {
        'ip': json.decode(response.body)['ip'],
        'hostname': json.decode(response.body)['hostname'],
        'country': json.decode(response.body)['location']['country']['name'],
        'city': json.decode(response.body)['location']['city'],
        'header': json.decode(response.body)['user_agent']['header'],
        'brand': json.decode(response.body)['user_agent']['device']['brand'],
        'name': json.decode(response.body)['user_agent']['device']['name'],
        'security': json.decode(response.body)['security'],
      };
      addUsersDetails(userDetails);

      return userDetails;
    } else {
      throw Exception('Failed to get user!');
    }
  }

  /// This function will update address for an existing user in firebase
  Future<void> addUsersDetails(Map<String, dynamic> details) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(generateId() + "Details")
        .set({'userDetails': details});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: OrientationBuilder(
        builder: (context, orientation) {
          return ListView(
            children: <Widget>[
              Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                runAlignment: WrapAlignment.center,
                alignment: WrapAlignment.center,
                runSpacing: 10.0,
                spacing: 10.0,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.2,
                        ),
                        GestureDetector(
                          onTap: () async {
                            _launchURL();
                          },
                          child: Image.asset(
                            "patterns1.png",
                            height: 140.0,
                            width: 190.0,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Patterns',
                            style: GoogleFonts.quicksand(
                              textStyle: Theme.of(context)
                                  .textTheme
                                  .headline6!
                                  .copyWith(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 60.0,
                                  ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Comfotrable texture for less",
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.headline6,
                          ),
                        ),
                        Container(child: Row(children: <Widget>[])),
                        // Padding(
                        //   padding: const EdgeInsets.only(
                        //     top: 10.0,
                        //     bottom: 10.0,
                        //     left: 20.0,
                        //     right: 20.0,
                        //   ),
                        //   child: Text(
                        //     "Patterns an online store based in Amman-Jordan ... With Patterns ... ...",
                        //     textAlign: TextAlign.center,
                        //     style:
                        //         Theme.of(context).textTheme.bodyText1!.copyWith(
                        //               fontSize: 20.0,
                        //               height: 1.8,
                        //               fontWeight: FontWeight.w300,
                        //             ),
                        //   ),
                        // ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            TextButton(
                              onPressed: () {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                  content: Text("Coming Soon"),
                                  duration: Duration(milliseconds: 800),
                                ));
                              },
                              child: Image.asset(
                                "google-play-soon.png",
                                height: 80.0,
                                width: 150.0,
                              ),
                            ),
                            SizedBox(width: 10),
                            TextButton(
                              onPressed: () {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                  content: Text("Coming Soon"),
                                  duration: Duration(milliseconds: 800),
                                ));
                              },
                              child: Image.asset(
                                "appstore.png",
                                height: 100.0,
                                width: 150.0,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              _buildFeatureOne(),
              _buildFeatureTwo(orientation),
              _buildFeatureThree(),
              _buildFeatureFour(orientation),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.2,
                    ),
                    GestureDetector(
                      onTap: () async {
                        _launchURL();
                      },
                      child: Image.asset(
                        "patterns1.png",
                        height: 140.0,
                        width: 190.0,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Patterns',
                        style: GoogleFonts.quicksand(
                          textStyle:
                              Theme.of(context).textTheme.headline6!.copyWith(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 60.0,
                                  ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Comfotrable texture for less",
                        textAlign: TextAlign.center,
                        style: Theme.of(context)
                            .textTheme
                            .headline6!
                            .copyWith(color: Colors.grey),
                      ),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        TextButton(
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text("Coming Soon"),
                              duration: Duration(milliseconds: 800),
                            ));
                          },
                          child: Image.asset(
                            "google-play-soon.png",
                            height: 80.0,
                            width: 150.0,
                          ),
                        ),
                        SizedBox(width: 10),
                        TextButton(
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text("Coming Soon"),
                              duration: Duration(milliseconds: 800),
                            ));
                          },
                          child: Image.asset(
                            "appstore.png",
                            height: 100.0,
                            width: 150.0,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.2,
                    ),
                  ],
                ),
              ),
              Container(
                color: Colors.grey.withOpacity(0.1),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Text(
                            "2021 ",
//                            style: Theme.of(context).textTheme.headline6,
                          ),
                          Icon(
                            Icons.copyright,
                            size: 16.0,
                          ),
                          Text(
                            " Patterns",
//                            style: Theme.of(context).textTheme.headline6,
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          TextButton(
                            onPressed: () {},
                            child: Text("Terms",
                                style: TextStyle(color: Colors.black)
//                              style: Theme.of(context).textTheme.headline6,
                                ),
                          ),
                          TextButton(
                            onPressed: () {},
                            child: Text(
                              "Privacy", style: TextStyle(color: Colors.black),
//                              style: Theme.of(context).textTheme.headline6,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildFeatureOne() {
    return Container(
      color: Colors.yellow,
      child: Wrap(
        crossAxisAlignment: WrapCrossAlignment.center,
        runAlignment: WrapAlignment.center,
        alignment: WrapAlignment.center,
        runSpacing: 10.0,
        spacing: 10.0,
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.height * 0.5,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "SHOPPING EXPERIENCE",
                      textAlign: TextAlign.center,
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1!
                          .copyWith(fontSize: 15.0, color: Colors.grey),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Shop your favorite brand and pattern",
                      style: Theme.of(context).textTheme.headline3!.copyWith(
                          fontWeight: FontWeight.bold, color: Colors.black),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Patterns team will always focus on finding new ways for you to enjoy shopping your way!",
                      style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            fontSize: 18.0,
                            height: 1.8,
                            fontWeight: FontWeight.w300,
                          ),
                    ),
                  )
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset(
              'homescreenshot.png',
              fit: BoxFit.cover,
              height: MediaQuery.of(context).size.height * 0.6,
              width: MediaQuery.of(context).size.height * 0.4,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureTwo(Orientation orientation) {
    return orientation == Orientation.portrait
        ? Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            runAlignment: WrapAlignment.center,
            alignment: WrapAlignment.center,
            runSpacing: 10.0,
            spacing: 10.0,
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.height * 0.5,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "STAY UPDATED",
                          textAlign: TextAlign.center,
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(fontSize: 15.0, color: Colors.grey),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "More textrues and patterns",
                          style: Theme.of(context)
                              .textTheme
                              .headline3!
                              .copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Stay updated to offers and items every season with unique collections",
                          style:
                              Theme.of(context).textTheme.bodyText1!.copyWith(
                                    fontSize: 18.0,
                                    height: 1.8,
                                    fontWeight: FontWeight.w300,
                                  ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset(
                  'first.png',
                  fit: BoxFit.cover,
                  height: MediaQuery.of(context).size.height * 0.6,
                  width: MediaQuery.of(context).size.height * 0.4,
                ),
              ),
            ],
          )
        : Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            runAlignment: WrapAlignment.center,
            alignment: WrapAlignment.center,
            runSpacing: 10.0,
            spacing: 10.0,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset(
                  'first.png',
                  fit: BoxFit.cover,
                  height: MediaQuery.of(context).size.height * 0.6,
                  width: MediaQuery.of(context).size.height * 0.4,
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.height * 0.5,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "STAY UPDATED",
                          textAlign: TextAlign.center,
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(fontSize: 15.0, color: Colors.grey),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "More textrues and patterns",
                          style: Theme.of(context)
                              .textTheme
                              .headline3!
                              .copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Stay updated to offers and items every season with unique collections",
                          style:
                              Theme.of(context).textTheme.bodyText1!.copyWith(
                                    fontSize: 18.0,
                                    height: 1.8,
                                    fontWeight: FontWeight.w300,
                                  ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          );
  }

  Widget _buildFeatureThree() {
    return Container(
      color: Colors.yellow,
      child: Wrap(
        crossAxisAlignment: WrapCrossAlignment.center,
        runAlignment: WrapAlignment.center,
        alignment: WrapAlignment.center,
        runSpacing: 10.0,
        spacing: 10.0,
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.height * 0.5,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "FEEDBACK",
                      textAlign: TextAlign.center,
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1!
                          .copyWith(fontSize: 15.0, color: Colors.grey),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Review and rate",
                      style: Theme.of(context).textTheme.headline3!.copyWith(
                          fontWeight: FontWeight.bold, color: Colors.black),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Feedback always builds trust and honesty. Review or rate our products and let others know our reputation.",
                      style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            fontSize: 18.0,
                            height: 1.8,
                            fontWeight: FontWeight.w300,
                          ),
                    ),
                  )
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset(
              'reviewscreenshot.png',
              fit: BoxFit.cover,
              height: MediaQuery.of(context).size.height * 0.6,
              width: MediaQuery.of(context).size.height * 0.4,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureFour(Orientation orientation) {
    return orientation == Orientation.portrait
        ? Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            runAlignment: WrapAlignment.center,
            alignment: WrapAlignment.center,
            runSpacing: 10.0,
            spacing: 10.0,
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.height * 0.5,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "QUICK RESPONSE",
                          textAlign: TextAlign.center,
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(fontSize: 15.0, color: Colors.grey),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "More ways to reach patterns team",
                          style: Theme.of(context)
                              .textTheme
                              .headline3!
                              .copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "With the platforms you love through whatsapp or calls. Patterns lets you contact our delivery team easily and quickly",
                          style:
                              Theme.of(context).textTheme.bodyText1!.copyWith(
                                    fontSize: 18.0,
                                    height: 1.8,
                                    fontWeight: FontWeight.w300,
                                  ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset(
                  'contactscreenshot.png',
                  fit: BoxFit.cover,
                  height: MediaQuery.of(context).size.height * 0.6,
                  width: MediaQuery.of(context).size.height * 0.4,
                ),
              ),
            ],
          )
        : Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            runAlignment: WrapAlignment.center,
            alignment: WrapAlignment.center,
            runSpacing: 10.0,
            spacing: 10.0,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset(
                  'contactscreenshot.png',
                  fit: BoxFit.cover,
                  height: MediaQuery.of(context).size.height * 0.6,
                  width: MediaQuery.of(context).size.height * 0.4,
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.height * 0.5,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "QUICK RESPONSE",
                          textAlign: TextAlign.center,
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(fontSize: 15.0, color: Colors.grey),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "More ways to reach patterns team",
                          style: Theme.of(context)
                              .textTheme
                              .headline3!
                              .copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "With the platforms, you love through WhatsApp and Calls. Patterns lets you contact our delivery team easily and quickly",
                          style:
                              Theme.of(context).textTheme.bodyText1!.copyWith(
                                    fontSize: 18.0,
                                    height: 1.8,
                                    fontWeight: FontWeight.w300,
                                  ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          );
  }
}
