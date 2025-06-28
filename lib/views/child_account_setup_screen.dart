import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation/core/widgets/text_field.dart';
import 'package:graduation/views/auth/logic/auth_cubit.dart';
import 'package:graduation/views/auth/logic/auth_states.dart';
import 'package:graduation/views/auth/ui/login_screen.dart';

class ChildAccountSetupScreen extends StatefulWidget {
  const ChildAccountSetupScreen({super.key, required this.userType});
  final String userType;

  @override
  State<ChildAccountSetupScreen> createState() =>
      _ChildAccountSetupScreenState();
}

class _ChildAccountSetupScreenState extends State<ChildAccountSetupScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController studentCodeController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    ageController.dispose();
    studentCodeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(),
      child: BlocConsumer<AuthCubit, AuthStates>(
        listener: (context, state) {
          if (state is ChildAccountSetupSuccessState) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => LoginScreen(userType: widget.userType),
              ),
            );
          }
          if (state is ChildAccountSetupErrorState) {
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
              backgroundColor: Colors.white,
              elevation: 0,
              foregroundColor: Colors.black,
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 10),
                      const Text(
                        "Set up your child's account",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 20),
                      BuildTextField(
                        label: " Name",
                        controller: nameController,
                      ),
                      BuildTextField(
                        label: "Email",
                        controller: emailController,
                      ),
                      BuildTextField(label: "Age", controller: ageController),
                      BuildTextField(
                        label: "Student Code",
                        controller: studentCodeController,
                      ),
                      const SizedBox(height: 20),
                      state is ChildAccountSetupLoadingState
                          ? Center(child: const CircularProgressIndicator())
                          : SizedBox(
                              width: MediaQuery.sizeOf(context).width,
                              height: 50,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.blue,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 16,
                                  ),
                                ),
                                onPressed: () async {
                                  if (_formKey.currentState!.validate()) {
                                    context.read<AuthCubit>().childAccountSetup(
                                      name: nameController.text,
                                      email: emailController.text,
                                      age: ageController.text,
                                      studentCode: studentCodeController.text,
                                    );
                                    await context
                                        .read<AuthCubit>()
                                        .addChildData(
                                          name: nameController.text,
                                          email: emailController.text,
                                          studentCode:
                                              studentCodeController.text,
                                          age: ageController.text,
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
            ),
          );
        },
      ),
    );
  }
}
