abstract class UserEvent {}

class AddUserEvent extends UserEvent {
  final String username;
  final String email;
  final String password;

  AddUserEvent({required this.username, required this.email, required this.password});
}

class FetchUserEvent extends UserEvent {
  final String email;
  final String password;

  FetchUserEvent({required this.email, required this.password});
}

