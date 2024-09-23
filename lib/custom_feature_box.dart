import 'package:avani/palette.dart';
import 'package:flutter/material.dart';

class CustomFeatureBox extends StatelessWidget {
  const CustomFeatureBox({super.key, required this.color, required this.header, required this.description});

  final Color color;
  final String header;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 35, vertical: 10),
      decoration: BoxDecoration(
        color: color,
        borderRadius: const BorderRadius.all(
          Radius.circular(20),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0).copyWith(left: 20.0),
        child: Column(
          children: [
            Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.only(bottom: 4.0),
              child: Text(
                header,
                style: const TextStyle(
                  fontFamily: 'Cera Pro',
                  fontSize: 16,
                  color: Palette.blackColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: Text(
                description,
                style: const TextStyle(
                  fontFamily: 'Cera Pro',
                  fontSize: 12,
                  color: Palette.blackColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
