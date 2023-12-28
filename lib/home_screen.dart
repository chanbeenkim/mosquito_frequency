import 'package:flutter/material.dart';
import 'package:surround_sound/surround_sound.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _controller = SoundController();

  bool isRunning = false;

  void onStartPressed() async {
    await _controller.play();
    setState(() {
      isRunning = true;
    });
  }

  void onStopPressed() async {
    await _controller.stop();
    setState(() {
      isRunning = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          "Mosquito frequency",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SoundWidget(
            soundController: _controller,
          ),
          SizedBox(
            height: 160,
            width: 160,
            child: Image.asset(
              "assets/images/mosquito.png",
            ),
          ),
          const SizedBox(
            height: 60,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                iconSize: 80,
                onPressed: isRunning ? onStopPressed : onStartPressed,
                icon: Icon(
                  isRunning ? Icons.stop_circle : Icons.play_circle_fill,
                  color: Colors.red.shade700,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 18,
          ),
          ValueListenableBuilder(
            valueListenable: _controller,
            builder: (context, value, _) {
              return Column(
                children: [
                  const Text(
                    "Volume",
                    style: TextStyle(fontWeight: FontWeight.w800),
                  ),
                  Slider(
                    thumbColor: Colors.black,
                    activeColor: Colors.red,
                    inactiveColor: Colors.grey,
                    value: value.volume,
                    min: 0,
                    max: 1,
                    onChanged: (val) {
                      _controller.setVolume(val);
                    },
                  ),
                  const Text("Frequency",
                      style: TextStyle(fontWeight: FontWeight.w800)),
                  Slider(
                    thumbColor: Colors.black,
                    activeColor: Colors.red,
                    inactiveColor: Colors.grey,
                    value: value.freq,
                    min: 128,
                    max: 1500,
                    onChanged: (val) {
                      _controller.setFrequency(val);
                    },
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
