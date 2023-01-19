import 'package:flutter/material.dart';
import 'dart:async';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'STOPWATCH',
        home: StopwatchApp(),
        debugShowCheckedModeBanner: false,
    );
  }
}

class StopwatchApp extends StatefulWidget {
  @override
  _StopwatchAppState createState() => _StopwatchAppState();
}

class _StopwatchAppState extends State<StopwatchApp> {

  String timeString = "00:00:00";
  Stopwatch stopwatch = Stopwatch();
  late Timer timer;

  void start(){
    stopwatch.start();
    timer = Timer.periodic(Duration(milliseconds: 1), update);
  }

  void update(Timer t){
    if(stopwatch.isRunning){
      setState(() {
        timeString =
            (stopwatch.elapsed.inMinutes % 60).toString().padLeft(2, "0") + ":" +
                (stopwatch.elapsed.inSeconds % 60).toString().padLeft(2, "0") + ":" +
                (stopwatch.elapsed.inMilliseconds % 1000 / 10).clamp(0, 99).toStringAsFixed(0).padLeft(2, "0");
      });

    }
  }

  void stop(){
    setState(() {
      timer.cancel();
      stopwatch.stop();
    });

  }

  void reset(){
    timer.cancel();
    stopwatch.reset();
    setState((){
      timeString = "00:00:00";

    });
    stopwatch.stop();
  }

  @override
  Widget build(BuildContext context) {
    Size size=MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: Colors.grey.shade200,
        appBar: AppBar(
          title: const Text('STOPWATCH'),
        ),
        body: Column(
          children: <Widget>[
            Expanded(
              child: Container(
                width: 280,
                height: 280,
                decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                          offset: Offset(10, 10),
                          color: Colors.blue,
                          blurRadius: 20),
                      BoxShadow(
                          offset: Offset(-10, -10),
                          color: Colors.white.withOpacity(0.85),
                          blurRadius: 15)
                    ]),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(Icons.timer, size: 90, color: Colors.blue),
                    Text(timeString,
                        style: TextStyle(
                            fontSize: 40,
                            color: Colors.blue,
                        )
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 60),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                   TextButton(
                      onPressed: reset,
                      child: Container(
                        height: 100,
                        width: 100,
                        decoration: BoxDecoration(
                            color: Colors.grey.shade200,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                  offset: Offset(10, 10),
                                  color: Colors.red,
                                  blurRadius: 15),
                              BoxShadow(
                                  offset: Offset(-10, -10),
                                  color: Colors.white.withOpacity(0.85),
                                  blurRadius: 15)
                            ]),
                        child: Icon(Icons.refresh, size: 60,
                        color: Colors.red,),
                      )
                  ),
                  TextButton(
                      onPressed: (){
                        stopwatch.isRunning ? stop() : start();
                      },
                      child: Container(
                        height: 100,
                        width: 100,
                        decoration: BoxDecoration(
                            color: Colors.grey.shade200,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                  offset: Offset(10, 10),
                                  color: Colors.red,
                                  blurRadius: 15),
                              BoxShadow(
                                  offset: Offset(-10, -10),
                                  color: Colors.white.withOpacity(0.85),
                                  blurRadius: 10)
                            ]),
                        child: Icon(stopwatch.isRunning ? Icons.pause : Icons.play_arrow, size: 60,color: Color.lerp(Colors.blue, Colors.red, 2)),
                      )
                  )
                ],
              ),
            )
          ],
        )
    );
  }
}