import 'dart:ui';

import 'package:flutter/material.dart';

import 'package:avto_parking/common/utils/utils.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../app/route_names.dart';
import '../app/router.dart';
import '../components/show_dialog.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _loggedIn = false;
  bool _passwordVisible = false;
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  void signUserIn() async {
    final requestParameters = {
      "username": usernameController.text,
      "password": passwordController.text,
    };

    try {
      final response = await http.post(
        Uri.parse('https://avto-park.uz/services/platon-core/api/v1/login'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: json.encode(requestParameters),
      );

      final int statusCode = response.statusCode ?? 500;
      final resultClass = json.decode(utf8.decode(response.bodyBytes));

      if (statusCode == 200) {
        setState(() {
          _loggedIn = true;
        });
        // debugPrint("$resultClass");
        Utils.setToken(resultClass["data"]["access_token"]);
        Utils.setRefreshToken(resultClass["data"]["refresh_token"]);

        Future.delayed(Duration(seconds: 1), () {
          navigatorKey.currentState!.pushReplacementNamed(MainRoutes.main_page);
        });
      } else {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return ShowDialog(
              errorMessage: "Login yoki parol to‘g‘riligini tekshiring!",
              errorTitle: "Xatolik",
            );
          },
        );
      }
    } catch (e) {
      debugPrint("Xatolik yuz berdi: $e");
    }
  }

  void signWithEimzo() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return ShowDialog(
          errorMessage: "Tez orada E-IMZO bilan ulanish ishga tushiriladi.",
          errorTitle: "Xabar",
        );
      },
    );
    // try {
    //   final url = "https://avto-park.uz/services/platon-auth/api/eimzo/$docId";
    //   final response = await dio.get(url,
    //       options: Options(headers: {
    //         "Device-Id": "${Utils.device_id}",
    //         "User-Agent": "${Utils.user_agent}",
    //         'device-ip': '${Utils.device_name}'
    //       }));
    //   int statusCode = response.statusCode ?? 500;
    //   if (statusCode == 200) {
    //     Utils.setToken(response.data['data']['access_token']);
    //     Utils.setRefreshToken(response.data['data']['refresh_token']);
    //     return true;
    //   } else {
    //     return false;
    //   }
    // } catch (e) {
    //   debugPrint("Xatolik yuz berdi: $e");
    // }
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus(); // Klaviaturani yopish uchun
        },
        child: Stack(
          children: [
            // Background Image
            Positioned.fill(
              child: Image.asset(
                'assets/images/login_bg.png',
                fit: BoxFit.cover,
              ),
            ),

            // Foreground Content
            Positioned.fill(
              child: SingleChildScrollView(
                physics: ClampingScrollPhysics(),
                // Qo'shimcha scroll oldini oladi
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: screenHeight),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: screenHeight * 0.15),

                      // Animated Padding for Keyboard Handling
                      AnimatedPadding(
                        duration: Duration(milliseconds: 300),
                        padding: EdgeInsets.only(
                          bottom: MediaQuery.of(context)
                              .viewInsets
                              .bottom, // Klaviatura ochilganda yuqoriga suradi
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
                            // Xiralik
                            child: Container(
                              padding: EdgeInsets.all(20),
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.7),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const Text(
                                    "Avto-parkga hush kelibsiz",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  const Text(
                                    "Tizimga kirish uchun ma'lumotlaringizni kiriting yoki ERI bilan kiring",
                                    style: TextStyle(
                                      color: Colors.white70,
                                      fontSize: 14,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  const SizedBox(height: 20),

                                  // Login Input
                                  TextField(
                                    controller: usernameController,
                                    style: const TextStyle(color: Colors.white),
                                    cursorColor: Colors.white,
                                    decoration: InputDecoration(
                                      hintText: "Login",
                                      hintStyle: const TextStyle(
                                          color: Colors.white60),
                                      filled: true,
                                      fillColor: Colors.white.withOpacity(0.1),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: BorderSide.none,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 10),

                                  // Password Input
                                  TextField(
                                    controller: passwordController,
                                    obscureText: !_passwordVisible,
                                    style: TextStyle(color: Colors.white),
                                    cursorColor: Colors.white,
                                    decoration: InputDecoration(
                                      hintText: "Parol",
                                      hintStyle:
                                          TextStyle(color: Colors.white60),
                                      filled: true,
                                      fillColor: Colors.white.withOpacity(0.1),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: BorderSide.none,
                                      ),
                                      suffixIcon: IconButton(
                                        icon: Icon(
                                          _passwordVisible
                                              ? Icons.visibility
                                              : Icons.visibility_off,
                                          color: Colors.white60,
                                        ),
                                        onPressed: () {
                                          setState(() {
                                            _passwordVisible =
                                                !_passwordVisible;
                                          });
                                        },
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 20),

                                  // Kirish Button
                                  SizedBox(
                                    width: double.infinity,
                                    child: ElevatedButton(
                                      onPressed: () {},
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.yellow,
                                        padding:
                                            EdgeInsets.symmetric(vertical: 16),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                      ),
                                      child: Text(
                                        "Kirish",
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),

                                  const SizedBox(height: 10),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 25),
                                          child: Divider(
                                            color: Color(0xFF979797),
                                            // Chiziq rangi
                                            thickness: 1,
                                          ),
                                        ),
                                      ),
                                      Text(
                                        "Yoki",
                                        style: TextStyle(color: Colors.white70),
                                      ),
                                      Expanded(
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 25),
                                          child: Divider(
                                            color: Color(0xFF979797),
                                            // Chiziq rangi
                                            thickness: 1,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 10),

                                  // E-IMZO Button
                                  SizedBox(
                                    width: double.infinity,
                                    child: ElevatedButton.icon(
                                      onPressed: signWithEimzo,
                                      icon: Image.asset(
                                          "assets/images/eri_logo.png"),
                                      label: const Text(
                                        "E-IMZO orqali kirish",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                        ),
                                      ),
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor:
                                            Colors.white.withOpacity(0.2),
                                        padding:
                                            EdgeInsets.symmetric(vertical: 16),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                      ),
                                    ),
                                  ),

                                  const SizedBox(height: 15),
                                  // Privacy Notice
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 10),
                                    child: RichText(
                                      textAlign: TextAlign.center,
                                      text: TextSpan(
                                        style: TextStyle(
                                          color: Colors.white, // Umumiy rang oq
                                          fontSize: 12,
                                          height: 1.35, // Line height = 16px
                                        ),
                                        children: [
                                          TextSpan(
                                              text:
                                                  "Davom ettirish orqali siz "),
                                          TextSpan(
                                            text:
                                                "Shaxsiy ma'lumotlaringiz qayta ishlanish shartlari",
                                            style: TextStyle(
                                                color: Colors.redAccent),
                                          ),
                                          TextSpan(text: " va "),
                                          TextSpan(
                                            text:
                                                "Xizmatdan foydalanish qoidalariga",
                                            style: TextStyle(
                                                color: Colors.redAccent),
                                          ),
                                          TextSpan(text: " rozi bo'lasiz"),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),

                      // Ekranning pastida bo‘sh joy qolishining oldini olish uchun
                      SizedBox(height: screenHeight * 0.05),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
