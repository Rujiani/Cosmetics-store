import 'package:cosmetics_store/features/profile/edit_profile/presentation/bloc/edit_profile_bloc.dart';
import 'package:cosmetics_store/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditProfileScreen extends StatefulWidget {
  final User user;
  const EditProfileScreen({super.key, required this.user});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _phoneController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.user.name);
    _emailController = TextEditingController(text: widget.user.email);
    _phoneController = TextEditingController(text: widget.user.phone);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EditProfileBloc(),
      child: BlocListener<EditProfileBloc, EditProfileState>(
        listener: (context, state) {
          if (state is EditProfileSavedState) {
            Navigator.pop(context, state.user);
          }
        },
        child: Scaffold(
          appBar: AppBar(
            title: Text('Edit Profile'),
            actions: [
              BlocBuilder<EditProfileBloc, EditProfileState>(
                builder: (context, state) {
                  return IconButton(
                    icon: state is EditProfileSavingState
                        ? CircularProgressIndicator()
                        : Icon(Icons.save),
                    onPressed:
                        state is EditProfileSavingState ||
                            state is EditProfileValidationState &&
                                !state.isValid
                        ? null
                        : () => _saveProfile(context),
                  );
                },
              ),
            ],
          ),
          body: Padding(
            padding: EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  _buildAvatarField(context),
                  SizedBox(height: 24),
                  _buildNameField(context),
                  _buildEmailField(context),
                  _buildPhoneField(context),
                  _buildValidationErrors(context),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNameField(BuildContext context) {
    return BlocBuilder<EditProfileBloc, EditProfileState>(
      builder: (context, state) {
        return TextFormField(
          controller: _nameController,
          decoration: InputDecoration(
            labelText: 'Name',
            errorText: state is EditProfileValidationState
                ? state.nameError
                : null,
          ),
          onChanged: (value) => _validateForm(context),
        );
      },
    );
  }

  Widget _buildEmailField(BuildContext context) {
    return BlocBuilder<EditProfileBloc, EditProfileState>(
      builder: (context, state) {
        return TextFormField(
          controller: _emailController,
          decoration: InputDecoration(
            labelText: 'Email',
            errorText: state is EditProfileValidationState
                ? state.emailError
                : null,
          ),
          onChanged: (value) => _validateForm(context),
        );
      },
    );
  }

  Widget _buildPhoneField(BuildContext context) {
    return BlocBuilder<EditProfileBloc, EditProfileState>(
      builder: (context, state) {
        return TextFormField(
          controller: _phoneController,
          keyboardType: TextInputType.phone,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          decoration: InputDecoration(
            labelText: 'Phone',
            hintText: '10-15 digits',
            errorText: state is EditProfileValidationState
                ? state.phoneError
                : null,
          ),
          onChanged: (value) => _validateForm(context),
        );
      },
    );
  }

  Widget _buildValidationErrors(BuildContext context) {
    return BlocBuilder<EditProfileBloc, EditProfileState>(
      builder: (context, state) {
        if (state is EditProfileErrorState) {
          return Text(
            state.error,
            style: TextStyle(color: Theme.of(context).colorScheme.error),
          );
        }
        return SizedBox();
      },
    );
  }

  void _validateForm(BuildContext context) {
    context.read<EditProfileBloc>().add(
      EditProfileValidateEvent(
        name: _nameController.text,
        email: _emailController.text,
        phone: _phoneController.text,
      ),
    );
  }

  void _saveProfile(BuildContext context) {
    final state = context.read<EditProfileBloc>().state;

    final Uint8List? avatarBytes = state is EditProfileAvatarPickedState
        ? state.bytes
        : widget.user.avatarBytes;

    final user = User(
      name: _nameController.text,
      email: _emailController.text,
      phone: _phoneController.text,
      avatarPic: widget.user.avatarPic,
      avatarBytes: avatarBytes,
    );

    context.read<EditProfileBloc>().add(EditProfileSaveEvent(user));
  }

  Widget _buildAvatarField(BuildContext context) {
    return BlocBuilder<EditProfileBloc, EditProfileState>(
      builder: (context, state) {
        final Uint8List? avatarBytes = state is EditProfileAvatarPickedState
            ? state.bytes
            : null;

        return GestureDetector(
          onTap: () =>
              context.read<EditProfileBloc>().add(EditProfilePickAvatarEvent()),
          child: Column(
            children: [
              CircleAvatar(
                radius: 50,
                backgroundImage: avatarBytes != null
                    ? MemoryImage(avatarBytes)
                    : AssetImage(widget.user.avatarPic),
              ),
              SizedBox(height: 8),
              Text(
                'Tap to change',
                style: TextStyle(color: Colors.grey, fontSize: 12),
              ),
            ],
          ),
        );
      },
    );
  }
}
