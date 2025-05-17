import 'dart:async';
import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'home_page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    Timer(
      const Duration(seconds: 3),
          () => Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomePage()),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final Size mq = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.deepPurple,
      body: SafeArea(
        child: Column(
          children: [
            const Spacer(flex: 3),

            FadeInUp(
              delay: const Duration(milliseconds: 300),
              child: Text(
                'JobEase',
                textAlign: TextAlign.center,
                style: GoogleFonts.wellfleet(
                  fontSize: 64,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 5,
                ),
              ),
            ),

            const SizedBox(height: 12),

            FadeInUp(
              delay: const Duration(milliseconds: 500),
              child: Text(
                'Find your dream job with ease',
                style: GoogleFonts.montserrat(
                  fontSize: 18,
                  color: Colors.white70,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),

            const Spacer(flex: 3),

            BounceInUp(
              delay: const Duration(milliseconds: 800),
              child: SpinKitThreeBounce(
                color: Colors.white,
                size: 40,
              ),
            ),

            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
