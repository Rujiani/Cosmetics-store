part of 'profile_bloc.dart';

@immutable
sealed class ProfileEvent {}

class LoadProfileEvent extends ProfileEvent {}

class UpdateProfileEvent extends ProfileEvent {
  final User newUser;

  UpdateProfileEvent({required this.newUser});
}
