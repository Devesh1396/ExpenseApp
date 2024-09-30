import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'HomeUI.dart';
import 'app_colors.dart';
import 'bloc/blocmd.dart';
import 'bloc/events.dart';
import 'bloc/states.dart';
import 'customback_button.dart';


class SignUpUi extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
  }

  class _SignUpState extends State<SignUpUi> {

  TextEditingController unameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  void registerUser() {
    String username = unameController.text;
    String email = emailController.text;
    String password = passwordController.text;

    // Dispatch the AddUserEvent to the UserBloc
    context.read<UserBloc>().add(
      AddUserEvent(username: username, email: email, password: password),
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: customBackWidget2(),
        backgroundColor: Colors.white,
      ),
      body: Container(
        child: _registerUI(context),
      ),

    );
  }

  Widget _registerUI(BuildContext context){

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Center(
              child: Column(
                children: [
                  Text(
                    "Create Account",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'customFont',
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Fill your information below or register with your social account",
                    style: TextStyle(
                      color: Colors.black.withOpacity(0.8),
                      fontSize: 17,
                      fontFamily: 'customFont',
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),

            _textfieldLabel(text: "Name"),
            SizedBox(height: 5),
            _Textfield(controller: unameController, text: "Enter Your Name"),
            SizedBox(height: 20),

            _textfieldLabel(text: "Email"),
            SizedBox(height: 5),
            _Textfield(controller: emailController, text: "Enter Your Email ID"),
            SizedBox(height: 20),

            _textfieldLabel(text: "Password"),
            SizedBox(height: 5),
            _Textfield(controller: passwordController, text: "Enter Your Password", icon: Icons.visibility_off_outlined),
            SizedBox(height: 20),

            ElevatedButton(
              onPressed: (){
                registerUser();
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
                    "Explore Now",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'customFont',
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 1),
            _dividerText(),
            _socialIcon(context),
            BlocListener<UserBloc, UserState>(
              listener: (context, state) {
                if (state is UserLoadingState) {
                } else if (state is UserSessionLoadedState) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Registration successful'),
                      backgroundColor: Colors.green,
                    ),
                  );
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => HomeUI()),
                  );
                } else if (state is UserErrorState) {
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
    );
  }

  Widget _textfieldLabel({
    required String text,
  }){
    return Text(
      text,
      style: TextStyle(
        fontSize: 16,
        color: Colors.black,
      ),
    );
  }

  Widget _Textfield({
    required TextEditingController controller,
    required String text,
    TextInputType keyboardType = TextInputType.text,
    IconData? icon,
  }){
    return TextField(
        controller: controller,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          suffixIcon: Icon(icon),
          hintText: text,
          contentPadding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
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
        )
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
                "or sign up with",
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