part of 'profile_cubit.dart';

sealed class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object> get props => [];
}

final class ProfileInitial extends ProfileState {}

final class ProfileLoading extends ProfileState {}

final class ProfileLoaded extends ProfileState {
  final AccountModel profile;

  const ProfileLoaded({required this.profile});
  @override
  List<Object> get props => [profile];
}

final class ProfileFailed extends ProfileState {
  final String err;

  const ProfileFailed({required this.err});
  @override
  List<Object> get props => [err];
}
