import 'package:cosmetics_store/core/api/api_client.dart';
import 'package:cosmetics_store/core/widgets/products/product_card.dart';
import 'package:cosmetics_store/features/home/presentation/product_bloc/product_bloc_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          ProductBloc(MockApiClient())..add(LoadProductsEvent()),
      child: Scaffold(
        appBar: AppBar(title: Text('Главная')),
        body: BlocBuilder<ProductBloc, ProductState>(
          builder: (context, state) {
            if (state is ProductLoadingState) {
              return Center(child: CircularProgressIndicator());
            }

            if (state is ProductLoadedState) {
              return ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: state.products.length,
                itemBuilder: (context, index) {
                  return ProductCard(
                    product: state.products[index],
                    onTap: () {},
                  );
                },
              );
            }

            return Center(child: Text('Ошибка загрузки'));
          },
        ),
      ),
    );
  }
}
