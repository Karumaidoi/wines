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
      home: const WinesPage(),
    );
  }
}

class WinesPage extends StatefulWidget {
  const WinesPage({Key? key}) : super(key: key);

  @override
  State<WinesPage> createState() => _WinesPageState();
}

class _WinesPageState extends State<WinesPage> {
  late Future<List<Coffee>> myData;

  Future<List<Coffee>> getCoffee() async {
    const url = 'https://api.sampleapis.com/coffee/hot';
    final response = await http.get(Uri.parse(url));
    var jsonData = jsonDecode(response.body);

    print(jsonData);

    return jsonData.map<Coffee>(Coffee.fromJson).toList();
  }

  @override
  void initState() {
    myData = getCoffee();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double _screenHeight = MediaQuery.of(context).size.height;
    double _screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: FutureBuilder<List<Coffee>>(
          future: myData,
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text("An error occured: ${snapshot.error}"),
              );
            }
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              final coffee = snapshot.data;
              // return GridView.builder(
              //   shrinkWrap: true,
              //   gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              //     crossAxisCount: 2,
              //     mainAxisExtent: 55,
              //     childAspectRatio: 1,
              //     crossAxisSpacing: 15,
              //     mainAxisSpacing: 25,
              //   ),
              //   itemBuilder: (context, index) {
              //     return Text(coffee[index].title);
              //   },
              //   itemCount: coffee.length,
              // );
              return ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: coffee.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Center(
                          child: Text(
                        coffee[index].title,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      )),
                      subtitle: Column(
                        children: [
                          Text(coffee[index].description),
                          Chip(label: Text(coffee[index].ingredients.toString()))
                        ],
                      ),
                      isThreeLine: true,
                    );
                  });
            }
          }),
    );
  }

  // ListView buildUser(List<Wines> wines) {
  //   return ListView.builder(
  //       itemCount: wines.length,
  //       itemBuilder: ((context, index) {
  //         final user = wines[index];
  //         return Text(user.winery.toString());
  //       }));
  // }

}
// TODO: onpress => more details, style Ui