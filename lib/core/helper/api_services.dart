import 'package:dio/dio.dart';
import 'package:graduation/core/helper/supabase_keys.dart';

class ApiServices {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: "https://djayyjzldfygpkrxkvcq.supabase.co/rest/v1/",
      headers: {"apikey": SupabaseKeys.anonKey},
    ),
  );

  //create get service
  Future<Response> getData(String path) async {
    return await _dio.get(path);
  }

  //create post service
  Future<Response> postData(String path, Map<String, dynamic> data) async {
    return await _dio.post(path, data: data);
  }

  //create patch service
  Future<Response> patchData(String path, Map<String, dynamic> data) async {
    return await _dio.patch(path, data: data);
  }

  //create delete service
  Future<Response> deleteData(String path) async {
    return await _dio.delete(path);
  }
}
