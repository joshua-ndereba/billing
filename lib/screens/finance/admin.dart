import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AdminPanel extends StatefulWidget {
  final GoogleSignInAccount? user;

  const AdminPanel({Key? key, required this.user}) : super(key: key);

  @override
  State<AdminPanel> createState() => _AdminPanelState();
}

class _AdminPanelState extends State<AdminPanel> {
  List<Contact> _contacts = [];
  List<Contact> _selectedContacts = [];
  TextEditingController _messageController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _getContacts();
  }

  Future<void> _getContacts() async {
    try {
      _contacts = await FlutterContacts.getContacts(withProperties: true);
    } catch (e) {
      print('Error fetching contacts: $e');
    }
  }

  Future<void> _sendMessage() async {
    for (var contact in _selectedContacts) {
      if (contact.phones.isNotEmpty) {
        //String phoneNumber = contact.phones.first.value!; 
        // **IMPORTANT:** Replace with your actual FCM server key
        String fcmServerKey = "YOUR_FCM_SERVER_KEY"; 

        // Create FCM message
        Map<String, dynamic> message = {
          'to': '/topics/all_devices', // Send to all devices subscribed to the 'all_devices' topic
          'notification': {
            'title': 'Maintenance Alert',
            'body': _messageController.text,
          },
          'data': {
            'message': _messageController.text,
          },
        };

        // Send FCM message
        try {
          http.Response response = await http.post(
            Uri.parse('https://fcm.googleapis.com/fcm/send'),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
              'Authorization': 'key=$fcmServerKey',
            },
            body: jsonEncode(message),
          );

          if (response.statusCode == 200) {
            print('FCM message sent successfully!');
          } else {
            print('FCM message sending failed with status code: ${response.statusCode}');
            print('Response body: ${response.body}');
          }
        } catch (e) {
          print('Error sending FCM message: $e');
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Panel'),
      ),
      body: Column(
        children: [
          TextField(
            controller: _messageController,
            decoration: const InputDecoration(
              labelText: 'Enter Message',
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _contacts.length,
              itemBuilder: (context, index) {
                final contact = _contacts[index];
                return CheckboxListTile(
                  title: Text(contact.displayName ?? ''),
                  //subtitle: Text(contact.phones.isNotEmpty
                      //? contact.phones.first.value ?? ''
                      //: ''),
                  value: _selectedContacts.contains(contact),
                  onChanged: (value) {
                    setState(() {
                      if (value!) {
                        _selectedContacts.add(contact);
                      } else {
                        _selectedContacts.remove(contact);
                      }
                    });
                  },
                );
              },
            ),
          ),
          ElevatedButton(
            onPressed: _sendMessage,
            child: const Text('Send Message'),
          ),
        ],
      ),
    );
  }
}