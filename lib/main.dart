import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false, // Removes the red "Debug" banner
    home: SpeedGun(),
  ));
}

class SpeedGun extends StatefulWidget {
  const SpeedGun({super.key}); // Added key for better performance

  @override
  State<SpeedGun> createState() => _SpeedGunState();
}

class _SpeedGunState extends State<SpeedGun> {
  final Stopwatch _stopwatch = Stopwatch();
  double _speed = 0.0;
  final double _pitchLength = 20.12; // 22 yards in meters

  void _handleTap() {
    setState(() {
      if (!_stopwatch.isRunning) {
        _stopwatch.start();
      } else {
        _stopwatch.stop();
        // Calculate time
        double seconds = _stopwatch.elapsedMilliseconds / 1000;
        
        // Safety check to avoid infinite speed
        if (seconds > 0.1) {
          _speed = (_pitchLength / seconds) * 3.6;
        }
        
        _stopwatch.reset();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100], // Light background for better look
      appBar: AppBar(
        title: const Text("Cricket Speed Gun"),
        backgroundColor: Colors.blueAccent,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Last Ball Speed:", style: TextStyle(fontSize: 22)),
            const SizedBox(height: 10),
            Text(
              "${_speed.toStringAsFixed(1)} km/h",
              style: TextStyle(
                fontSize: 64, // Bigger font for speed
                fontWeight: FontWeight.bold,
                color: _speed > 140 ? Colors.red : Colors.green, // Visual cue for fast balls
              ),
            ),
            const SizedBox(height: 60),
            GestureDetector(
              onTap: _handleTap,
              child: Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  color: _stopwatch.isRunning ? Colors.red : Colors.blueAccent,
                  shape: BoxShape.circle, // Circular button looks better for sports apps
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 10,
                      offset: Offset(0, 5),
                    ),
                  ],
                ),
                child: Center(
                  child: Text(
                    _stopwatch.isRunning ? "TAP ON\nIMPACT" : "TAP ON\nRELEASE",
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
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