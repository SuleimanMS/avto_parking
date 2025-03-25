import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final Function()? onTap;
  final String titleText;
  final colorName;
  final iconName;

  const MyButton({super.key,
    required this.onTap,
    required this.titleText,
    required this.colorName,
    this.iconName});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Material(
        color: colorName,
        borderRadius: BorderRadius.circular(8),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(8),
          highlightColor: Colors.grey[700],
          // Tugma bosilganda rang o‘zgarishi
          splashColor: Colors.white24,
          // Tugma bosilganda splash effekti
          child: Container(
            padding: const EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  iconName, // **Iconni parametr sifatida uzatish**
                  color: Colors.white,
                  size: 20,
                ),
                const SizedBox(width: 8), // Icon va matn orasidagi masofa
                Text(
                  titleText,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      // Material(
      //   color: colorName,
      //   borderRadius: BorderRadius.circular(8),
      //   child: InkWell(
      //     onTap: onTap,
      //     borderRadius: BorderRadius.circular(8),
      //     highlightColor: Colors.grey[700],
      //     // Tugma bosilganda rang o‘zgarishi
      //     splashColor: Colors.white24,
      //     // Tugma bosilganda splash effekti
      //     child: Container(
      //       padding: const EdgeInsets.all(25),
      //       child: Center(
      //         child: Text(
      //           titleText,
      //           style: const TextStyle(
      //             color: Colors.white,
      //             fontWeight: FontWeight.bold,
      //             fontSize: 16,
      //           ),
      //         ),
      //       ),
      //     ),
      //   ),
      // ),
    );
  }
}
