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
  Future<List<Product>> getNewProducts() async {
    throw Exception('Failed to load products');
  }

  @override
  Future<List<Product>> getSaleProducts() async {
    throw Exception('Failed to load sale products');
  }

  @override
  Future<List<Product>> getHitProducts() async {
    throw Exception('Failed to load hit products');
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

    // Тест 1: Успешная загрузка всех продуктов
    blocTest<ProductBloc, ProductState>(
      'should emit [loading, loaded] when all products are loaded successfully',
      build: () => productBloc,
      act: (bloc) => bloc.add(LoadAllProductsEvent()),
      expect: () => [isA<ProductLoadingState>(), isA<ProductLoadedState>()],
      verify: (bloc) {
        final state = bloc.state;
        expect(state, isA<ProductLoadedState>());
        if (state is ProductLoadedState) {
          expect(state.newProducts, isNotEmpty);
          expect(state.saleProducts, isNotEmpty);
          expect(state.hitProducts, isNotEmpty);
        }
      },
    );

    // Тест 2: Ошибка при загрузке всех продуктов
    blocTest<ProductBloc, ProductState>(
      'should emit [loading, error] when products loading fails',
      build: () => ProductBloc(ErrorMockApiClient()),
      act: (bloc) => bloc.add(LoadAllProductsEvent()),
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
