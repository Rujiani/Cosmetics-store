import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:cosmetics_store/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';

part 'edit_profile_event.dart';
part 'edit_profile_state.dart';

class EditProfileBloc extends Bloc<EditProfileEvent, EditProfileState> {
  EditProfileBloc() : super(EditProfileInitialState()) {
    on<EditProfileValidateEvent>(_onValidate);
    on<EditProfileSaveEvent>(_onSave);
    on<EditProfilePickAvatarEvent>(_onPickAvatar);
  }

  void _onValidate(
    EditProfileValidateEvent event,
    Emitter<EditProfileState> emit,
  ) {
    final errors = _validateForm(event.name, event.email, event.phone);
    emit(
      EditProfileValidationState(
        nameError: errors['name'],
        emailError: errors['email'],
        phoneError: errors['phone'],
        isValid: errors.values.every((error) => error == null),
      ),
    );
  }

  void _onSave(
    EditProfileSaveEvent event,
    Emitter<EditProfileState> emit,
  ) async {
    emit(EditProfileSavingState());
    try {
      await Future.delayed(const Duration(seconds: 1));
      emit(EditProfileSavedState(event.user));
    } catch (e) {
      emit(EditProfileErrorState(e.toString()));
    }
  }

  Map<String, String?> _validateForm(String name, String email, String phone) {
    return {
      'name': name.isEmpty ? 'Name is required' : null,
      'email': !email.contains('@') ? 'Invalid email' : null,
      'phone': _validatePhone(phone),
    };
  }

  String? _validatePhone(String phone) {
    if (phone.isEmpty) return 'Phone is required';

    final digitsOnly = phone.replaceAll(RegExp(r'[^\d]'), '');

    if (digitsOnly.length < 10) {
      return 'Phone should be at least 10 digits';
    }

    if (digitsOnly.length > 15) {
      return 'Phone should be maximum 15 digits';
    }

    if (RegExp(r'^(\d)\1+$').hasMatch(digitsOnly)) {
      return 'Enter a valid phone number';
    }

    return null;
  }

  void _onPickAvatar(
    EditProfilePickAvatarEvent event,
    Emitter<EditProfileState> emit,
  ) async {
    try {
      final ImagePicker picker = ImagePicker();
      final XFile? image = await picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 512,
        maxHeight: 512,
        imageQuality: 80,
      );

      if (image != null) {
        final bytes = await image.readAsBytes();
        emit(EditProfileAvatarPickedState(bytes: bytes));
      }
    } catch (e) {
      emit(EditProfileErrorState('Failed to pick image: ${e.toString()}'));
    }
  }
}
