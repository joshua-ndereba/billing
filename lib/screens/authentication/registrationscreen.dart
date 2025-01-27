import 'package:billing/widgets/mydropdown.dart';
import 'package:billing/widgets/textfielld.dart';
import 'package:flutter/material.dart';

final usercont = TextEditingController();
final emailcont = TextEditingController();
final passcont = TextEditingController();
final confirmcont = TextEditingController();


class Registrationscreen extends StatefulWidget {
  const Registrationscreen({super.key});

  @override
  State<Registrationscreen> createState() => _RegistrationscreenState();
}

class _RegistrationscreenState extends State<Registrationscreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("registration"),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
          padding: EdgeInsets.all(15.0),
          child: Column(
            children: [
              Textfielld(hintText: "username", controller: usercont),
              SizedBox(height: 16.0),
              Textfielld(hintText: "email", controller: emailcont),
              SizedBox(height: 16.0),
              Textfielld(hintText: "password", controller: passcont),
              SizedBox(height: 16.0),
              Textfielld(hintText: "confirm password", controller: confirmcont),
              SizedBox(height: 16.0),
              ElevatedButton(onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const NextPage()));
              }, child: Text("next page"))
            ],
          )
          ),
    );
  }
}

class NextPage extends StatelessWidget {
  const NextPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("registration"),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
          padding: EdgeInsets.all(15.0),
          child: Column(
            children: [
              MyDropdownButton(items: ['male', 'female'])
            ],
          )
          ),
    );
  }
}
