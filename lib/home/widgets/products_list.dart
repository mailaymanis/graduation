import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation/core/models/product_model.dart';
import 'package:graduation/home/logic/home_cubit.dart';
import 'package:graduation/home/logic/home_states.dart';
import 'package:graduation/home/widgets/product_card.dart';

class ProductsList extends StatelessWidget {
  const ProductsList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit()..getProducts(),
      child: BlocConsumer<HomeCubit, HomeStates>(
        listener: (context, state) {},
        builder: (context, state) {
          List<ProductModel> products = BlocProvider.of<HomeCubit>(
            context,
          ).products;
          return state is GetProductsloadingState
              ? Center(child: CircularProgressIndicator())
              : ListView.separated(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: products.length,
                  separatorBuilder: (context, index) {
                    return SizedBox(height: 25);
                  },
                  itemBuilder: (context, index) {
                    return ProductCard(product: products[index]);
                  },
                );
        },
      ),
    );
  }
}
