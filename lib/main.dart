import 'package:flutter/material.dart';
import 'package:sample_stt/button.dart';
import 'package:sizer/sizer.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) => MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: MyHomePage(title: 'Speech to text demo error'),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  SpeechToText speech = SpeechToText();

  @override
  void initState() {
    start();
    super.initState();
  }

  Future<void> start() async {
    await speech.initialize(
      onStatus: print,
      onError: print,
      finalTimeout: Duration(milliseconds: 0),
    );
  }

  Future<void> startListening() async {
    await speech.listen(
      onResult: resultListener,
      localeId: "en_GB",
      cancelOnError: true,
      listenMode: ListenMode.search,
      pauseFor: Duration(seconds: 3),
    );
  }

  void resultListener(SpeechRecognitionResult result) {
    print(result);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: CustomButton(
          height: 25.w,
          width: 25.w,
          backgroundColor: Color(0xFFE88FFD),
          shadowColor: Color(0xFFD965F4),
          child: Container(
            width: 30.w,
            child: Icon(Icons.mic_outlined, size: 40.sp, color: Colors.white),
          ),
          onPressed: startListening,
        ),
      ),
    );
  }
}
