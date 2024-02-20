import 'package:demo/model/jwt_token_model.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:developer';

class LocalStorageUtils {
  static late final SharedPreferences instance;

  static Future<SharedPreferences> init() async =>
      instance = await SharedPreferences.getInstance();

  static JwtTokenResponseModel get tokenResponseModel => userData();

  static Future<void> saveUserDetails(String token) async {
    await instance.setString("token", token);
    log("Token saved! $token");
    log("*******token saved " + token);
  }

  static Future<String?> fetchToken() async {
    final token = instance.getString('token') ?? '';

    if (token.isEmpty) {
      return "";
    }

    return token;
  }

  static JwtTokenResponseModel userData() {
    final token = instance.getString('token') ?? "";
    var userData = JwtDecoder.decode(token);
    var userDecoded = JwtTokenResponseModel.fromJson(userData);

    log("***********userDecode $userDecoded");
    return userDecoded;
  }
}
