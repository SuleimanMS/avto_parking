import 'package:flutter/material.dart';
import 'package:slide_to_act/slide_to_act.dart';

import '../app/route_names.dart';
import '../app/router.dart';

class UnlockPage extends StatefulWidget {
  const UnlockPage({super.key});

  @override
  State<UnlockPage> createState() => _UnlockPageState();
}

class _UnlockPageState extends State<UnlockPage> {
  bool _submitted = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          ///  Orqa fon rasmi
          Positioned.fill(
            child: Image.asset(
              "assets/images/background.png",
              fit: BoxFit.cover,
            ),
          ),

          /// Markazdagi matnli Card
          Positioned(
            top: MediaQuery.of(context).size.height * 0.27,
            // Ekranning 25% qismida joylashish
            left: 20,
            right: 20,
            child: Card(
              color: Colors.yellowAccent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Padding(
                padding: const EdgeInsets.all(30.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Mashinalarni boshqarish uchun oson yechim",
                      style: TextStyle(
                        color: Color(0xFF0B0C0E),
                        // Primary Black
                        fontFamily: "Gilroy",
                        fontSize: 32,
                        fontWeight: FontWeight.w700,
                        // Bold (700)
                        height: 40 / 32, // Line height = 40px (125%)
                      ),
                    ),
                    SizedBox(height: 15),
                    Text(
                      "Mashinalar va haydovchilar holatidan xabardor bo’ling va ularni boshqaring",
                      style: TextStyle(
                        color: Color(0xFF0B0C0E),
                        // Primary Black
                        fontFamily: "Gilroy",
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        // Semi-bold (600)
                        height: 24 / 16, // Line height = 24px (150%)
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          /// Pastki slider
          Positioned(
            bottom: 20,
            left: 55.5,
            right: 55.5,
            child: Stack(
              alignment: Alignment.center, // Rasmni markazga joylashtiramiz
              children: [
                SlideAction(
                  height: 84,
                  elevation: 0,
                  outerColor: _submitted ? Colors.yellowAccent : Colors.black38,
                  sliderButtonIcon: Image.asset("assets/images/unlock_car.png"),
                  sliderButtonIconPadding: 22,
                  borderRadius: 100,
                  text: ">>>   Boshlash",
                  sliderRotate: false,
                  animationDuration: Duration(milliseconds: 100),
                  onSubmit: () {
                    setState(() {
                      _submitted = true;
                    });
                    navigatorKey.currentState!
                        .pushReplacementNamed(MainRoutes.login_page);
                    return null;
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
