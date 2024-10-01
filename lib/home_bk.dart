import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/blocmd.dart';
import 'bloc/events.dart';
import 'bloc/states.dart';


class HomeUI extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    // Dispatch the LoadUserSessionEvent to load the current user's session
    context.read<UserBloc>().add(LoadUserSessionEvent());

    return Scaffold(
      appBar: AppBar(title: Text('Hello Page')),
      body: BlocBuilder<UserBloc, UserState>(
        builder: (context, state) {
          if (state is UserLoadingState) {
            return Center(child: CircularProgressIndicator());
          } else if (state is UserSessionLoadedState) {
            return Center(
              child: Text('Hello, ${state.user.username}!'),
            );
          } else if (state is UserErrorState) {
            return Center(
              child: Text(state.message),
            );
          } else {
            return Center(
              child: Text('No user session found. Please log in.'),
            );
          }
        },
      ),
    );
  }
}
