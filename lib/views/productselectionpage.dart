// ignore_for_file: file_names, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProductSelectionPage extends StatefulWidget {
  const ProductSelectionPage({super.key});

  @override
  _ProductSelectionPageState createState() => _ProductSelectionPageState();
}

class _ProductSelectionPageState extends State<ProductSelectionPage> {
  Map<String, bool> products = {
    "Molto": false,
    "KitKat": false,
    "Oreo": false,
    "Lays": false,
    "Snickers": false,
    "Twix": false,
    "Bounty": false,
    "Galaxy": false,
    "Mars": false,
    "Pepsi": false,
    "Coca-Cola": false,
    "Sprite": false,
    "7Up": false,
    "Doritos": false,
    "Pringles": false,
  };

  bool _isDataModified = false;
  bool _selectAll = false;

  @override
  void initState() {
    super.initState();
    _loadSavedProducts();
  }

  Future<void> _saveProducts() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> notAllowedProducts = products.entries
        .where((entry) => entry.value)
        .map((entry) => entry.key)
        .toList();
    await prefs.setStringList('restricted_products', notAllowedProducts);
    if (mounted) {
      setState(() {
        _isDataModified = false;
      });
    }
  }

  Future<void> _loadSavedProducts() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? savedProducts = prefs.getStringList('restricted_products');
    if (savedProducts != null && mounted) {
      setState(() {
        for (var product in products.keys) {
          products[product] = savedProducts.contains(product);
        }
        _selectAll = products.values.every((selected) => selected);
        _isDataModified = false;
      });
    }
  }

  void _toggleSelectAll() {
    setState(() {
      _selectAll = !_selectAll;
      products.updateAll((key, value) => _selectAll);
      _isDataModified = true;
    });
  }

  Future<bool> _onWillPop() async {
    if (_isDataModified) {
      return (await showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Unsaved Changes'),
              content: const Text(
                'You have unsaved changes. Do you want to save before exiting?',
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    if (context.mounted) {
                      Navigator.of(context).pop(false);
                    }
                  },
                  child: const Text('Cancel'),
                ),
                TextButton(
                  onPressed: () async {
                    await _saveProducts();
                    if (context.mounted) {
                      Navigator.of(context).pop(true);
                    }
                  },
                  child: const Text('Save & Exit'),
                ),
                TextButton(
                  onPressed: () {
                    if (context.mounted) {
                      Navigator.of(context).pop(true);
                    }
                  },
                  child: const Text('Exit without Saving'),
                ),
              ],
            ),
          )) ??
          false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () async {
            bool shouldPop = await _onWillPop();
            if (shouldPop && context.mounted) {
              Navigator.pop(context);
            }
          },
        ),
        backgroundColor: Colors.white,
        title: const Text("Products", style: TextStyle(color: Colors.black)),
        centerTitle: true,
      ),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Select products that are not allowed for your child:",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              children: products.keys.map((product) {
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 5),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                    side: const BorderSide(color: Colors.black),
                  ),
                  color: Colors.white,
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Checkbox(
                          value: products[product],
                          onChanged: (bool? value) {
                            setState(() {
                              products[product] = value ?? false;
                              _isDataModified = true;
                              _selectAll = products.values.every(
                                (selected) => selected,
                              );
                            });
                          },
                          activeColor: Colors.black,
                          checkColor: Colors.white,
                          materialTapTargetSize:
                              MaterialTapTargetSize.shrinkWrap,
                        ),
                      ),
                      Expanded(
                        child: Text(
                          product,
                          style: const TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: _toggleSelectAll,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey[800],
                      padding: const EdgeInsets.symmetric(vertical: 18),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      textStyle: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    child: Text(
                      _selectAll ? "Deselect All" : "Select All",
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(width: 16), // مسافة بين الزرين
                Expanded(
                  child: ElevatedButton(
                    onPressed: () async {
                      await _saveProducts();
                      if (context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              "Products saved successfully!",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      padding: const EdgeInsets.symmetric(vertical: 18),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      textStyle: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    child: const Text(
                      "Save Selection",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
