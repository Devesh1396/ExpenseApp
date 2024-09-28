import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'SignUp_Ui.dart';
import 'app_colors.dart';


class SigninUi extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          _background(),
          _loginform(context),
        ],
      ),
    );
  }

  Widget _background(){
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.primaryColor,
            Colors.white,
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          //stops: [0.1, 1],
        ),
      ),
    );
  }

  Widget _loginform(BuildContext context){
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          padding: const EdgeInsets.all(24.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20.0),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 15.0,
                spreadRadius: 5.0,
                offset: Offset(0,5),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Center(
                child: Column(
                  children: [
                    SvgPicture.asset(
                      "assets/images/Logo.svg",
                      width: 100,
                      height: 100,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Tamaru Swagat Che",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(width: 15),
                        SvgPicture.asset(
                          "assets/images/folded_hands.svg",
                          width: 30,
                          height: 30,
                        ),
                      ],
                    ),
                  ],
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
              TextField(
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.email_outlined),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                      borderSide: BorderSide(
                        color: Colors.grey,
                        width: 2,
                      )
                  ),
                  hintText: "Enter Your Email ID",
                ),
              ),
              SizedBox(height: 16.0),
              Text(
                "Password",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 5),
              TextField(
                obscureText: true,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.lock_outline),
                  suffixIcon: Icon(Icons.visibility_off_outlined),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                      borderSide: BorderSide(
                        color: Colors.grey,
                        width: 2,
                      )
                  ),
                  hintText: "Enter Your Password",
                ),
              ),
              SizedBox(height: 8),
              TextButton(
                onPressed: () {
                },
                child: Center(
                  child: Text(
                    "Forgot Password?",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: (){
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
                      "Login to Continue",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(width: 8.0),
                    Icon(Icons.login, color: Colors.white),
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
                      fontSize: 17,
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
                      "Register Now",
                      style: TextStyle(
                        color: AppColors.primaryColor,
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 1),
              _dividerText(),
              _socialIcon(context),
            ],
          ),
        ),
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
                "or",
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
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _SocialIconCont("assets/images/google.svg","Continue with Google", context),
      ],
    );
  }

  Widget _SocialIconCont(String URL, String text, BuildContext context){
    return ElevatedButton(
      onPressed: (){
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        side: BorderSide(
          color: Colors.grey,
          width: 1,
        ),
      ),
      child: Container(
        padding: const EdgeInsets.all(16.0),
        child: Stack(
          children: [
            SvgPicture.asset(
              URL,
              width: 24,
              height: 24,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 40.0),
              child: Text(
                  text,
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  )
              ),
            ),
          ],
        ),
      ),
    );
  }

}