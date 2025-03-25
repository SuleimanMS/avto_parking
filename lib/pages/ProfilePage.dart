import 'package:flutter/material.dart';
import 'package:avto_parking/components/my_button.dart';
import 'package:avto_parking/common/utils/utils.dart';
import 'package:avto_parking/app/route_names.dart';
import 'package:avto_parking/app/router.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  void settings() {}

  void signOut() {
    Utils.setToken('');
    Utils.setRefreshToken('');

    navigatorKey.currentState!.pushReplacementNamed(MainRoutes.login_page);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            SizedBox(height: 130),
            Center(
              child: CircleAvatar(
                radius: 50,
                backgroundColor: Colors.grey[300], // Orqa fon rangi
                backgroundImage: AssetImage("assets/images/user.png")
              ),
            ),

            SizedBox(height: 12),

            // Foydalanuvchi ismi
            Text(
              "Suhayl Murodov",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),

            SizedBox(height: 4),

            // Foydalanuvchi email
            Text(
              "suhayl.murodov@gmail.com",
              style: TextStyle(fontSize: 16, color: Colors.grey[600]),
            ),

            SizedBox(height: 30),
            MyButton(
              onTap: settings,
              titleText: "Созламалар",
              colorName: Colors.blue,
              iconName: Icons.settings,
            ),
            SizedBox(height: 10),
            MyButton(
              onTap: signOut,
              titleText: "Тизимдан чиқиш",
              colorName: Colors.red,
              iconName: Icons.logout,
            ),
          ],
        ),
      ),
    );
  }
}
