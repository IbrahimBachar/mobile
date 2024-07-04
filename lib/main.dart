import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mobile_programming/Calculator.dart';
import 'package:mobile_programming/HomePage.dart';
import 'package:mobile_programming/SignIn.dart';
import 'package:mobile_programming/SignUp.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:async';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeMode _themeMode = ThemeMode.system;
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;

  @override
  void initState() {
    super.initState();
    _loadThemeMode();
    _startConnectivitySubscription();
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }

  void _loadThemeMode() async {
    final prefs = await SharedPreferences.getInstance();
    final themeModeString = prefs.getString('themeMode') ?? 'system';
    setState(() {
      _themeMode = _themeModeFromString(themeModeString);
    });
  }

  void _saveThemeMode(ThemeMode themeMode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('themeMode', _themeModeToString(themeMode));
    setState(() {
      _themeMode = themeMode;
    });
  }

  ThemeMode _themeModeFromString(String themeModeString) {
    switch (themeModeString) {
      case 'light':
        return ThemeMode.light;
      case 'dark':
        return ThemeMode.dark;
      case 'system':
      default:
        return ThemeMode.system;
    }
  }

  String _themeModeToString(ThemeMode themeMode) {
    switch (themeMode) {
      case ThemeMode.light:
        return 'light';
      case ThemeMode.dark:
        return 'dark';
      case ThemeMode.system:
      default:
        return 'system';
    }
  }

  void _startConnectivitySubscription() {
    _connectivitySubscription = _connectivity.onConnectivityChanged.listen((ConnectivityResult result) {
      String message;
      Color bgColor;
      switch (result) {
        case ConnectivityResult.wifi:
          message = "Connected to WiFi";
          bgColor = Colors.green;
          break;
        case ConnectivityResult.mobile:
          message = "Connected to Mobile Network";
          bgColor = Colors.green;
          break;
        case ConnectivityResult.none:
          message = "No Internet Connection";
          bgColor = Colors.red;
          break;
        default:
          message = "Connectivity Changed";
          break;
      }
      Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        // backgroundColor: bgColor,
        textColor: Colors.white,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Gaba Tourba',
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: _themeMode,
      home: HomePage(
        onThemeChanged: _saveThemeMode,
        themeMode: _themeMode,
      ),
      routes: {
        '/signin': (context) => const SignInForm(),
        '/signup': (context) => const SignUpForm(),
        '/calculator': (context) => Calculator(),
      },
    );
  }
}