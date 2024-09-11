


import 'package:chatbot/colors.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import 'chat.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors().black,

body: Container(
  width: MediaQuery.of(context).size.width,
  height: MediaQuery.of(context).size.height,
decoration: BoxDecoration(
gradient: RadialGradient(
  colors: [

    MyColors().gry.withOpacity(0.5),

    MyColors().black,
  ]
)

),
child: Column(
  mainAxisAlignment: MainAxisAlignment.center,
  children: [
    Text("مرحبا بك",style: TextStyle(
        color: Colors.white,
        fontSize: 30,
        fontWeight: FontWeight.bold
    ),),
    SizedBox(height: 20,),

    Lottie.asset("assets/robot.json",height: 200,width: 200, ),

    SizedBox(height: 20,),
    Text("أنا مساعدك الشخصي بإمكاني الدردشة معك"
      ,style: TextStyle(
      color: Colors.white,
      fontSize: 20,
      fontWeight: FontWeight.bold
    ),),
    SizedBox(height: 50,),
  IconButton(
    padding: EdgeInsets.all(10),
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(Colors.white),
        shape: MaterialStateProperty.all(RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(1000)
        ))
      ),
      onPressed: (){
      Navigator.push(context, MaterialPageRoute(builder: (_)=>ChatScreen()));
      }, icon: Icon(Icons.arrow_forward_ios,color: Colors.black,size: 30,))
  ],

),
),

    );
  }
}
