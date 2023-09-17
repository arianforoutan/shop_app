import 'package:dartz/dartz.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop_app/data/datasource/authentication_datasource.dart';
import 'package:shop_app/di/di.dart' show locator;
import 'package:shop_app/util/api_exception.dart';
import 'package:shop_app/util/auth_manager.dart';

abstract class IAuthRepository {
  Future<Either<String, String>> register(
      String username, String password, String passwordConfirm);

  Future<Either<String, String>> login(String username, String password);
}

class AuthenticationRepository implements IAuthRepository {
  final IAuthenticationDatasource _datasource = locator.get();
  // ignore: unused_field
  final SharedPreferences _sharedPref = locator.get();

  @override
  Future<Either<String, String>> register(
      String username, String password, String passwordConfirm) async {
    try {
      await _datasource.register('Arian120', '12345678', '12345678');
      return right('ثبت نام انجام شد ');
    } on ApiException catch (e) {
      return left(e.message ?? 'null');
    }
  }

  @override
  Future<Either<String, String>> login(String username, String password) async {
    try {
      String token = await _datasource.login(username, password);
      if (token.isNotEmpty) {
        AuthManager.saveToken(token);
        return right('شما وارد شدید');
      } else {
        return left('خطایی در ورود پیش امده ');
      }
    } on ApiException catch (e) {
      return left('${e.message}');
    }
  }
}
