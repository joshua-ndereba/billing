import 'package:billing/screens/authentication/loginscreen.dart';
import 'package:billing/screens/authentication/registrationscreen.dart';

class Routes {
  static const String login = '/login';
  static const String registration = '/registration';
  //static const String dashboard = '/dashboard';

  static final routes = {
    login: (context) => const LoginScreen(),
    registration: (context) =>  const Registrationscreen(),
    //dashboard: (context) =>const CustomerDashboardScreen(),
  };
}