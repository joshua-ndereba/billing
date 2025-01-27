//import 'package:billing/routes/routes.dart';
import 'package:billing/screens/authentication/loginscreen.dart';
import 'package:billing/screens/authentication/registrationscreen.dart';
import 'package:billing/screens/finance/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


void main() {
  runApp( const MyApp() as Widget  );

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'kwetu billing',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primaryColor: Colors.blue),
      home: const LoginScreen(),
      initialRoute: Routes.login,
      routes: Routes.routes,
    );
  }
}

class Routes {
  static const String splash = '/splash';
  static const String login = '/login';
  static const String registration = '/registration';
  static const String dashboard = '/dashboard';

  static final routes = {
   login: (context) => const LoginScreen(),
    registration: (context) =>  const Registrationscreen(),
    dashboard: (context) => CustomerDashboardScreen(),
  };
}

