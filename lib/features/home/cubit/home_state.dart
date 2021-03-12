part of 'home_cubit.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

class HomeInitial extends HomeState {}

class UserCredentailsLoaded extends HomeState {
  final User user;

  UserCredentailsLoaded(this.user);

  @override
  List<Object> get props => [user];
}

class UserSignedOut extends HomeState {}

class UserSignedOutFailure extends HomeState {
  final String message;

  UserSignedOutFailure(this.message);
}
