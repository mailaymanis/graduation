import 'dart:developer';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation/core/models/student_model.dart';
import 'package:graduation/views/health/logic/health_states.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class HealthCubit extends Cubit<HealthStates> {
  HealthCubit() : super(HealthInitialState());

  //create instance from supabase
  SupabaseClient client = Supabase.instance.client;

  StudentModel? studentModel;
  //create health record function
  Future<void> addHealthRecord({
    required String conditionName,
    required dynamic studentID,
  }) async {
    emit(HealthRecordSLoadingtate());
    try {
      await client.from("medical_conditions").insert({
        "condition_name": conditionName,
        "for_student": studentID,
      });
      log("medical name added successfully");
      emit(HealthRecordSuccessState());
    } catch (e) {
      log(e.toString());
      emit(HealthRecordErrorState());
    }
  }
}
