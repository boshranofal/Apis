import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:test_app/user.dart';

part 'web_service.g.dart';

@RestApi(baseUrl: 'https://gorest.co.in/public/v2/')
abstract class WebService {
  factory WebService(Dio dio, {String? baseUrl}) = _WebService;

  @GET('users')
  Future<List<User>> getAllUsers();

  @GET('users/{id}')
  Future<User> getUserbyId(@Path() int id);

  @POST("users")
  Future<User> createNewUser(
      @Body() User newUser, @Header("Authorization") String token);

  @DELETE("users/{id}")
  Future<dynamic> deleteUser(
      @Path() int id, @Header("Authorization") String token);
}
