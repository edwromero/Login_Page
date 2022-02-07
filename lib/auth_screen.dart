import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:login/constant.dart';
import 'package:login/widgets/loginForm.dart';
import 'package:login/widgets/singup_form.dart';

import 'widgets/social_button.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> with SingleTickerProviderStateMixin {
  bool _isShowSingUp = false;
 late  AnimationController _animationController;
 late Animation<double> _animationTextRotate;
 
 
 void setUpAnimation () {
   _animationController = AnimationController(vsync: this,duration:defaultDuration );
   _animationTextRotate= Tween<double>(begin:0, end:90).animate(_animationController);
 }

 void updateView(){
   setState(() {
     _isShowSingUp = !_isShowSingUp;
   });
   _isShowSingUp ? _animationController.forward(): _animationController.reverse();
 }
 @override
  void initState() {
   setUpAnimation();
    super.initState();
  }
  @override
  void dispose() {
    _animationController.dispose();
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;
    return Scaffold(
      body: AnimatedBuilder(
        animation: _animationController,
        builder: (context,_) {
          return Stack(
            children: [
              AnimatedPositioned(
                duration: defaultDuration,
                width: _size.width *0.88,
                height: _size.height,
                left: _isShowSingUp ? -_size.width * 0.76 : _size.width * 0,
                child: Container(
                  color: login_bg,
                  child: LoginForm(),
                ),
              ),
              AnimatedPositioned(
                  duration: defaultDuration,
                  height: _size.height,
                  width: _size.width * 0.88,
                  left: _isShowSingUp ? _size.width * 0.12 : _size.width * 0.88 ,
                  child: Container(
                    color: signup_bg,
                    child: SingUpForm(),
                  )),
              AnimatedPositioned(
                duration: defaultDuration,
                top: _size.height * 0.1,
                left: 0,
                right: _isShowSingUp ? - _size.width * 0.06 : _size.width * 0.06  ,
                child: CircleAvatar(
                  radius: 25,
                  backgroundColor: Colors.white60,
                  child: AnimatedSwitcher(
                      duration: defaultDuration,
                      child: _isShowSingUp ?
                      SvgPicture.asset("assets/animation_logo.svg", color: signup_bg,)
                          : SvgPicture.asset("assets/animation_logo.svg", color: login_bg,),
                    ),
                ),
              ),
              AnimatedPositioned(
                duration: defaultDuration,
                width: _size.width,
                bottom: _size.height * 0.1,
                right: _isShowSingUp ? - _size.width * 0.06 : _size.width * 0.06 ,
                child: SocialButton(),
              ),
              AnimatedPositioned(
                duration: defaultDuration,
                bottom:_isShowSingUp ? _size.height / 2 - 80: _size.height * 0.3,
                left: _isShowSingUp ? 0:_size.width * 0.44 - 80,
                child: AnimatedDefaultTextStyle(
                  duration: defaultDuration,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: _isShowSingUp ? 20 :32,
                    fontWeight: FontWeight.bold,
                    color: _isShowSingUp ? Colors.white : Colors.white70,
                  ),
                  child: Transform.rotate(
                    angle: -_animationTextRotate.value * pi /180,
                    alignment: Alignment.topLeft,
                    child:InkWell(
                      onTap: (){
                        if(_isShowSingUp){
                          updateView();
                        }else{

                        }
                      },
                      child: Container(
                        padding: const  EdgeInsets.symmetric(vertical: defaultPadding * 0.75) ,
                        width: 160,
                        child: Text(
                          "Log in".toUpperCase(),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              AnimatedPositioned(
                duration: defaultDuration,
                bottom: !_isShowSingUp ? _size.height / 2 - 80 : _size.height * 0.3,
                right: _isShowSingUp ?_size.width * 0.44 - 80 : 0,
                child: AnimatedDefaultTextStyle(
                  duration: defaultDuration,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: ! _isShowSingUp ? 20 :32,
                    fontWeight: FontWeight.bold,
                    color: _isShowSingUp ? Colors.white : Colors.white70,
                  ),
                  child: Transform.rotate(
                    angle: (90 -_animationTextRotate.value) * pi /180,
                    alignment: Alignment.topRight,
                    child:InkWell(
                      onTap: (){
                        if(_isShowSingUp){

                        }else{
                          updateView();
                        }
                      },
                      child: Container(
                        padding: const  EdgeInsets.symmetric(vertical: defaultPadding * 0.75) ,
                        width: 160,
                        child: Text(
                          "Sign Up".toUpperCase(),
                        ),
                      ),
                    ),
                  ),
                ),
              ),



            ],

          );

        },
      )
    );
  }
}

