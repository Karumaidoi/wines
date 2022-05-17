import 'dart:io';

import 'package:flutter/material.dart';

import 'package:url_launcher/url_launcher.dart';
import 'package:winesvendor/ui/devs.dart';
import 'package:winesvendor/ui/home_screen.dart';



void main() {
  HttpOverrides.global = MyHttpOverrides();
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
        useMaterial3: true,
        fontFamily: 'Turing',
        colorScheme: const ColorScheme.highContrastDark(),
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
  
  int index = 0;

  void launchEmail() async {
    String url = 'https://github.com/Karumaidoi/wines';

    await canLaunch(url) ? launch(url) : print('Unable');
  }

  

  List pages = [
    HomePage(),
    const SettingsPage(),
  ];

 

  @override
  Widget build(BuildContext context) {
    double _screenHeight = MediaQuery.of(context).size.height;
    double _screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        // backgroundColor: AppColors.lightColor,
        title: const Text(
          'Coffee Expresso',
          style: TextStyle(
            fontSize: 14,
          ),
        ),
        actions: [
          IconButton(
              onPressed: () async {
                launchEmail();
              },
              icon: const Icon(
                Icons.code,
                color: Colors.white,
              ))
        ],
      ),
      body: pages[index],
      bottomNavigationBar: NavigationBarTheme(
        data: NavigationBarThemeData(
          // indicatorColor: Colors.blue.shade200,
          labelTextStyle: MaterialStateProperty.all(const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w400,
          )),
        ),
        child: NavigationBar(
            selectedIndex: index,
            height: 80,
            onDestinationSelected: (index) =>
                setState(() => this.index = index),
            destinations: const [
              NavigationDestination(
                  icon: Icon(Icons.home_rounded),
                  label: 'Home',
                  selectedIcon: Icon(Icons.home_filled)),
              NavigationDestination(
                  icon: Icon(Icons.group),
                  label: 'Dev',
                  selectedIcon: Icon(Icons.group)),
            ]),
      ),
    );
  }
}


 class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext? context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}
// TODO: onpress => more details, style Ui