import 'dart:convert';

import 'package:flutter/material.dart';

import '../color/app_colors.dart';
import '../model/data_model.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
    super.initState();
    myData = getCoffee();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<Coffee>>(
          future: myData,
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text("An error occured: ${snapshot.error.toString().split(':')[0]}", textAlign: TextAlign.center,),
              );
            }
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              final coffee = snapshot.data;
              return ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: coffee.length,
                  itemBuilder: (context, index) {
                    return Card(
                      color: AppColors.lightColor,
                      child: ListTile(
                        title: Text(
                          coffee[index].title,
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        subtitle: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(coffee[index].description),
                            const SizedBox(
                              height: 10,
                            ),
                            Chip(
                                backgroundColor: AppColors.auditionColor,
                                label: Text(coffee[index]
                                    .ingredients
                                    .toString()
                                    .split('[')[1]
                                    .split(']')[0]))
                          ],
                        ),
                        isThreeLine: true,
                      ),
                    );
                  });
            }
          }),
    );
  }
}