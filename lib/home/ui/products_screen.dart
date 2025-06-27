import 'package:flutter/material.dart';
import 'package:graduation/home/widgets/products_list.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              centerTitle: true,
              backgroundColor: Colors.white,
              elevation: 0,
              scrolledUnderElevation: 0,
              forceMaterialTransparency: true,
              floating: false,
              snap: false,
              title: const Text(
                "Products",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SliverPadding(
              padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.sizeOf(context).width * 0.05,
              ),
              sliver: SliverToBoxAdapter(
                child: SizedBox(
                  width: MediaQuery.sizeOf(context).width,
                  child: ProductsList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
