import 'package:cosmetics_store/features/profile/edit_profile/presentation/pages/edit_profile_screen.dart';
import 'package:cosmetics_store/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final textButtonStyle = TextButton.styleFrom(
      elevation: 1,
      shadowColor: Colors.black,
      backgroundColor: Colors.white,
      alignment: Alignment.centerLeft,
      shape: RoundedRectangleBorder(
        borderRadius: const BorderRadius.all(Radius.zero),
      ),
    );
    return Center(
      child: BlocProvider<ProfileBloc>(
        create: (context) => ProfileBloc()..add(LoadProfileEvent()),
        child: BlocBuilder<ProfileBloc, ProfileState>(
          builder: (context, state) {
            switch (state) {
              case ProfileLoadingState _:
                return CircularProgressIndicator(color: Colors.black);
              case ProfileLoadedState _:
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  spacing: 8,
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundImage: state.user.avatarBytes != null
                          ? MemoryImage(state.user.avatarBytes!)
                          : AssetImage(state.user.avatarPic),
                      child: state.user.avatarBytes == null
                          ? Icon(Icons.camera_alt, color: Colors.white)
                          : null,
                    ),
                    SizedBox(height: 4),
                    Text(state.user.name, style: TextStyle(fontSize: 24)),
                    SizedBox(height: 4),
                    Text(state.user.email, style: TextStyle(fontSize: 20)),
                    Text(state.user.phone, style: TextStyle(fontSize: 20)),
                    SizedBox(height: 16),
                    SizedBox(
                      height: 50,
                      width: 300,
                      child: TextButton.icon(
                        style: textButtonStyle,
                        icon: Icon(Icons.edit),
                        onPressed: () {
                          final currentContext =
                              context; // ← Сохраняем ДО async
                          final currentBloc = context.read<ProfileBloc>();

                          Navigator.push(
                            currentContext,
                            MaterialPageRoute(
                              builder: (context) =>
                                  EditProfileScreen(user: state.user),
                            ),
                          ).then((updatedUser) {
                            // Используем сохраненные переменные
                            if (updatedUser != null && currentContext.mounted) {
                              currentBloc.add(
                                UpdateProfileEvent(newUser: updatedUser),
                              );
                            }
                          });
                        },
                        label: Text('Edit Profile'),
                      ),
                    ),
                    SizedBox(
                      height: 50,
                      width: 300,
                      child: TextButton.icon(
                        style: textButtonStyle,
                        icon: Icon(Icons.settings),
                        onPressed: () {},
                        label: Text('Setting'),
                      ),
                    ),
                    SizedBox(
                      height: 50,
                      width: 300,
                      child: TextButton.icon(
                        style: textButtonStyle,
                        icon: Icon(
                          Icons.logout,
                          color: Theme.of(context).colorScheme.error,
                        ),
                        onPressed: () {},
                        label: Text(
                          'Logout',
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.error,
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              case ProfileErrorState _:
                return Text('Error: ${state.error}');
              default:
                return SizedBox();
            }
          },
        ),
      ),
    );
  }
}
