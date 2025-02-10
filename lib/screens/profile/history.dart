import 'package:billing/screens/finance/dashboard.dart';
import 'package:billing/screens/finance/invoice.dart';
import 'package:billing/screens/finance/payment.dart';
import 'package:billing/screens/profile/manprofile.dart';
import 'package:billing/widgets/bottomnavigation.dart';
import 'package:flutter/material.dart';

class PaymentHistoryScreen extends StatelessWidget {
  // Assuming you have a list of payment data
  final List<Map<String, dynamic>> _paymentHistory = [
    {
      'date': '2024-11-20',
      'amount': 50.00,
      'method': 'Credit Card',
      'transactionId': '1234567890',
    },
    {
      'date': '2024-11-15',
      'amount': 30.00,
      'method': 'Bank Transfer',
      'transactionId': '9876543210',
    },
    // ... more payments
  ];

   PaymentHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Payment History'),
      ),
      body: ListView.builder(
        itemCount: _paymentHistory.length,
        itemBuilder: (context, index) {
          final payment = _paymentHistory[index];
          return ListTile(
            title: Text('Date: ${payment['date']}'),
            subtitle: Text(
                'Amount: \$${payment['amount'].toStringAsFixed(2)} - ${payment['method']}'),
            trailing: Text('Transaction ID: ${payment['transactionId']}'),
          );
        },
      ),
      bottomNavigationBar: BottomNavBar(
        currentIndex: 3,
        screens: [
          const CustomerDashboardScreen(),
          const InvoiceCreationScreen(),
          const PaymentProcessingScreen(),
          PaymentHistoryScreen(),
          const CustomerProfileScreen()
          
        ],
      ),
    );
  }
}