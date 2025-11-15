// test/features/home_page/banner_test.dart
import 'package:bloc_test/bloc_test.dart';
import 'package:cosmetics_store/core/api/api_client.dart';
import 'package:cosmetics_store/core/widgets/products/product_entity.dart';
import 'package:cosmetics_store/core/widgets/slider/promotion_entity.dart';
import 'package:cosmetics_store/features/home/presentation/banner_bloc/banner_bloc.dart';
import 'package:cosmetics_store/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

class ErrorMockApiClient implements ApiClient {
  @override
  Future<List<Promotion>> getBanners() async {
    throw Exception('Failed to load banners');
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
  Future<List<Product>> getProducts() async {
    throw UnimplementedError();
  }

  @override
  Future<List<Product>> getSliderProducts() async {
    throw UnimplementedError();
  }
}

void main() {
  group('BannerBloc', () {
    late TestMockApiClient mockApiClient;
    late BannerBloc bannerBloc;

    setUp(() {
      mockApiClient = TestMockApiClient();
      bannerBloc = BannerBloc(mockApiClient);
    });

    tearDown(() {
      bannerBloc.close();
    });

    // Тест 1: Успешная загрузка баннеров
    blocTest<BannerBloc, BannerState>(
      'should emit [loading, loaded] when banners are loaded successfully',
      build: () => bannerBloc,
      act: (bloc) => bloc.add(LoadBannerEvent()),
      expect: () => [isA<BannerLoadingState>(), isA<BannerLoadedState>()],
      verify: (bloc) {
        final state = bloc.state;
        expect(state, isA<BannerLoadedState>());
        if (state is BannerLoadedState) {
          expect(state.banners, isNotEmpty);
        }
      },
    );

    // Тест 2: Ошибка при загрузке баннеров
    blocTest<BannerBloc, BannerState>(
      'should emit [loading, error] when banners loading fails',
      build: () => BannerBloc(ErrorMockApiClient()),
      act: (bloc) => bloc.add(LoadBannerEvent()),
      expect: () => [isA<BannerLoadingState>(), isA<BannerErrorState>()],
      verify: (bloc) {
        final state = bloc.state;
        expect(state, isA<BannerErrorState>());
        if (state is BannerErrorState) {
          expect(state.error, isNotEmpty);
        }
      },
    );
  });
}
