// test/features/edit_profile/edit_profile_bloc_test.dart
import 'package:bloc_test/bloc_test.dart';
import 'package:cosmetics_store/core/api/api_client.dart';
import 'package:cosmetics_store/features/profile/edit_profile/presentation/bloc/edit_profile_bloc.dart';
import 'package:cosmetics_store/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('EditProfileBloc', () {
    late TestMockApiClient mockApiClient;
    late EditProfileBloc editProfileBloc;

    setUp(() {
      mockApiClient = TestMockApiClient();
      editProfileBloc = EditProfileBloc(mockApiClient);
      MockApiClient.reset();
    });

    tearDown(() {
      editProfileBloc.close();
    });

    // Тест 1: Успешное сохранение профиля
    blocTest<EditProfileBloc, EditProfileState>(
      'should emit [saving, saved] when save is successful',
      build: () => editProfileBloc,
      act: (bloc) => bloc.add(
        EditProfileSaveEvent(
          User(
            name: 'Новое Имя',
            email: 'new@example.com',
            phone: '+79999999999',
            avatarPic: 'assets/images/default_avatar.png',
          ),
        ),
      ),
      wait: const Duration(milliseconds: 150),
      expect: () => [
        isA<EditProfileSavingState>(),
        isA<EditProfileSavedState>(),
      ],
    );

    blocTest<EditProfileBloc, EditProfileState>(
      'should emit [saving, error] when name is empty',
      build: () => editProfileBloc,
      act: (bloc) => bloc.add(
        EditProfileSaveEvent(
          User(
            name: '',
            email: 'test@example.com',
            phone: '+79999999999',
            avatarPic: 'assets/images/default_avatar.png',
          ),
        ),
      ),
      expect: () => [
        isA<EditProfileSavingState>(),
        isA<EditProfileErrorState>(),
      ],
    );

    blocTest<EditProfileBloc, EditProfileState>(
      'should emit [saving, error] when email is invalid',
      build: () => editProfileBloc,
      act: (bloc) => bloc.add(
        EditProfileSaveEvent(
          User(
            name: 'Тест',
            email: 'invalid-email',
            phone: '+79999999999',
            avatarPic: 'assets/images/default_avatar.png',
          ),
        ),
      ),
      expect: () => [
        isA<EditProfileSavingState>(),
        isA<EditProfileErrorState>(),
      ],
    );
  });
}
