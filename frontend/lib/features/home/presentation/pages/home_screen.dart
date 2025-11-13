import 'package:cosmetics_store/core/api/api_client.dart';
import 'package:cosmetics_store/core/widgets/products/product_card.dart';
import 'package:cosmetics_store/core/widgets/slider/image_slider.dart';
import 'package:cosmetics_store/core/widgets/slider/promotion_entity.dart';
import 'package:cosmetics_store/features/home/presentation/product_bloc/product_bloc_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              ProductBloc(MockApiClient())..add(LoadProductsEvent()),
        ),
      ],
      child: Scaffold(body: HomeContent()),
    );
  }
}

class HomeContent extends StatelessWidget {
  const HomeContent({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [_buildBannerSection(context), _buildProductSection(context)],
      ),
    );
  }

  Widget _buildProductSection(BuildContext context) {
    return BlocBuilder<ProductBloc, ProductState>(
      builder: (context, state) {
        if (state is ProductLoadingState) {
          return Center(child: CircularProgressIndicator());
        }

        if (state is ProductLoadedState) {
          return SizedBox(
            height: 278.466796875,
            child: ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 15),
              scrollDirection: Axis.horizontal,
              itemCount: state.products.length,
              itemBuilder: (context, index) {
                return ProductCard(
                  product: state.products[index],
                  onTap: () {},
                );
              },
            ),
          );
        }
        return Center(child: Text('Ошибка загрузки'));
      },
    );
  }

  Widget _buildBannerSection(BuildContext context) {
    return ImageSlider(
      promotions: [
        Promotion(
          image: 'assets/images/sale1.png',
          mainText: 'СКИДКА -15%',
          promotionText: 'Для вас и еще вас',
        ),
        Promotion(
          image: 'assets/images/sale2.png',
          mainText: 'СКИДКА -23%',
          promotionText: 'Для вас и еще вас и много вас крч',
        ),
      ],
    );
  }
}
