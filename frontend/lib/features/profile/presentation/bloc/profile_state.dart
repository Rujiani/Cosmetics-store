part of 'profile_bloc.dart';

@immutable
sealed class ProfileState {}

final class ProfileInitial extends ProfileState {}

final class ProfileLoadingState extends ProfileState {}

final class ProfileLoadedState extends ProfileState {
  final User user;

  ProfileLoadedState({required this.user});
}

final class ProfileErrorState extends ProfileState {
  final String error;

  ProfileErrorState({required this.error});
}

class User {
  final String name;
  final String email;
  final String phone;
  final String avatarPic;
  final Uint8List? avatarBytes;

  User({
    this.name = 'Иван Иванов',
    this.email = 'ivan@example.com',
    this.phone = '+7 999 123-45-67',
    this.avatarPic = 'assets/images/default/defaultAvatar.png',
    this.avatarBytes,
  });

  User copyWith({Uint8List? avatarBytes}) {
    return User(
      name: name,
      email: email,
      phone: phone,
      avatarPic: avatarPic,
      avatarBytes: avatarBytes ?? this.avatarBytes,
    );
  }
}
