import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart'; // Color picker package

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FadingTextAnimation(),
    );
  }
}

class FadingTextAnimation extends StatefulWidget {
  @override
  _FadingTextAnimationState createState() => _FadingTextAnimationState();
}

class _FadingTextAnimationState extends State<FadingTextAnimation> {
  bool _isVisible = true;
  bool _isDayMode = true;
  bool _showFrame = false; // To toggle frame visibility
  Color _textColor = Colors.black; // Default text color

  void toggleVisibility() {
    setState(() {
      _isVisible = !_isVisible;
    });
  }

  void toggleDayNightMode() {
    setState(() {
      _isDayMode = !_isDayMode;
    });
  }

  // Function to open the color picker
  Future<void> pickColor() async {
    Color pickedColor = await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Pick a Color'),
          content: ColorPicker(
            pickerColor: _textColor,
            onColorChanged: (color) {
              setState(() {
                _textColor = color;
              });
            },
            showLabel: true,
            pickerAreaHeightPercent: 0.8,
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Select'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Fading Text Animation'),
        actions: [
          // Day/Night Mode Toggle
          IconButton(
            icon: Icon(_isDayMode ? Icons.wb_sunny : Icons.nightlight_round),
            onPressed: toggleDayNightMode,
          ),
          // Color Picker
          IconButton(
            icon: Icon(Icons.palette),
            onPressed: pickColor,
          ),
        ],
      ),
      body: GestureDetector(
        onTap: toggleVisibility,
        child: Center(
          child: AnimatedOpacity(
            opacity: _isVisible ? 1.0 : 0.0,
            duration: Duration(milliseconds: 1500),
            curve: Curves.elasticInOut,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Owl Image', 
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: _textColor),
                ),
                SizedBox(height: 10),
                Container(
                  decoration: BoxDecoration(
                    border: _showFrame ? Border.all(color: Colors.blue, width: 5) : null,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Image.network(
                    'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg',
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: toggleVisibility,
        child: Icon(Icons.play_arrow),
      ),
      // Switch to toggle the frame on/off
      bottomSheet: Container(
        padding: EdgeInsets.all(10),
        child: Row(
          children: [
            Text('Show Frame'),
            Switch(
              value: _showFrame,
              onChanged: (bool value) {
                setState(() {
                  _showFrame = value;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}

class SecondFadingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Second Fading Animation')),
      body: Center(
        child: AnimatedOpacity(
          opacity: 1.0,
          duration: Duration(milliseconds: 3000), // Different duration for fading
          curve: Curves.easeInOut,
          child: Text(
            'Second Screen Fade',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
