import 'dart:async';
import 'dart:math';

import 'package:covid_app/View/world_statas_screen.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late final AnimationController _controller =
      AnimationController(vsync: this, duration: const Duration(seconds: 3))
        ..repeat();
  @override
  void initState() {
    super.initState();

    Timer(const Duration(seconds: 5), () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) {
          return const WorldStatasScreen();
        }),
      );
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // print(MediaQuery.of(context).size.width);
    // print(MediaQuery.of(context).size.height);
    return Scaffold(
     
      backgroundColor: const Color.fromARGB(17, 41, 38, 38),
      body: Column(
        
        
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: AnimatedBuilder(
              animation: _controller,
              child: Container(
                //color: Colors.green,
                width: MediaQuery.of(context).size.width * 0.521,
                height: MediaQuery.of(context).size.height * 0.249,
                child: const Image(image: AssetImage('images/virus.png')),
              ),
              builder: (context, child) {
                return Transform.rotate(
                  angle: _controller.value * 2.0 * pi,
                  child: child,
                );
              },
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.049,
          ),
          const Align(
            alignment: Alignment.center,
            child: Text(
              'Covid_19 \n Tracker App',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 25, 
              color: Colors.white,
              fontWeight: FontWeight.bold),
            ),
          )
        ],
      ),
    );
  }
}
