part of 'edit_profile_bloc.dart';

@immutable
sealed class EditProfileState {}

class EditProfileInitialState extends EditProfileState {}

class EditProfileValidationState extends EditProfileState {
  final String? nameError;
  final String? emailError;
  final String? phoneError;
  final bool isValid;

  EditProfileValidationState({
    this.nameError,
    this.emailError,
    this.phoneError,
    required this.isValid,
  });
}

class EditProfileSavingState extends EditProfileState {}

class EditProfileSavedState extends EditProfileState {
  final User user;

  EditProfileSavedState(this.user);
}

class EditProfileErrorState extends EditProfileState {
  final String error;

  EditProfileErrorState(this.error);
}

class EditProfileAvatarPickedState extends EditProfileState {
  final Uint8List bytes;

  EditProfileAvatarPickedState({required this.bytes});
}
