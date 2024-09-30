import 'dart:async';
import 'package:expense_app/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_bloc/flutter_bloc.dart'; // Import BLoC
import 'Onboard_Ui.dart';
import 'SignIn_Ui.dart';
import 'bloc/blocmd.dart';
import 'bloc/events.dart';
import 'bloc/states.dart';
import 'HomeUI.dart';

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
        // Dispatch the CheckOnboardingEvent to check onboarding and session
        context.read<UserBloc>().add(CheckOnboardingEvent());
      }
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
      body: BlocListener<UserBloc, UserState>(
        listener: (context, state) {
          if (state is OnboardingNotSeenState) {
            // Navigate to onboarding
            Navigator.pushReplacement(
              context,
              PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) => OnboardingUI(),
                transitionsBuilder: (context, animation, secondaryAnimation, child) {
                  return FadeTransition(opacity: animation, child: child);
                },
                transitionDuration: const Duration(seconds: 1),
              ),
            );
          } else if (state is UserSessionLoadedState) {
            // Navigate to home if the user session is loaded
            Navigator.pushReplacement(
              context,
              PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) => HomeUI(),
                transitionsBuilder: (context, animation, secondaryAnimation, child) {
                  return FadeTransition(opacity: animation, child: child);
                },
                transitionDuration: const Duration(seconds: 1),
              ),
            );
          } else if (state is UserErrorState) {
            // No session found, navigate to sign-in screen
            Navigator.pushReplacement(
              context,
              PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) => SigninUi(),
                transitionsBuilder: (context, animation, secondaryAnimation, child) {
                  return FadeTransition(opacity: animation, child: child);
                },
                transitionDuration: const Duration(seconds: 1),
              ),
            );
          }
        },
        child: Stack(
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
      ),
    );
  }
}
