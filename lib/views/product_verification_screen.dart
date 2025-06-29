import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'welcome_screen.dart';

class ProductVerificationScreen extends StatefulWidget {
  const ProductVerificationScreen({super.key});

  @override
  State<ProductVerificationScreen> createState() =>
      _ProductVerificationScreenState();
}

class _ProductVerificationScreenState extends State<ProductVerificationScreen> {
  final TextEditingController _childIdController = TextEditingController();
  final TextEditingController _productNameController = TextEditingController();
  final Logger _logger = Logger(); // إضافة Logger

  String _feedbackMessage = "";

  Color _feedbackColor = Colors.transparent;

  IconData _feedbackIcon = Icons.info_outline;
  Map<String, bool> _allProducts = {};

  @override
  void initState() {
    super.initState();
    _loadProducts();
  }

  @override
  void dispose() {
    _childIdController.dispose();
    _productNameController.dispose();
    super.dispose();
  }

  Future<void> _loadProducts() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? restrictedProducts = prefs.getStringList(
      'restricted_products',
    );

    setState(() {
      _allProducts = {
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

      restrictedProducts?.forEach((product) {
        _allProducts[product] = true;
      });
    });

    _logger.i("Loaded products: $_allProducts"); // استخدام Logger بدل print
  }

  Future<bool> _studentCodeExists(String studentCode) async {
    final response = await Supabase.instance.client
        .from('students')
        .select('student_code')
        .eq('student_code', studentCode)
        .maybeSingle();

    return response != null;
  }

  void _checkPermission() async {
    String studentCode = _childIdController.text.trim();
    String productName = _productNameController.text.trim();

    if (productName.isEmpty) {
      _updateFeedback("Please enter a product name.", Colors.red, Icons.cancel);
      return;
    }

    if (!_allProducts.keys
        .map((p) => p.toLowerCase())
        .contains(productName.toLowerCase())) {
      _updateFeedback(
        "Please enter a valid product name.",
        Colors.orange,
        Icons.warning,
      );
      return;
    }

    bool isRestricted = _allProducts.entries
        .where((entry) => entry.key.toLowerCase() == productName.toLowerCase())
        .first
        .value;

    _logger.d(
      "Checking permission for $productName (restricted: $isRestricted)",
    );

    if (isRestricted) {
      _updateFeedback("The product is not allowed.", Colors.red, Icons.cancel);
    } else {
      _updateFeedback(
        "The product is allowed.",
        Colors.green,
        Icons.check_circle,
      );
    }

    //check student permision
    if (studentCode.isEmpty) {
      _updateFeedback("Please enter a student code.", Colors.red, Icons.cancel);
      return;
    }

    bool exists = await _studentCodeExists(studentCode);
    if (exists) {
      _updateFeedback("Student code exists.", Colors.green, Icons.check);
      return;
    }
    if (!exists) {
      _updateFeedback("Student code does not exist.", Colors.red, Icons.cancel);
      return;
    }

    // ... continue with product check logic ...
  }

  // void _checkProductPermission() {
  //   String childId = _childIdController.text.trim();

  //   if (childId.length != 6 || !RegExp(r'^\d{6}$').hasMatch(childId)) {
  //     _updateFeedback(
  //       "Please enter a valid 6-digit child ID.",
  //       Colors.red,
  //       Icons.cancel,
  //     );
  //     return;
  //   }
  // }

  void _updateFeedback(String message, Color color, IconData icon) {
    if (message != _feedbackMessage) {
      setState(() {
        _feedbackMessage = message;
        _feedbackColor = color;
        _feedbackIcon = icon;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        title: const Text(
          'Product Verification',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        elevation: 0,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            const Text("Student Code"),
            const SizedBox(height: 5),
            TextField(
              controller: _childIdController,
              decoration: _buildInputDecoration("Enter Child ID (6 digits)"),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 15),
            const Text("Product Name"),
            const SizedBox(height: 5),
            TextField(
              controller: _productNameController,
              decoration: _buildInputDecoration("Enter Product Name"),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: _checkPermission,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  "Check Permission",
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ),
            const SizedBox(height: 20),
            AnimatedOpacity(
              duration: const Duration(milliseconds: 300),
              opacity: _feedbackMessage.isNotEmpty ? 1.0 : 0.0,
              child: Row(
                children: [
                  Icon(_feedbackIcon, color: _feedbackColor, size: 28),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      _feedbackMessage,
                      style: TextStyle(color: _feedbackColor, fontSize: 16),
                    ),
                  ),
                ],
              ),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const WelcomeScreen(),
                      ),
                    );
                  },
                  icon: const Icon(Icons.logout),
                  label: const Text("Log Out"),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  InputDecoration _buildInputDecoration(String hintText) {
    return InputDecoration(
      hintText: hintText,
      filled: true,
      fillColor: Colors.grey[200],
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide.none,
      ),
    );
  }
}
