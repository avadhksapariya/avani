import 'package:avani/palette.dart';
import 'package:flutter/material.dart';

class HomePageScreen extends StatefulWidget {
  const HomePageScreen({super.key});

  @override
  State<HomePageScreen> createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AVANI'),
        leading: const Icon(Icons.menu),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Virtual Assistant Picture
          Stack(
            children: [
              Center(
                child: Container(
                  height: 120,
                  width: 120,
                  margin: const EdgeInsets.only(top: 4.0),
                  decoration: const BoxDecoration(
                    color: Palette.assistantCircleColor,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
              Container(
                height: 128,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: AssetImage('assets/images/female_voice_assistant.png'),
                  ),
                ),
              ),
            ],
          ),
          // Chat Bubble
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
            margin: const EdgeInsets.symmetric(horizontal: 40.0).copyWith(top: 30.0),
            decoration: BoxDecoration(
              border: Border.all(
                color: Palette.borderColor,
              ),
            ),
            child: const Text(
              'Good Morning, What task can I do for you?',
              style: TextStyle(color: Palette.mainFontColor, fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}
