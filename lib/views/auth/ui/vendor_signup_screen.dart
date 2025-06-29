// ignore_for_file: library_private_types_in_public_api
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation/views/auth/logic/auth_cubit.dart';
import 'package:graduation/views/auth/logic/auth_states.dart';
import 'package:graduation/views/auth/ui/vendor_login_screen.dart';

class VendorSignupScreen extends StatefulWidget {
  final String userType;

  const VendorSignupScreen({super.key, required this.userType});

  @override
  _VendorSignupScreenState createState() => _VendorSignupScreenState();
}

class _VendorSignupScreenState extends State<VendorSignupScreen> {
  bool _isPasswordVisible = false;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(),
      child: BlocConsumer<AuthCubit, AuthStates>(
        listener: (context, state) {
          if (state is VendorRegisterSuccessState) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    VendorLoginScreen(userType: widget.userType),
              ),
            );
          }
          if (state is VendorLoginErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        builder: (context, state) {
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              title: const Text(
                "Sign Up",
                style: TextStyle(fontSize: 24, color: Colors.black),
              ),
              elevation: 0,
              backgroundColor: Colors.white,
              foregroundColor: Colors.black,
              titleSpacing: 0,
              centerTitle: true,
            ),
            body: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
                    Center(
                      child: Column(
                        children: [
                          Text(
                            "Create an account. It's quick and easy",
                            style: Theme.of(context).textTheme.bodyLarge
                                ?.copyWith(fontWeight: FontWeight.w600),
                            textAlign: TextAlign.start,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                    const Text("Full name"),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                    TextFormField(
                      decoration: _inputDecoration("Enter your full name"),
                      controller: _nameController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter your name";
                        }
                        if (!RegExp(
                          r'^[A-Za-z][A-Za-z0-9@!#$%^&*()_+=-]*$',
                        ).hasMatch(value)) {
                          return "Name must start with a letter";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 15),
                    const Text("Email"),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                    TextFormField(
                      decoration: _inputDecoration("Enter your email"),
                      keyboardType: TextInputType.emailAddress,
                      controller: _emailController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter your email";
                        } else if (!RegExp(
                          r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
                        ).hasMatch(value)) {
                          return "Invalid email format";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 15),
                    const Text("Phone"),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                    TextFormField(
                      decoration: _inputDecoration("Enter your phone number"),
                      keyboardType: TextInputType.phone,
                      controller: _phoneController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter your phone number";
                        } else if (!RegExp(r'^\d+$').hasMatch(value)) {
                          return "Phone number must contain only numbers";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 15),
                    const Text("Password"),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                    TextFormField(
                      decoration: _inputDecoration("Enter your password")
                          .copyWith(
                            suffixIcon: IconButton(
                              icon: Icon(
                                _isPasswordVisible
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                              ),
                              onPressed: () {
                                setState(() {
                                  _isPasswordVisible = !_isPasswordVisible;
                                });
                              },
                            ),
                          ),
                      obscureText: !_isPasswordVisible,
                      controller: _passwordController,
                      validator: (value) {
                        if (value == null || value.length < 6) {
                          return "Password must be at least 6 characters";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 15),
                    const Text(
                      "By continuing, you agree to the Terms of Use and acknowledge that you have read our Privacy Policy.",
                      style: TextStyle(color: Colors.grey),
                    ),
                    const SizedBox(height: 20),
                    state is VendorLoginLoadingState
                        ? Center(child: const CircularProgressIndicator())
                        : SizedBox(
                            width: double.infinity,
                            height: 50,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blue,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  BlocProvider.of<AuthCubit>(
                                    context,
                                  ).vendorRegister(
                                    name: _nameController.text,
                                    email: _emailController.text,
                                    phone: _phoneController.text,
                                    password: _passwordController.text,
                                  );
                                }
                              },
                              child: const Text(
                                "Next Step",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  InputDecoration _inputDecoration(String hintText) {
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
