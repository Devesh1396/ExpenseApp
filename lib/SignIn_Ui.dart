import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'HomeUI.dart';
import 'SignUp_Ui.dart';
import 'app_colors.dart';
import 'bloc/blocmd.dart';
import 'bloc/events.dart';
import 'bloc/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class SigninUi extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

  class _SignInState extends State<SigninUi> {

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  void loginUser() {
    String email = emailController.text;
    String password = passwordController.text;

    // Dispatch FetchUserEvent to the UserBloc
    context.read<UserBloc>().add(
      FetchUserEvent(email: email, password: password),
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          _loginform(context),
        ],
      ),
    );
  }

  Widget _loginform(BuildContext context){
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Center(
                child: Column(
                  children: [
                    Text(
                      "SPENDMATE",
                      style: TextStyle(
                        fontSize: 22,
                        fontFamily: 'customFont',
                        fontWeight: FontWeight.bold,
                        color: AppColors.primaryColor,
                        letterSpacing: 2.0,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      "Expense Tracking Made Easy",
                      style: TextStyle(
                        color: Colors.black.withOpacity(0.8),
                        fontSize: 18,
                        fontFamily: 'customFont',
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 40),
              Center(
                child: Text(
                  "Sign In",
                  style: TextStyle(
                    color: Colors.black.withOpacity(0.9),
                    fontSize: 18,
                    fontFamily: 'customFont',
                    fontWeight: FontWeight.bold
                  ),
                ),
              ),

              SizedBox(height: 20),
              Text(
                "Email Address",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 5),
              _customTextField(
                controller: emailController,
                hintText: 'Enter Your Email ID',
                prefix_icon: Icons.email_outlined,
              ), // Optional suffix icon
              SizedBox(height: 16.0),
              _customTextField(
                controller: passwordController,
                hintText: 'Enter Your Password',
                prefix_icon: Icons.lock_outline,
                suffix_icon: Icons.visibility_off_outlined,
                obscureText: true,
              ),
              SizedBox(height: 8),

              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                  },
                  child: Text(
                    "Forgot Password?",
                    style: TextStyle(
                      color: Colors.black.withOpacity(0.7),
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                  style: ButtonStyle(
                    overlayColor: WidgetStateProperty.all(Colors.transparent),
                  ),
                ),
              ),
              SizedBox(height: 20),

              ElevatedButton(
                onPressed: (){
                  loginUser();
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryColor,
                    padding: EdgeInsets.symmetric(vertical:20.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    )
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Sign in to Continue",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontFamily: 'customFont',
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don't have an account?",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextButton(onPressed: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SignUpUi()),
                    );
                  },
                    child: Text(
                      "Sign Up",
                      style: TextStyle(
                        color: AppColors.primaryColor,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    style: ButtonStyle(
                      overlayColor: WidgetStateProperty.all(Colors.transparent),
                    ),
                  ),
                ],
              ),

              SizedBox(height: 1),
              _dividerText(),
              _socialIcon(context),

              // BlocListener to handle login states
              BlocListener<UserBloc, UserState>(
                listener: (context, state) {
                  if (state is UserLoadingState) {
                    // Optionally show a loading indicator
                  } else if (state is UserFetchedState) {
                    // Login successful
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Login successful!'),
                        backgroundColor: Colors.green,
                      ),
                    );
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => HomeUI()),
                    );
                  } else if (state is UserErrorState) {
                    // Show error message
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(state.message),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                },
                child: Container(), // Placeholder widget
              ),

            ],
          ),
        ),
      ),
    );
  }

  Widget _customTextField({
    required TextEditingController controller,
    required String hintText,
    bool obscureText = false,
    IconData? prefix_icon,
    IconData? suffix_icon,
  }) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        prefixIcon: Icon(prefix_icon),
        suffixIcon: Icon(suffix_icon),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0),
          borderSide: BorderSide(
            color: Colors.grey.withOpacity(0.4),
            width: 2,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0),
          borderSide: BorderSide(
            color: Colors.black.withOpacity(0.5),
            width: 2,
          ),
        ),
        hintText: hintText,
      ),
    );
  }


  Widget _dividerText(){
    return Padding(
        padding: const EdgeInsets.all(24.0),
        child: Row(
          children: [
            Expanded(
              child: Divider(
                color: Colors.grey,
                thickness:1,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                "or sign in with",
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 12,
                ),
              ),
            ),
            Expanded(
              child: Divider(
                color: Colors.grey,
                thickness: 1,
              ),
            ),
          ],
        )
    );
  }

  Widget _socialIcon(BuildContext context){
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _socialIconCont("assets/images/google.svg", context),
        _socialIconCont("assets/images/facebook.svg", context),
        _socialIconCont("assets/images/apple.svg", context),
      ],
    );
  }

  Widget _socialIconCont(String URL, BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        // Add your onPressed logic here
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        shape: CircleBorder(), // Make the button circular
        side: BorderSide(
          color: Colors.grey,
          width: 1,
        ),
        padding: EdgeInsets.all(16.0), // Adjust padding for icon inside
      ),
      child: SvgPicture.asset(
        URL,
        width: 24,
        height: 24,
      ),
    );
  }


}