import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BudgetSettingScreen extends StatefulWidget {
  const BudgetSettingScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _BudgetSettingScreenState createState() => _BudgetSettingScreenState();
}

class _BudgetSettingScreenState extends State<BudgetSettingScreen> {
  double budgetLimit = 50.0;
  final TextEditingController _budgetController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadBudget();
  }

  Future<void> _loadBudget() async {
    final prefs = await SharedPreferences.getInstance();
    if (mounted) {
      setState(() {
        budgetLimit = prefs.getDouble('budgetLimit') ?? 50.0;
        _budgetController.text = budgetLimit.toStringAsFixed(0);
      });
    }
  }

  Future<void> _saveBudget() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble('budgetLimit', budgetLimit);

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Budget set to ${budgetLimit.toStringAsFixed(0)} EGP"),
          duration: const Duration(seconds: 2),
        ),
      );

      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Set Budget", style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 30),
              const Text(
                "Set a daily spending limit for your child:",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 20),
              Slider(
                value: budgetLimit,
                min: 5,
                max: 100,
                divisions: 19,
                activeColor: Colors.black,
                inactiveColor: Colors.black26,
                label: budgetLimit.toStringAsFixed(0),
                onChanged: (value) {
                  setState(() {
                    budgetLimit = value;
                    _budgetController.text = budgetLimit.toStringAsFixed(0);
                  });
                },
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _budgetController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: "Enter Budget (5 - 100 EGP)",
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) {
                  final enteredValue = double.tryParse(value);
                  if (enteredValue != null &&
                      enteredValue >= 5 &&
                      enteredValue <= 100) {
                    setState(() {
                      budgetLimit = enteredValue;
                    });
                  }
                },
              ),
              const SizedBox(height: 40),
              ElevatedButton(
                onPressed: _saveBudget,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 30,
                    vertical: 15,
                  ),
                  backgroundColor: Colors.black,
                  foregroundColor: Colors.white,
                ),
                child: const Text(
                  "Save Budget",
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
