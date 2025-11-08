import 'package:cosmetics_store/app/pages/main_screen.dart';
import 'package:cosmetics_store/features/profile/edit_profile/presentation/pages/edit_profile_screen.dart';
import 'package:cosmetics_store/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      title: 'Cosmetics Shop',
      home: MainScreen(),
      routes: {
        '/edit-profile': (context) {
          final user = ModalRoute.of(context)!.settings.arguments as User;
          return EditProfileScreen(user: user);
        },
      },
    ),
  );
}
