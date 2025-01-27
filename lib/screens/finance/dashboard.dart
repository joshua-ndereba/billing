import 'package:billing/screens/finance/admin.dart';
import 'package:billing/screens/finance/contacts.dart';
import 'package:billing/screens/finance/invoice.dart';
import 'package:billing/screens/finance/payment.dart';
import 'package:billing/screens/profile/history.dart';
import 'package:billing/screens/profile/manprofile.dart';
import 'package:billing/widgets/bottomnavigation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomerDashboardScreen extends StatefulWidget {
  const CustomerDashboardScreen({super.key});

  @override
  State<CustomerDashboardScreen> createState() =>
      _CustomerDashboardScreenState();
}

class _CustomerDashboardScreenState extends State<CustomerDashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Customer Dashboard',
            style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Customer Information Card
              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Joshua',
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8.0),
                      Text('Email: joshua@example.com'),
                      SizedBox(height: 8.0),
                      Text('Phone: +254712 345 678'),
                      SizedBox(height: 8.0),
                      Text(
                        'Account Balance: \$100.00',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20.0),
              // Recent Invoices
              const Text(
                'Recent Invoices',
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10.0),
              // Example using ListTile for a cleaner look
              const ListTile(
                leading: Icon(Icons.receipt),
                title: Text('Invoice #123'),
                subtitle: Text('Date: 2024-11-20'),
                trailing: Text('\$50.00'),
              ),
              const ListTile(
                leading: Icon(Icons.receipt),
                title: Text('Invoice #456'),
                subtitle: Text('Date: 2024-11-15'),
                trailing: Text('\$30.00'),
              ),
              ElevatedButton(
                  onPressed: () async {
                    //ContactsScreen();
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const AdminPanel(user: null)),
                    );
                    
                    
                  },
                  child: Text("contacts")),
              const SizedBox(height: 20.0),
              // Payment History Chart (Simplified Example)
              const Text(
                'Payment History',
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10.0),
              Container(
                height: 200,
                decoration: BoxDecoration(
                  border: Border.all(),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: const Center(
                  child: Text('Payment History Chart (Placeholder)'),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavBar(
        currentIndex: 0,
        screens: [
          const CustomerDashboardScreen(),
          InvoiceCreationScreen(),
          const PaymentProcessingScreen(),
          PaymentHistoryScreen(),
          const CustomerProfileScreen()
        ],
      ),
    );
  }
}
/*
class ContactsScreen extends StatefulWidget {
  const ContactsScreen({super.key});

  @override
  State<ContactsScreen> createState() => _ContactsScreenState();
}

class _ContactsScreenState extends State<ContactsScreen> {
  List<String> _contacts = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Contacts'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const MessageScreen()),
                  );
                },
                child: Text("add contacts")),
            TextField(
              onChanged: (value) {
                // Handle adding contacts (e.g., from user input or phone contacts)
              },
              decoration: const InputDecoration(
                hintText: 'Enter phone number or import from contacts',
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: _contacts.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(_contacts[index]),
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

class MessageScreen extends StatefulWidget {
  const MessageScreen({super.key});

  @override
  State<MessageScreen> createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  String _message = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Compose Message'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              maxLines: 5,
              onChanged: (value) => _message = value,
              decoration: const InputDecoration(
                hintText: 'Enter your message here',
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Send the message to all contacts using FCM or another messaging service
                // (This is a simplified example and requires actual FCM integration)
                if (_message.isNotEmpty) {
                  // Placeholder: Replace with actual FCM logic
                  print('Sending message: $_message');
                  // ... integrate with FCM here ...
                }
              },
              child: const Text('Send Message'),
            ),
          ],
        ),
      ),
    );
  }
}
*/