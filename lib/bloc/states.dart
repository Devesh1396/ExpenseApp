import '../data_mgt/DataModel.dart';

abstract class UserState {}

class UserInitialState extends UserState {}

class UserLoadingState extends UserState {}

//class UserAddedState extends UserState {}

class UserFetchedState extends UserState {
  final User user;

  UserFetchedState(this.user);
}

class UserErrorState extends UserState {
  final String message;

  UserErrorState(this.message);
}

//  tate to Indicate User Session Loaded
class UserSessionLoadedState extends UserState {
  final User user;

  UserSessionLoadedState(this.user);
}


class OnboardingNotSeenState extends UserState {}