import 'package:avani/custom_feature_box.dart';
import 'package:avani/palette.dart';
import 'package:flutter/material.dart';

class HomePageScreen extends StatefulWidget {
  const HomePageScreen({super.key});

  @override
  State<HomePageScreen> createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {
  late String greeting;

  @override
  void initState() {
    super.initState();
    greeting = getGreeting();
  }

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
              borderRadius: BorderRadius.circular(20).copyWith(topLeft: Radius.zero),
            ),
            child: Text(
              '$greeting, How can I help you?',
              style: const TextStyle(fontFamily: 'Cera Pro', color: Palette.mainFontColor, fontSize: 16),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(10),
            margin: const EdgeInsets.only(top: 10, left: 20),
            alignment: Alignment.centerLeft,
            child: const Text(
              'Here are few suggestions.',
              style: TextStyle(
                fontFamily: 'Cera Pro',
                fontWeight: FontWeight.bold,
                color: Palette.mainFontColor,
              ),
            ),
          ),
          // Suggestion List
          const Column(
            children: [
              CustomFeatureBox(
                color: Palette.firstSuggestionBoxColor,
                header: 'ChatGPT',
                description: 'A smarter way to stay organized and informed with ChatGPT',
              ),
              CustomFeatureBox(
                color: Palette.secondSuggestionBoxColor,
                header: 'Dall-E',
                description: 'Get inspired and stay creative with your personal assistant powered by Dall-E',
              ),
              CustomFeatureBox(
                color: Palette.thirdSuggestionBoxColor,
                header: 'Smart Voice Assistant',
                description: 'Get the best of both worlds with a voice assistant powered by Dall-E and ChatGPT',
              ),
            ],
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Palette.voiceAssistantButtonColor,
        onPressed: () {},
        child: const Icon(Icons.mic),
      ),
    );
  }

  String getGreeting() {
    final hour = DateTime.now().hour;

    if (hour < 12) {
      return 'Good Morning';
    } else if (hour < 17) {
      return 'Good Afternoon';
    } else if (hour < 19) {
      return 'Good Evening';
    } else {
      return 'Zzz';
    }
  }
}
