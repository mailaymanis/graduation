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
}
