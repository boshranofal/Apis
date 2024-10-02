import 'package:test_app/api_error_handler.dart';
import 'package:test_app/api_result.dart';
import 'package:test_app/cubit/my_state.dart';
import 'package:test_app/user.dart';
import 'package:test_app/web_service.dart';

class MyRepo {
  final WebService webService;

  MyRepo(this.webService);

  Future<ApiResult<List<User>>> getAllUsers() async {
    try {
      final users = await webService.getAllUsers();
      return ApiResult.success(users);
    } catch (e) {
      return ApiResult.failure(ErrorHandler.handle(e));
    }
  }

  Future<ApiResult<User>> getUserById(int id) async {
    try {
      final user = await webService.getUserbyId(id);
      return ApiResult.success(user);
    } catch (e) {
      return ApiResult.failure(ErrorHandler.handle(e));
    }
  }

  Future<ApiResult<User>> createUser(User user) async {
    try {
      final createdUser = await webService.createNewUser(user,
          'Bearer efd0cce3ae3d280057d2766522a27511d0f1515dc54a71083690ab82acbc715a');
      return ApiResult.success(createdUser);
    } catch (e) {
      return ApiResult.failure(ErrorHandler.handle(e));
    }
  }

  Future<ApiResult<dynamic>> deleteUser(int id) async {
    try {
      final response = await webService.deleteUser(
        id,
        'Bearer efd0cce3ae3d280057d2766522a27511d0f1515dc54a71083690ab82acbc715a',
      );
      return ApiResult.success(response);
    } catch (e) {
      return ApiResult.failure(ErrorHandler.handle(e));
    }
  }
}
