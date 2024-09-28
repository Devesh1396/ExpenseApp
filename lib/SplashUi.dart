import 'dart:async';
import 'package:expense_app/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Onboard_Ui.dart';
import 'SignIn_Ui.dart';


class SplashUI extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashUI> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    // Animation Controller & Animation Initialization
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    );

    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeIn);

    // Start animation
    _controller.forward();

    // Add listener for animation completion
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _navigateAfterAnimation();
      }
    });
  }

  // Function to handle navigation after animation
  Future<void> _navigateAfterAnimation() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool hasSeenOnboarding = prefs.getBool('hasSeenOnboarding') ?? false;

    // Introduce a small delay before navigating
    Future.delayed(const Duration(seconds: 1), () {
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) =>
          hasSeenOnboarding ? SigninUi() : OnboardingUI(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(opacity: animation, child: child);
          },
          transitionDuration: const Duration(seconds: 1),
        ),
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        fit: StackFit.expand,
        children: [
          Container(
            color: AppColors.secondaryColor.withOpacity(0.2),
          ),
          Center(
            child: FadeTransition(
              opacity: _animation,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    "assets/images/app_logo.svg",
                    width: 80,
                    height: 80,
                    fit: BoxFit.contain,
                  ),
                  const SizedBox(height: 20),
                  Text(
                    "SPENDMATE",
                    style: TextStyle(
                      fontSize: 24,
                      fontFamily: 'customFont',
                      fontWeight: FontWeight.bold,
                      color: AppColors.primaryColor,
                      letterSpacing: 2.0,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}