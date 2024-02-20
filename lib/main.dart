  import 'package:demo/controller.dart';
  import 'package:demo/pref/sharepref.dart';
  import 'package:flutter/material.dart';
  import 'package:get/get.dart';

 void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LocalStorageUtils.init();
  runApp(const MyApp());
}

  class MyApp extends StatefulWidget {
    const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
    @override
    Widget build(BuildContext context) {
      return const MaterialApp(
        title: 'Flutter Demo',
        home: LoginScreen(),
      );
    }
}

  class LoginScreen extends StatefulWidget {
    const LoginScreen({super.key});

    @override
    State<LoginScreen> createState() => _LoginScreenState();
  }
  final AccessUserController accessUserController = Get.put(AccessUserController());
  TextEditingController _otpfieldController = TextEditingController();
  TextEditingController _phoneNumberController = TextEditingController();

  class _LoginScreenState extends State<LoginScreen> {
    @override
    Widget build(BuildContext context) {
      return Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 100,
            ),
            TextFormField(
              controller: _phoneNumberController,
              decoration: const InputDecoration(hintText: "Phone Number"),
            ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(onPressed: (){
              accessUserController.sendOTP(_phoneNumberController.text, accessUserController.groupId.toInt());
              print( accessUserController.groupId.toInt());
            }, child: const Text("send otp")),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: _otpfieldController,
              decoration: const InputDecoration(hintText: "otp Number"),
            ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(onPressed: (){
              accessUserController.verifyOtp(_phoneNumberController.text,int.parse(_otpfieldController.text),context);
            }, child: const Text("verify otp"))
          ],
        ),
      );
    }
  }



class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Text(LocalStorageUtils.userData().phoneNumber.toString())));
  }
}
