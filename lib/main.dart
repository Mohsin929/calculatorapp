import 'package:flutter/material.dart';

void main() {
  runApp(const CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  const CalculatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Calculator App',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const CalculatorScreen(),
    );
  }
}

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String _displayText = '';
  String _operand1 = '';
  String _operand2 = '';
  String _operator = '';

  void _onButtonPressed(String value) {
    setState(() {
      if (value == 'C') {
        // Clear all values
        _displayText = '';
        _operand1 = '';
        _operand2 = '';
        _operator = '';
      } else if (value == '+' || value == '-' || value == '*' || value == '/') {
        // Assign operator
        if (_operand1.isNotEmpty && _operator.isEmpty) {
          _operator = value;
          _displayText += value;
        }
      } else if (value == '=') {
        // Perform calculation
        if (_operand1.isNotEmpty && _operator.isNotEmpty && _operand2.isNotEmpty) {
          int num1 = int.parse(_operand1);
          int num2 = int.parse(_operand2);
          int result = 0;

          if (_operator == '+') {
            result = num1 + num2;
          } else if (_operator == '-') {
            result = num1 - num2;
          } else if (_operator == '*') {
            result = num1 * num2;
          } else if (_operator == '/') {
            if (num2 == 0) {
              _displayText = "Error"; // Handle division by zero
              _operand1 = '';
              _operand2 = '';
              _operator = '';
              return;
            } else {
              result = num1 ~/ num2; // Integer division
            }
          }

          _displayText = result.toString();
          _operand1 = _displayText;
          _operand2 = '';
          _operator = '';
        }
      } else {
        // Handle number input
        if (_operator.isEmpty) {
          _operand1 += value;
        } else {
          _operand2 += value;
        }
        _displayText += value;
      }
    });
  }

  Widget _buildButton(String text, {Color? color}) {
    return ElevatedButton(
      onPressed: () => _onButtonPressed(text),
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.all(20),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        backgroundColor: color ?? Colors.blue,
      ),
      child: Text(
        text,
        style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        title: const Text("Calculator"),
        backgroundColor: Colors.blueAccent,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            alignment: Alignment.centerRight,
            child: Text(
              _displayText,
              style: const TextStyle(fontSize: 48, color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: GridView.count(
              crossAxisCount: 4,
              padding: const EdgeInsets.all(16),
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              children: [
                _buildButton("7"),
                _buildButton("8"),
                _buildButton("9"),
                _buildButton("/", color: Colors.orange),
                _buildButton("4"),
                _buildButton("5"),
                _buildButton("6"),
                _buildButton("*", color: Colors.orange),
                _buildButton("1"),
                _buildButton("2"),
                _buildButton("3"),
                _buildButton("-", color: Colors.orange),
                _buildButton("0"),
                _buildButton("=", color: Colors.green),
                _buildButton("+", color: Colors.orange),
                _buildButton("C", color: Colors.red),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
