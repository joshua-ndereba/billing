/*import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ContactsScreen extends StatefulWidget {
  const ContactsScreen({super.key});

  @override
  State<ContactsScreen> createState() => _ContactsScreenState();
}

class _ContactsScreenState extends State<ContactsScreen> {
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      'https://www.googleapis.com/auth/contacts.readonly',
    ],
  );
  List<Map<String, dynamic>> _contacts = [];

  @override
  void initState() {
    super.initState();
    _getContacts();
  }

  Future<void> _getContacts() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        print('User not signed in.');
        return;
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final String accessToken = googleAuth.accessToken!;

      final contacts = await _fetchContacts(accessToken);
      setState(() {
        _contacts = contacts;
      });
    } catch (error) {
      print('Error getting contacts: $error');
    }
  }

  Future<List<Map<String, dynamic>>> _fetchContacts(String accessToken) async {
    final url = Uri.parse(
        'https://people.googleapis.com/v1/people/me/connections?personFields=names,phoneNumbers');
    final headers = {
      'Authorization': 'Bearer $accessToken',
    };
    final response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final List<dynamic> connections = data['connections'];

      return connections.map((connection) {
        final name = connection['names']?[0]?['displayName'];
        final phoneNumbers = connection['phoneNumbers'] ?? [];
        final phoneNumber = phoneNumbers.isNotEmpty ? phoneNumbers[0]['value'] : '';

        return {
          'name': name ?? '',
          'phone': phoneNumber ?? '',
        };
      }).toList();
    } else {
      throw Exception('Failed to load contacts: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Contacts'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Search Bar (same as in the previous example)
            Expanded(
              child: ListView.builder(
                itemCount: _contacts.length,
                itemBuilder: (context, index) {
                  return CheckboxListTile(
                    title: Text(_contacts[index]['name']),
                    subtitle: Text(_contacts[index]['phone']), value: null, onChanged: (bool? value) {  },
                    // ... rest of the CheckboxListTile code (same as in the previous example)
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}


import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:permission_handler/permission_handler.dart';

class ContactsScreen extends StatefulWidget {
  const ContactsScreen({Key? key}) : super(key: key);

  @override
  State<ContactsScreen> createState() => _ContactsScreenState();
}

class _ContactsScreenState extends State<ContactsScreen> {
  List<Contact> _contacts = [];
  bool _isLoading = false;

  Future<void> _getContacts() async {
    setState(() {
      _isLoading = true;
    });

    if (await Permission.contacts.request().isGranted) {
      try {
        _contacts = await FlutterContacts.getContacts(withProperties: true);
      } catch (e) {
        print('Error fetching contacts: $e');
      }
    } else {
      print('Permission denied');
    }

    setState(() {
      _isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _getContacts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contacts'),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: _contacts.length,
              itemBuilder: (context, index) {
                final contact = _contacts[index];
                return ListTile(
                  title: Text(contact.displayName ?? ''),
                  subtitle: Text(contact.phones.isNotEmpty
                      ? contact.phones.first.value ?? ''
                      : ''),
                  // Add more contact details as needed
                );
              },
            ),
    );
  }
}

extension on Phone {
  get value => null;
}*/

import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:google_sign_in/google_sign_in.dart';

class ContactsScreen extends StatefulWidget {
  final GoogleSignInAccount? user;

  const ContactsScreen({Key? key, required this.user}) : super(key: key);

  @override
  State<ContactsScreen> createState() => _ContactsScreenState();
}

class _ContactsScreenState extends State<ContactsScreen> {
  List<Contact> _contacts = [];
  bool _isLoading = false;

  Future<void> _getContacts() async {
    setState(() {
      _isLoading = true;
    });

    try {
      _contacts = await FlutterContacts.getContacts(withProperties: true);
    } catch (e) {
      print('Error fetching contacts: $e');
    }

    setState(() {
      _isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _getContacts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contacts'),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: _contacts.length,
              itemBuilder: (context, index) {
                final contact = _contacts[index];
                return ListTile(
                  title: Text(contact.displayName ?? ''),
                  subtitle: Text(contact.phones.isNotEmpty
                      ? contact.phones.first.value ?? ''
                      : ''),
                  // Add more contact details as needed
                );
              },
            ),
    );
  }
}

extension on Phone {
  get value => null;
}