import 'package:flutter_bloc/flutter_bloc.dart';
import '../data_mgt/Datahelper.dart';
import '../data_mgt/DataModel.dart';
import 'events.dart';
import 'states.dart';


class UserBloc extends Bloc<UserEvent, UserState> {
  final DatabaseHelper databaseHelper = DatabaseHelper();

  UserBloc() : super(UserInitialState()) {
    on<AddUserEvent>(_onAddUser);
    on<FetchUserEvent>(_onFetchUser);
  }

  // Handler for adding a user (registration)
  Future<void> _onAddUser(AddUserEvent event, Emitter<UserState> emit) async {
    emit(UserLoadingState()); // Emit loading state

    try {
      // Create a User object using the factory constructor to hash the password
      User newUser = User.create(
        username: event.username,
        email: event.email,
        password: event.password,
      );

      // Insert the new user into the database
      int userId = await databaseHelper.insertUser(newUser);

      if (userId > 0) {
        emit(UserAddedState()); // Emit success state
      } else {
        emit(UserErrorState('Failed to add user'));
      }
    } catch (e) {
      emit(UserErrorState(e.toString())); // Emit error state
    }
  }

  // Handler for fetching a user (login)
  Future<void> _onFetchUser(FetchUserEvent event, Emitter<UserState> emit) async {
    emit(UserLoadingState()); // Emit loading state

    try {
      // Fetch the user by email
      User? user = await databaseHelper.getUserByEmail(event.email);

      if (user != null) {
        // Verify the input password with the stored hashed password
        bool isPasswordCorrect = User.verifyPassword(event.password, user.password);

        if (isPasswordCorrect) {
          emit(UserFetchedState(user)); // Emit success state with user data
        } else {
          emit(UserErrorState('Incorrect password'));
        }
      } else {
        emit(UserErrorState('User not found'));
      }
    } catch (e) {
      emit(UserErrorState(e.toString())); // Emit error state
    }
  }
}


