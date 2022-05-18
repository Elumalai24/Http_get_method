import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main(List<String> args) {
  runApp(MaterialApp(
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late int total, country, dayOne;
  bool isLoaded = false;
  getDatas() async {
    try {
      http.Response response =
          await http.get(Uri.parse('https://api.covid19api.com/stats'));
      var data = jsonDecode(response.body);
      setState(() {
        total = data['Total'];
        country = data['ByCountryTotal'];
        dayOne = data['DayOneTotal'];
        isLoaded = true;
      });
    } catch (e) {
      total = 0;
      country = 0;
      dayOne = 0;
      isLoaded = true;
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    getDatas();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: Text('Http get method'),
          ),
          body: isLoaded
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Total count is =$total',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'Country count is =$country',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'DayOne count is =$dayOne',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                )
              : CircularProgressIndicator()),
    );
  }
}
