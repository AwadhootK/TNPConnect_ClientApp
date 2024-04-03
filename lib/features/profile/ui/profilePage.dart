import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tnpconnect/features/profile/bloc/profile_bloc.dart';
import 'package:tnpconnect/features/profile/ui/profileDetails.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileBloc, ProfileState>(
      builder: (context, state) {
        if (state is ProfileLoadingState) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is ProfileErrorState) {
          return const Center(
            child: Text('Some error occurred...'),
          );
        } else if (state is ProfileDetailsSuccessState) {
          return ProfileDetails(state.student, state.studentDocs);
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
      listener: (context, state) {},
    );
  }
}
