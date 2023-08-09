part of 'credential_cubit.dart';

abstract class CredentialState extends Equatable {
  const CredentialState();
}

class CredentialInitial extends CredentialState {
  @override
  List<Object> get props => [];
}

class CredentialLoading extends CredentialState {
  @override
  List<Object> get props => [];
}
class CredentialSuccess extends CredentialState {
  final UserModel user;

  CredentialSuccess(this.user);
  @override
  List<Object> get props => [];
}

class CredentialFailure extends CredentialState {
  final String errorMessage;

  CredentialFailure(this.errorMessage);
  @override
  List<Object> get props => [errorMessage];
}
