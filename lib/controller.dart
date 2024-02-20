import 'package:demo/main.dart';
import 'package:demo/model/refresh_token_model.dart';
import 'package:demo/model/sendotp_model.dart';
import 'package:demo/model/verify_otp.dart';
import 'package:demo/pref/sharepref.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http; // For making HTTP requests
import 'dart:convert'; // For encoding/decoding JSON

class AccessUserController extends GetxController {

  RxInt groupId = 1703228300417.obs;
  void sendOTP(String phoneNumber, int groupId) async {
    try {
      var response = await http.post(
        Uri.parse(
            'https://gxppcdmn7h.execute-api.ap-south-1.amazonaws.com/authgw/sendotp'),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode(<String, dynamic>{
          'phoneNumber': phoneNumber,
          'groupId': groupId,
        }),
      );
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        SendOtpResponse sendOtpResponse =
            SendOtpResponse.fromJson(data); 
        print(
            "OTP sent successfully. Status: ${sendOtpResponse.status}, Message: ${sendOtpResponse.message}");
      } else {
        print('Failed to send OTP: ${response.statusCode}');
      }
    } catch (e) {
      print('Error sending OTP: $e');
    }
  }

  void verifyOtp(String phoneNumber, int otp, BuildContext context) async {
     try {
      var response = await http.post(
        Uri.parse(
            'https://4r4iwhot12.execute-api.ap-south-1.amazonaws.com/auth/auth/validateOtp/'),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode(<String, dynamic>{
          'phoneNumber': phoneNumber,
          'otp': otp,
        }),
      );
      if (response.statusCode == 200) {
        
        var data = jsonDecode(response.body);
        VerifyOtpResponse verifyOtpResponse =
            VerifyOtpResponse.fromJson(data); 
            refreshToken(token: verifyOtpResponse.token.toString(), groupId: 1703228300417);
            Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen(),));
            
        print(
            "OTP verify successfully. Status: ${verifyOtpResponse.status}, Message: ${verifyOtpResponse.message}");
      } else {
        print('Failed to verify OTP: ${response.statusCode}');
      }
    } catch (e) {
      print('Error verifying OTP: $e');
    }
  }

  void refreshToken({required String token ,required int groupId}) async{
try {
      var response = await http.post(
        Uri.parse(
            'https://gxppcdmn7h.execute-api.ap-south-1.amazonaws.com//authgw/refresh-token'),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode(<String, dynamic>{
          'token': token,
          'groupId': groupId,
        }),
      );
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        RefreshTokenResponseModel refreshTokenResponseModel =
            RefreshTokenResponseModel.fromJson(data);
             print("${refreshTokenResponseModel.data?.userExists}");
             LocalStorageUtils.saveUserDetails(token);
              print("refresh token is $token ");
        print(
            "OTP verify successfully. Status: ${refreshTokenResponseModel.status}, Message: ${refreshTokenResponseModel.message}");
      } else {
        print('Failed to verify OTP: ${response.statusCode}');
      }
    } catch (e) {
      print('Error verifying OTP: $e');
    }
  }
}
