import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation/core/models/student_model.dart';
import 'package:graduation/core/widgets/text_field.dart';
import 'package:graduation/views/health/logic/health_cubit.dart';
import 'package:graduation/views/health/logic/health_states.dart';

class HealthRecordScreen extends StatefulWidget {
  const HealthRecordScreen({super.key, this.studentModel});
  final StudentModel? studentModel;

  @override
  State<HealthRecordScreen> createState() => _HealthRecordScreenState();
}

class _HealthRecordScreenState extends State<HealthRecordScreen> {
  final TextEditingController _medicalController = TextEditingController();

  @override
  void dispose() {
    _medicalController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HealthCubit(),
      child: BlocConsumer<HealthCubit, HealthStates>(
        listener: (context, state) {},
        builder: (context, state) {
          final cubit = BlocProvider.of<HealthCubit>(context);
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.black),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              title: const Text(
                "Health Record",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              centerTitle: true,
            ),
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10),
                  BuildTextField(
                    label: "Medical Name",
                    controller: _medicalController,
                  ),
                  const Text(
                    "Upload your child's medical file",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "Please upload a PDF or an image of your child's medical file. This information will be securely stored and only accessible by you and authorized personnel.",
                    style: TextStyle(fontSize: 14, color: Colors.black54),
                  ),
                  const Spacer(),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: () {
                        cubit.addHealthRecord(
                          conditionName: _medicalController.text,
                          studentID: cubit.studentModel?.studentId,
                        );
                        log("save");
                      },
                      child: const Text(
                        "Save",
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
