import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:cosmetics_store/core/api/api_client.dart';
import 'package:cosmetics_store/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:meta/meta.dart';

part 'edit_profile_event.dart';
part 'edit_profile_state.dart';

class EditProfileBloc extends Bloc<EditProfileEvent, EditProfileState> {
  final ApiClient apiClient;

  EditProfileBloc(this.apiClient) : super(EditProfileInitialState()) {
    on<EditProfileSaveEvent>(_onSaveProfile);
  }

  void _onSaveProfile(
    EditProfileSaveEvent event,
    Emitter<EditProfileState> emit,
  ) async {
    emit(EditProfileSavingState());
    try {
      final updatedUser = await apiClient.updateProfile(event.user);
      emit(EditProfileSavedState(updatedUser));
    } catch (e) {
      emit(EditProfileErrorState(e.toString()));
    }
  }
}
