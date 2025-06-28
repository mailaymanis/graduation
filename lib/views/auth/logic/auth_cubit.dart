import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation/views/auth/logic/auth_states.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthCubit extends Cubit<AuthStates> {
  AuthCubit() : super(AuthInitialState());

  //create instance from supabase
  SupabaseClient client = Supabase.instance.client;

  //create regsiter function
  void register({
    required String name,
    required String email,
    required String phone,
    required String password,
  }) async {
    emit(RegisterLoadingState());
    try {
      await client.auth.signUp(email: email, password: password);
      log("user registered successfully");
      await addParentData(
        name: name,
        email: email,
        phone: phone,
        password: password,
      );
      emit(RegisterSuccessState());
    } catch (e) {
      log(e.toString());
      emit(RegisterErrorState(message: e.toString()));
    }
  }

  //create login function
  void login({required String email, required String password}) async {
    emit(LoginLoadingState());
    try {
      await client.auth.signInWithPassword(email: email, password: password);
      log("user logged in successfully");
      emit(LoginSuccessState());
    } catch (e) {
      log(e.toString());
      emit(LoginErrorState(message: e.toString()));
    }
  }

  //create child account setup function
  void childAccountSetup({
    required String name,
    required String email,
    required String age,
    required String studentCode,
  }) async {
    emit(ChildAccountSetupLoadingState());
    try {
      await client.auth.signUp(email: email, password: studentCode);
      log("child account setup successfully");
      emit(ChildAccountSetupSuccessState());
    } catch (e) {
      log(e.toString());
      emit(ChildAccountSetupErrorState(message: e.toString()));
    }
  }

  //create method to add parent data
  Future<void> addParentData({
    required String name,
    required String email,
    required String phone,
    required String password,
  }) async {
    emit(AddParentDataLoadingState());
    try {
      await client.from("parents").insert({
        "parent_id": client.auth.currentUser!.id,
        "name": name,
        "email": email,
        "phone": phone,
        "password": password,
      });
      log("user data added successfully");
      emit(AddParentDataSuccessState());
    } catch (e) {
      log(e.toString());
      emit(AddParentDataErrorState(message: e.toString()));
    }
  }

  //create method to add child data
  Future<void> addChildData({
    required String name,
    required String email,
    required String studentCode,
    required String age,
  }) async {
    emit(AddChildDataLoadingState());
    try {
      await client.from("students").insert({
        "student_id": client.auth.currentUser!.id,
        "name": name,
        "email": email,
        "student_code": studentCode,
        "age": age,
      });
      log("user data added successfully");
      emit(AddChildDataSuccessState());
    } catch (e) {
      log(e.toString());
      emit(AddChildDataErrorState(message: e.toString()));
    }
  }
}
