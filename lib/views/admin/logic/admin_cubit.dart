import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation/core/models/student_model.dart';
import 'package:graduation/views/admin/logic/admin_states.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AdminCubit extends Cubit<AdminStates> {
  AdminCubit() : super(AdminInitialState());

  StudentModel? model;

  //create instance from supabase
  SupabaseClient client = Supabase.instance.client;

  //create record budget function
  void recordBudget({
    required String budget,
    required String statusCode,
  }) async {
    emit(BudgetLoadingState());
    try {
      await client
          .from("students")
          .upsert({"budget": budget, "student_code": statusCode})
          .eq("student_id", model?.studentId ?? "");
      log("budget added successfully");
      emit(BudgetSuccessState());
    } catch (e) {
      log(e.toString());
      emit(BudgetErrorState());
    }
  }
}
