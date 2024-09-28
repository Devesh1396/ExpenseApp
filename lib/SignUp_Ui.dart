import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'app_colors.dart';
import 'customback_button.dart';


class SignUpUi extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                AppColors.primaryColor,
                Colors.white,
              ],
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              //stops: [0.1, 1],
            ),
          ),
          child:
          Stack(
            children: [
              _registerUI(context),
            ],
          )
      ),

    );
  }

  Widget _registerUI(BuildContext context){

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          padding: const EdgeInsets.all(16.0),
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  customBackWidget(),
                  Padding(
                    padding: const EdgeInsets.only(top:10.0),
                    child: SvgPicture.asset(
                      "assets/images/Logo.svg",
                      width: 100,
                      height: 100,
                    ),
                  ),
                ],
              ),
              Center(
                child: Column(
                  children: [
                    Text(
                      "Create Account",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 15),

              _textfieldLabel(text: "Name"),
              SizedBox(height: 5),
              _Textfield(text: "Enter Your Name"),
              SizedBox(height: 20),

              _textfieldLabel(text: "Email"),
              SizedBox(height: 5),
              _Textfield(text: "Enter Your Email ID"),
              SizedBox(height: 20),

              _textfieldLabel(text: "Password"),
              SizedBox(height: 5),
              _Textfield(text: "Enter Your Password", icon: Icons.visibility_off_outlined),
              SizedBox(height: 20),

              _textfieldLabel(text: "Contact"),
              SizedBox(height: 5),
              _Textfield(text: "Enter Your Mobile Number", keyboardType: TextInputType.phone),
              SizedBox(height: 25),

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
                      "Explore Now",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(width: 8.0),
                    Icon(Icons.double_arrow_outlined, color: Colors.white),
                  ],
                ),
              ),
            ],
          ),
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
    required String text,
    TextInputType keyboardType = TextInputType.text,
    IconData? icon,
  }){
    return TextField(
        keyboardType: keyboardType,
        decoration: InputDecoration(
          suffixIcon: Icon(icon),
          hintText: text,
          contentPadding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0),
            borderSide: BorderSide(color: Colors.grey.withOpacity(0.5), width: 2.0),
          ),
        )
    );
  }

}