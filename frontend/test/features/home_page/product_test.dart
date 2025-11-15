// test/features/home_page/product_test.dart
import 'package:bloc_test/bloc_test.dart';
import 'package:cosmetics_store/core/api/api_client.dart';
import 'package:cosmetics_store/core/widgets/products/product_entity.dart';
import 'package:cosmetics_store/core/widgets/slider/promotion_entity.dart';
import 'package:cosmetics_store/features/home/presentation/product_bloc/product_bloc_bloc.dart';
import 'package:cosmetics_store/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

class ErrorMockApiClient implements ApiClient {
  @override
  Future<List<Product>> getProducts() async {
    throw Exception('Failed to load products');
  }

  @override
  Future<User> getProfile() async {
    throw UnimplementedError();
  }

  @override
  Future<User> updateProfile(User user) async {
    throw UnimplementedError();
  }

  @override
  Future<List<Product>> getSliderProducts() async {
    throw UnimplementedError();
  }

  @override
  Future<List<Promotion>> getBanners() async {
    throw UnimplementedError();
  }
}

void main() {
  group('ProductBloc', () {
    late TestMockApiClient mockApiClient;
    late ProductBloc productBloc;

    setUp(() {
      mockApiClient = TestMockApiClient();
      productBloc = ProductBloc(mockApiClient);
    });

    tearDown(() {
      productBloc.close();
    });

    // Тест 1: Успешная загрузка продуктов
    blocTest<ProductBloc, ProductState>(
      'should emit [loading, loaded] when products are loaded successfully',
      build: () => productBloc,
      act: (bloc) => bloc.add(LoadProductsEvent()),
      expect: () => [isA<ProductLoadingState>(), isA<ProductLoadedState>()],
      verify: (bloc) {
        final state = bloc.state;
        expect(state, isA<ProductLoadedState>());
        if (state is ProductLoadedState) {
          expect(state.products, isNotEmpty);
        }
      },
    );

    // Тест 2: Ошибка при загрузке продуктов
    blocTest<ProductBloc, ProductState>(
      'should emit [loading, error] when products loading fails',
      build: () => ProductBloc(ErrorMockApiClient()),
      act: (bloc) => bloc.add(LoadProductsEvent()),
      expect: () => [isA<ProductLoadingState>(), isA<ProductErrorState>()],
      verify: (bloc) {
        final state = bloc.state;
        expect(state, isA<ProductErrorState>());
        if (state is ProductErrorState) {
          expect(state.error, isNotEmpty);
        }
      },
    );
  });
}
