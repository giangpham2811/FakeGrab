import 'package:app/src/data/model/account.dart';
import 'package:app/src/data/network/request/login_email_param.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'app_api.g.dart';

@RestApi()
abstract class AppApi {
  factory AppApi(Dio dio, {String baseUrl}) = _AppApi;

  @POST("/api/user/login")
  Future<Account> loginWithEmailAndPassword(@Body() LoginEmailParam loginEmailParam);

  @GET("core/users/profile")
  Future<User> getMyProfile();
}
