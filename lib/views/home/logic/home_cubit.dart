import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation/core/helper/api_services.dart';
import 'package:graduation/core/models/product_model.dart';
import 'package:graduation/views/home/logic/home_states.dart';

class HomeCubit extends Cubit<HomeStates> {
  HomeCubit() : super(HomeInitialState());

  //create instance from api services
  final ApiServices _apiServices = ApiServices();
  //create get products function
  List<ProductModel> products = [];
  void getProducts() async {
    emit(GetProductsloadingState());
    try {
      Response response = await _apiServices.getData(
        "products?select=*,parents(*)",
      );
      for (var product in response.data) {
        products.add(ProductModel.fromJson(product));
      }

      emit(GetProductsSuccessState());
    } catch (e) {
      log(e.toString());
      emit(GetProductsErrorState());
    }
  }

  //create get selected products function
  List<ProductModel> selectedProducts = [];
  Future<void> getSelectedProducts() async {
    emit(GetSelectedProductsloadingState());
    try {
      Response response = await _apiServices.getData("parents?select=*");
      for (var product in response.data) {
        selectedProducts.add(ProductModel.fromJson(product));
      }
      emit(GetSelectedProductsSuccessState());
    } catch (e) {
      log(e.toString());
      emit(GetSelectedProductsErrorState());
    }
  }
}
