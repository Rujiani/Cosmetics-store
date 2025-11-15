import 'package:cosmetics_store/core/widgets/products/product_entity.dart';
import 'package:cosmetics_store/core/widgets/slider/promotion_entity.dart';
import 'package:cosmetics_store/features/profile/presentation/bloc/profile_bloc.dart';

abstract class ApiClient {
  Future<User> getProfile();
  Future<User> updateProfile(User user);
  Future<List<Product>> getProducts();
  Future<List<Product>> getSliderProducts();
  Future<List<Promotion>> getBanners();
}

class MockApiClient implements ApiClient {
  static User _currentUser = User(
    id: '1',
    name: 'Иван Иванов',
    email: 'ivan@example.com',
    phone: '+79991234567',
    avatarPic: 'assets/images/default_avatar.png',
  );

  @override
  Future<User> getProfile() async {
    await _simulateNetwork();
    return _currentUser;
  }

  @override
  Future<User> updateProfile(User user) async {
    await _simulateNetwork();

    if (user.name.isEmpty) {
      throw Exception('Name cannot be empty');
    }

    if (!user.email.contains('@')) {
      throw Exception('Invalid email format');
    }

    _currentUser = user;
    return _currentUser;
  }

  Future<void> _simulateNetwork([int seconds = 1]) async {
    await Future.delayed(Duration(seconds: seconds));
  }

  static void reset() {
    _currentUser = User(
      id: '1',
      name: 'Иван Иванов',
      email: 'ivan@example.com',
      phone: '+79991234567',
      avatarPic: 'assets/images/default_avatar.png',
    );
  }

  static final _mockProducts = [
    Product(
      id: '1',
      name: 'Увлажняющий крем для лица',
      price: 2499,
      description: 'Интенсивное увлажнение на 24 часа',
      images: ['assets/images/cream1.png'],
      category: 'Крем',
      inStock: true,
      rating: 4.8,
      reviewCount: 124,
    ),
    Product(
      id: '2',
      name: 'Тонирующее средство с SPF',
      price: 1899,
      description: 'Легкое покрытие с защитой от солнца',
      images: ['assets/images/foundation1.png'],
      category: 'Сыворотка',
      inStock: true,
      rating: 4.6,
      reviewCount: 89,
    ),
    Product(
      id: '3',
      name: 'Помада матовый эффект',
      price: 1299,
      description: 'Стойкая помада с матовым финишем',
      images: ['assets/images/lipstick1.png'],
      category: 'Тоник',
      inStock: false,
      rating: 4.9,
      reviewCount: 203,
    ),
  ];

  @override
  Future<List<Product>> getProducts() async {
    await _simulateNetwork();
    return _mockProducts;
  }

  @override
  Future<List<Product>> getSliderProducts() async {
    await _simulateNetwork();
    return _mockProducts.take(3).toList();
  }

  @override
  Future<List<Promotion>> getBanners() async {
    await _simulateNetwork();
    return _mockBanners;
  }

  static final _mockBanners = [
    Promotion(
      image: 'assets/images/sale1.png',
      mainText: 'СКИДКА -15%',
      promotionText: 'Для вас и еще вас',
    ),
    Promotion(
      image: 'assets/images/sale2.png',
      mainText: 'СКИДКА -10%',
      promotionText: 'Для вас и еще вас',
    ),
  ];
}

class TestMockApiClient implements ApiClient {
  @override
  Future<User> updateProfile(User user) async {
    if (user.name.isEmpty) {
      throw Exception('Name cannot be empty');
    }
    if (!user.email.contains('@')) {
      throw Exception('Invalid email format');
    }
    return user;
  }

  @override
  Future<User> getProfile() async {
    return User(
      name: 'Тестовый Пользователь',
      email: 'test@example.com',
      phone: '+79999999999',
      avatarPic: 'assets/images/default_avatar.png',
    );
  }

  static final _mockProducts = [
    Product(
      id: '1',
      name: 'Увлажняющий крем для лица',
      price: 2499,
      description: 'Интенсивное увлажнение на 24 часа',
      images: ['assets/images/cream1.png'],
      category: 'Крем',
      inStock: true,
      rating: 4.8,
      reviewCount: 124,
    ),
    Product(
      id: '2',
      name: 'Тонирующее средство с SPF',
      price: 1899,
      description: 'Легкое покрытие с защитой от солнца',
      images: ['assets/images/foundation1.png'],
      category: 'Сыворотка',
      inStock: true,
      rating: 4.6,
      reviewCount: 89,
    ),
    Product(
      id: '3',
      name: 'Помада матовый эффект',
      price: 1299,
      description: 'Стойкая помада с матовым финишем',
      images: ['assets/images/lipstick1.png'],
      category: 'Тоник',
      inStock: false,
      rating: 4.9,
      reviewCount: 203,
    ),
  ];

  @override
  Future<List<Product>> getProducts() async {
    return _mockProducts;
  }

  @override
  Future<List<Product>> getSliderProducts() async {
    return _mockProducts.take(3).toList();
  }

  @override
  Future<List<Promotion>> getBanners() async {
    return _mockBanners;
  }

  static final _mockBanners = [
    Promotion(
      image: 'assets/images/sale1.png',
      mainText: 'СКИДКА -15%',
      promotionText: 'Для вас и еще вас',
    ),
    Promotion(
      image: 'assets/images/sale2.png',
      mainText: 'СКИДКА -10%',
      promotionText: 'Для вас и еще вас',
    ),
  ];
}
