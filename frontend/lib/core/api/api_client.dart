import 'package:cosmetics_store/features/profile/presentation/bloc/profile_bloc.dart';

abstract class ApiClient {
  Future<User> getProfile();
  Future<User> updateProfile(User user);
  // Future<List<Product>> getProducts();
  // Future<List<Product>> getSliderProducts();
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
}
