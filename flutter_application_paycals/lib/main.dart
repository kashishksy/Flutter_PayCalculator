import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

//main MyApp that builds the PayCalculatorScreen
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: PayCalculatorScreen(),
    );
  }
}

//pay calculator screen that creates a paycalculatorscreenstate instance
class PayCalculatorScreen extends StatefulWidget {
  @override
  _PayCalculatorScreenState createState() => _PayCalculatorScreenState();
}

//pay calculator screen state that creates the UI for the pay calculator
class _PayCalculatorScreenState extends State<PayCalculatorScreen> {
  // Controllers to get user input
  final TextEditingController _hoursController = TextEditingController();
  final TextEditingController _rateController = TextEditingController();

  // Variables to store calculated values
  double _regularPay = 0.0;
  double _overtimePay = 0.0;
  double _totalPay = 0.0;
  double _tax = 0.0;

  // Method to calculate pay and tax
  void _calculatePay() {
    final double hours = double.tryParse(_hoursController.text) ?? 0.0;
    final double rate = double.tryParse(_rateController.text) ?? 0.0;

    setState(() {
      if (hours <= 40) {
        _regularPay = hours * rate;
        _overtimePay = 0.0;
      } else {
        _regularPay = 40 * rate;
        _overtimePay = (hours - 40) * rate * 1.5;
      }

      _totalPay = _regularPay + _overtimePay;
      _tax = _totalPay * 0.18;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pay Calculator'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Top part of the UI
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: _hoursController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(labelText: 'Number of hours worked'),
                ),
                TextField(
                  controller: _rateController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(labelText: 'Hourly rate'),
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: _calculatePay,
                  child: Text('Calculate'),
                ),
                SizedBox(height: 16),
                Text('Regular Pay: \$${_regularPay.toStringAsFixed(2)}'),
                Text('Overtime Pay: \$${_overtimePay.toStringAsFixed(2)}'),
                Text('Total Pay (Before Tax): \$${_totalPay.toStringAsFixed(2)}'),
                Text('Tax: \$${_tax.toStringAsFixed(2)}'),
              ],
            ),

            // Bottom part of the UI displaing student information
            Text(
              'Name: Kashish Pramod Yadav\nStudent ID: 301485842',
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}