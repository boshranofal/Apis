// part of 'my_cubit.dart';

// @immutable
// sealed class MyState {}

// final class MyInitial extends MyState {}

// final class GetAllUsers extends MyState {
//   final List<User> users;

//   GetAllUsers(this.users);
// }

// final class GetUserDetails extends MyState {
//   final User user;

//   GetUserDetails(this.user);
// }

// final class CreateNewUser extends MyState {
//   final User newuser;

//   CreateNewUser(this.newuser);
// }

// final class DeleteUser extends MyState {
//   final dynamic deleteuser;

//   DeleteUser(this.deleteuser);
// }

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:test_app/api_error_handler.dart';
part 'my_state.freezed.dart';

@freezed
abstract class MyState<T> with _$MyState<T> {
  const factory MyState.initial() = Initial;
  const factory MyState.loading() = Loading<T>;
  const factory MyState.success(T data) = Success<T>;
  const factory MyState.error(ErrorHandler error) = Error<T>;
  // const factory MyState.successList(List<T> data) = SuccessList<T>;
}
