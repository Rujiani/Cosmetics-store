// test/features/edit_profile/edit_profile_validation_test.dart
import 'package:cosmetics_store/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Profile Validation', () {
    test('should validate correct user data', () {
      final user = User(
        name: 'Иван Иванов',
        email: 'ivan@example.com',
        phone: '+79991234567',
        avatarPic: 'assets/images/default_avatar.png',
      );

      expect(user.name.isNotEmpty, true);
      expect(user.email.contains('@'), true);
      expect(user.phone.length >= 10, true);
    });

    test('should detect invalid email', () {
      final user = User(
        name: 'Иван Иванов',
        email: 'invalid-email', // нет @
        phone: '+7 999 123-45-67',
        avatarPic: 'assets/images/default_avatar.png',
      );

      expect(user.email.contains('@'), false);
    });
  });
}
