import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:winesvendor/model/data.dart';
import 'package:http/http.dart' as http;

import 'model/data_model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'App Brewery',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: WinesPage(),
    );
  }
}

class WinesPage extends StatefulWidget {
  WinesPage({Key? key}) : super(key: key);

  @override
  State<WinesPage> createState() => _WinesPageState();
}

class _WinesPageState extends State<WinesPage> {
  late Future<Wines> myData;

  Future<List<Wines>> getWines() async {
    const url = 'https://api.sampleapis.com/coffee/hot';
    final response = await http.get(Uri.parse(url));
    var jsonData =await jsonDecode(response.body);

    print(jsonData);

    return jsonData.map<Wines>(Wines.fromJson).toList();
  }

  @override
  void initState() {
    
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double _screenHeight = MediaQuery.of(context).size.height;
    double _screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: FutureBuilder<List<Wines>>(
          future: getWines(),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              final wines = snapshot.data;
              return buildUser(wines);
            }
          }),
    );
  }

  ListView buildUser(List<Wines> wines) {
    return ListView.builder(
        itemCount: wines.length,
        itemBuilder: ((context, index) {
          final user = wines[index];
          return Text(user.winery);
        }));
  }
}
