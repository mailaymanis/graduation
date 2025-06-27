import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation/core/models/product_model.dart';
import 'package:graduation/home/logic/home_states.dart';

class HomeCubit extends Cubit<HomeStates> {
  HomeCubit() : super(HomeInitialState());
  //create get products function
  List<ProductModel> products = [];
  void getProducts() async {
    emit(GetProductsloadingState());
  }
}
