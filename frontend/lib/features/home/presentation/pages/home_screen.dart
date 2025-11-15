import 'package:cosmetics_store/core/api/api_client.dart';
import 'package:cosmetics_store/core/widgets/products/product_card.dart';
import 'package:cosmetics_store/core/widgets/slider/image_slider.dart';
import 'package:cosmetics_store/features/home/presentation/banner_bloc/banner_bloc.dart';
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
              ProductBloc(MockApiClient())..add(LoadAllProductsEvent()),
        ),
        BlocProvider(
          create: (context) =>
              BannerBloc(MockApiClient())..add(LoadBannerEvent()),
        ),
      ],
      child: Scaffold(backgroundColor: Colors.white, body: HomeContent()),
    );
  }
}

class HomeContent extends StatelessWidget {
  const HomeContent({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildBannerSection(context),
          SizedBox(height: 152),
          _headerSection('Новинки', Color(0xFFE4FEF9), Color(0xFF66F6DC)),
          SizedBox(height: 24),
          _buildNewProductSection(context),
          _headerSection('Акции', Color(0xFFFFC0E1), Color(0xFFF02980)),
          SizedBox(height: 24),
          _buildSaleProductSection(context),
          _headerSection('Хиты', Color(0xFFFCBC5C), Color(0xFFF86614)),
          SizedBox(height: 24),
          _buildHitProductSection(context),
          SizedBox(height: 51),
        ],
      ),
    );
  }

  Widget _buildNewProductSection(BuildContext context) {
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
              itemCount: state.newProducts.length,
              itemBuilder: (context, index) {
                return ProductCard(
                  product: state.newProducts[index],
                  onTap: () {},
                );
              },
            ),
          );
        }
        if (state is ProductErrorState) {
          return Center(child: Text('Ошибка загрузки'));
        }
        return SizedBox.shrink();
      },
    );
  }

  Widget _buildSaleProductSection(BuildContext context) {
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
              itemCount: state.saleProducts.length,
              itemBuilder: (context, index) {
                return Stack(
                  clipBehavior: Clip.none,
                  children: [
                    ProductCard(
                      product: state.saleProducts[index],
                      onTap: () {},
                    ),
                    Positioned(
                      top: 8,
                      right: 8.01,
                      child: Stack(
                        children: [
                          Image.asset(
                            'assets/images/Star1.png',
                            width: 25,
                            height: 25,
                          ),
                          Positioned(
                            top: 5.5,
                            left: 7.5,
                            child: Text(
                              '%',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 11,
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
          );
        }
        if (state is ProductErrorState) {
          return Center(child: Text('Ошибка загрузки'));
        }
        return SizedBox.shrink();
      },
    );
  }

  Widget _buildHitProductSection(BuildContext context) {
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
              itemCount: state.hitProducts.length,
              itemBuilder: (context, index) {
                return ProductCard(
                  product: state.hitProducts[index],
                  onTap: () {},
                );
              },
            ),
          );
        }
        if (state is ProductErrorState) {
          return Center(child: Text('Ошибка загрузки'));
        }
        return SizedBox.shrink();
      },
    );
  }

  Widget _buildBannerSection(BuildContext context) {
    return BlocBuilder<BannerBloc, BannerState>(
      builder: (context, state) {
        if (state is BannerLoadingState) {
          return Center(child: CircularProgressIndicator());
        }
        if (state is BannerLoadedState) {
          return ImageSlider(promotions: state.banners);
        }
        return Center(child: Text('Ошибка загрузки'));
      },
    );
  }

  Widget _headerSection(String title, Color oneColor, Color twoColor) {
    return Padding(
      padding: const EdgeInsets.only(left: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              fontFamily: 'Raleway',
            ),
          ),
          Container(
            height: 4,
            width: 118,
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: [oneColor, twoColor]),
            ),
          ),
        ],
      ),
    );
  }
}
