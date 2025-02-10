import 'package:billing/screens/finance/dashboard.dart';
import 'package:billing/screens/finance/invoice.dart';
import 'package:billing/screens/profile/history.dart';
import 'package:billing/screens/profile/manprofile.dart';
import 'package:billing/widgets/bottomnavigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PaymentProcessingScreen extends StatefulWidget {
  final double? amount; // Amount to be paid

  const PaymentProcessingScreen({super.key, this.amount});

  @override
  _PaymentProcessingScreenState createState() =>
      _PaymentProcessingScreenState();
}

class _PaymentProcessingScreenState extends State<PaymentProcessingScreen> {
  String _cardNumber = '';
  String _cardExpiry = '';
  String _cardCvc = '';

  void _processPayment() async {
    // Simulate payment processing (replace with actual gateway integration)
    try {
      // Validate card details (basic example)
      if (_cardNumber.isEmpty || _cardExpiry.isEmpty || _cardCvc.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please enter all card details')),
        );
        return;
      }

      // Simulate successful payment
      await Future.delayed(const Duration(seconds: 2));
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Payment successful!')),
      );
      // Navigate back to previous screen or display success message
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Payment failed. Please try again.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Make Payment'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Amount: \$${widget.amount?.toStringAsFixed(2)}',
              style: const TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20.0),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Card Number'),
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
              ],
              onChanged: (value) => _cardNumber = value,
            ),
            const SizedBox(height: 16.0),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    decoration: const InputDecoration(labelText: 'Expiry (MM/YY)'),
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(5), // Limit to 5 digits
                    ],
                    onChanged: (value) => _cardExpiry = value,
                  ),
                ),
                const SizedBox(width: 16.0),
                SizedBox(
                  width: 80,
                  child: TextFormField(
                    decoration: const InputDecoration(labelText: 'CVC'),
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(3), // Limit to 3 digits
                    ],
                    onChanged: (value) => _cardCvc = value,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: _processPayment,
              child: const Text('Pay Now'),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavBar(
        currentIndex: 2,
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