import 'dart:async';

import 'package:avani/custom_feature_box.dart';
import 'package:avani/palette.dart';
import 'package:avani/service_openai.dart';
import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

class HomePageScreen extends StatefulWidget {
  const HomePageScreen({super.key});

  @override
  State<HomePageScreen> createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {
  final OpenAIService openAIService = OpenAIService();
  final speechToText = SpeechToText();
  String lastWords = '';
  bool isCaptionVisible = false;
  Timer? timer;
  String greeting = '';

  @override
  void initState() {
    super.initState();
    greeting = getGreeting();
    initSpeechToText();
  }

  @override
  void dispose() {
    speechToText.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AVANI'),
        leading: const Icon(Icons.menu),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
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
          ),
          // Caption overlay (YouTube-like)
          if (isCaptionVisible)
            Positioned(
              bottom: 20, // Adjust the position as needed
              left: 20,
              right: 20,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                decoration: BoxDecoration(
                  color: Palette.blackColor.withOpacity(0.7),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  lastWords,
                  style: const TextStyle(color: Palette.whiteColor, fontSize: 16),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Palette.voiceAssistantButtonColor,
        onPressed: () async {
          if (await speechToText.hasPermission && speechToText.isNotListening) {
            await startListening();
          } else if (speechToText.isListening) {
            final speech = await openAIService.isArtPromptAPI(lastWords);
            print(speech);
            await stopListening();
          } else {
            initSpeechToText();
          }
        },
        tooltip: 'Listen',
        child: Icon(speechToText.isNotListening ? Icons.mic_off : Icons.mic),
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

  Future<void> initSpeechToText() async {
    await speechToText.initialize();
    setState(() {});
  }

  Future<void> startListening() async {
    await speechToText.listen(onResult: onSpeechResult);
    setState(() {});
  }

  Future<void> stopListening() async {
    await speechToText.stop();
    setState(() {});
  }

  void onSpeechResult(SpeechRecognitionResult result) {
    setState(() {
      lastWords = result.recognizedWords;
      isCaptionVisible = true;

      // Cancel any previous timer
      timer?.cancel();

      // Hide the caption after 1 seconds
      timer = Timer(const Duration(seconds: 1), () {
        setState(() {
          isCaptionVisible = false;
        });
      });
    });
  }
}
