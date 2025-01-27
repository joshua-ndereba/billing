import 'package:billing/screens/finance/dashboard.dart';
import 'package:billing/screens/finance/payment.dart';
import 'package:billing/screens/profile/history.dart';
import 'package:billing/screens/profile/manprofile.dart';
import 'package:billing/widgets/bottomnavigation.dart';
import 'package:flutter/material.dart';

class InvoiceCreationScreen extends StatefulWidget {
  const InvoiceCreationScreen({super.key});

  @override
  _InvoiceCreationScreenState createState() => _InvoiceCreationScreenState();
}

class _InvoiceCreationScreenState extends State<InvoiceCreationScreen> {
  final _formKey = GlobalKey<FormState>();

  String _customerName = '';
  String _invoiceDate = '';
  String _dueDate = '';
  List<Map<String, dynamic>> _items = [];

  void _addItem() {
    setState(() {
      _items.add({
        'description': '',
        'quantity': 1,
        'price': 0.0,
      });
    });
  }

  void _removeItem(int index) {
    setState(() {
      _items.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Invoice'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Customer Selection (Simplified)
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Customer Name'),
                  onChanged: (value) => _customerName = value,
                  validator: (value) =>
                      value!.isEmpty ? 'Please enter customer name' : null,
                ),
                const SizedBox(height: 16.0),
                // Invoice Date
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Invoice Date'),
                  readOnly: true,
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2100),
                    );
                    if (pickedDate != null) {
                      setState(() {
                        _invoiceDate = pickedDate.toString();
                      });
                    }
                  },
                ),
                const SizedBox(height: 16.0),
                // Due Date
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Due Date'),
                  readOnly: true,
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2100),
                    );
                    if (pickedDate != null) {
                      setState(() {
                        _dueDate = pickedDate.toString();
                      });
                    }
                  },
                ),
                const SizedBox(height: 16.0),
                // Invoice Items
                const Text(
                  'Invoice Items',
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10.0),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: _items.length,
                  itemBuilder: (context, index) {
                    return _buildItemRow(index);
                  },
                ),
                ElevatedButton(
                  onPressed: _addItem,
                  child: const Text('Add Item'),
                ),
                const SizedBox(height: 20.0),
                // Calculate and Display Total (Placeholder)
                const Text('Total: \$0.00'),
                const SizedBox(height: 20.0),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // Process invoice creation here (e.g., save to database)
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Invoice created successfully!')),
                      );
                    }
                  },
                  child: const Text('Create Invoice'),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomNavBar(
        currentIndex: 1,
        screens: [
          CustomerDashboardScreen(),
          InvoiceCreationScreen(),
          const PaymentProcessingScreen(),
          PaymentHistoryScreen(),
          const CustomerProfileScreen()
          
        ],
      ),
    );
    
  }

  Widget _buildItemRow(int index) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Expanded(
              child: TextFormField(
                decoration: const InputDecoration(labelText: 'Description'),
                onChanged: (value) =>
                    setState(() => _items[index]['description'] = value),
                validator: (value) =>
                    value!.isEmpty ? 'Please enter description' : null,
              ),
            ),
            const SizedBox(width: 8.0),
            SizedBox(
              width: 80,
              child: TextFormField(
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Quantity'),
                onChanged: (value) =>
                    setState(() => _items[index]['quantity'] = int.parse(value)),
                validator: (value) =>
                    value!.isEmpty ? 'Please enter quantity' : null,
              ),
            ),
            const SizedBox(width: 8.0),
            SizedBox(
              width: 80,
              child: TextFormField(
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Price'),
                onChanged: (value) =>
                    setState(() => _items[index]['price'] = double.parse(value)),
                validator: (value) =>
                    value!.isEmpty ? 'Please enter price' : null,
              ),
            ),
            IconButton(
              onPressed: () => _removeItem(index),
              icon: const Icon(Icons.delete),
            ),
          ],
        ),
      ),
    );
  }
}