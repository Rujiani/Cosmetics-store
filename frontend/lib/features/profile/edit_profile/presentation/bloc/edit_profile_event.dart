part of 'edit_profile_bloc.dart';

@immutable
sealed class EditProfileEvent {}

class EditProfileSaveEvent extends EditProfileEvent {
  final User user;

  EditProfileSaveEvent(this.user);
}

class EditProfileValidateEvent extends EditProfileEvent {
  final String name;
  final String email;
  final String phone;

  EditProfileValidateEvent({
    required this.name,
    required this.email,
    required this.phone,
  });
}

class EditProfilePickAvatarEvent extends EditProfileEvent {}
