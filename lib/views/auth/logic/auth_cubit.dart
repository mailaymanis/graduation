import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation/views/auth/logic/auth_states.dart';

class AuthCubit extends Cubit<AuthStates> {
  AuthCubit() : super(AuthInitialState());

  //create instance of dio
  final Dio _dio = Dio();
  //create regsiter function
  void register({
    required String name,
    required String email,
    required String phone,
    required String password,
  }) async {
    emit(RegisterLoadingState());
    Response response = await _dio.post(
      "",
      data: {
        "name": name,
        "email": email,
        "phone": phone,
        "password": password,
      },
    );
    try {
      if (response.statusCode == 200) {
        var jsonDecoded = jsonDecode(response.data);
        log("user regsiter successfully and his id is $jsonDecoded");
        emit(RegisterSuccessState());
      } else {
        log("user regsiter failed");
        emit(RegisterErrorState(message: "user regsiter failed"));
      }
    } catch (e) {
      log(e.toString());
      emit(RegisterErrorState(message: e.toString()));
    }
  }
}
