import 'package:bloc/bloc.dart';

import 'package:test_app/api_result.dart';
import 'package:test_app/cubit/my_state.dart';
import 'package:test_app/my_repo.dart';
import 'package:test_app/user.dart';

class MyCubit extends Cubit<MyState<User>> {
  final MyRepo myRepo;
  MyCubit(this.myRepo) : super(MyState.initial());

  Future<void> emitGetAllUsers() async {
    final users = await myRepo.getAllUsers();
    users.when(
      success: (users) {
        emit(Success(users));
      },
      failure: (error) {
        emit(Error(error));
      },
    );
  }

  Future<void> emitGetUserById(int id) async {
    final user = await myRepo.getUserById(id);
    user.when(
      success: (user) {
        emit(Success(user));
      },
      failure: (error) {
        emit(Error(error));
      },
    );
  }

  Future<void> emitCreateUser(User user) async {
    final createdUser = await myRepo.createUser(user);
    createdUser.when(
      success: (user) {
        emit(Success(user));
      },
      failure: (error) {
        emit(Error(error));
      },
    );
  }

  Future<void> emitDeleteUser(int id) async {
    final response = await myRepo.deleteUser(id);
    response.when(
      success: (response) {
        emit(Success(response));
      },
      failure: (error) {
        emit(Error(error));
      },
    );
  }
}
