part of 'auth_bloc.dart';

class AuthState extends Equatable {
  final String? email;
  final String? password;

  const AuthState({this.email, this.password});

  @override
  List<Object?> get props => [email, password];
}