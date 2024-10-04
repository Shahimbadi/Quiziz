import 'package:flutter/material.dart';
import 'package:quiziz/screen2/categoryPage.dart';
import 'package:quiziz/screen2/loginPage.dart';

class QuizizHomePage extends StatefulWidget {
  const QuizizHomePage({super.key});

  @override
  State<QuizizHomePage> createState() => _QuizizHomePageState();
}

class _QuizizHomePageState extends State<QuizizHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.only(top: 100,left: 70,right: 70),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Text("Quiz!z",style: TextStyle(
                fontFamily: "genos",
                fontSize: 59,
                color: Colors.lightGreen,
              ),),
              const SizedBox(height: 300,),
              Padding(
                padding: const EdgeInsets.all(10),
                child: ElevatedButton(onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> CategoryPage()));
                },
                  style: ElevatedButton.styleFrom(minimumSize: const Size(240, 67),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16)
                      ),
                      backgroundColor: Colors.lightGreen), child: const Text("Let's Play",style: TextStyle(fontSize: 26,fontFamily: "genos",
                    color: Colors.black
                ),),),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: OutlinedButton(onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>const LoginScreen()));
                },
                  style: OutlinedButton.styleFrom(minimumSize: const Size(240, 67),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16)
                    ),
                  ), child: const Text("Log Out",style: TextStyle(fontSize: 26,fontFamily: "genos",
                    color: Colors.lightGreen
                ),),),
              )
            ],
          ),
        ),
      ),
    );
  }
}