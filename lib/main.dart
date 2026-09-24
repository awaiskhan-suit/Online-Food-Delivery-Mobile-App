import 'package:flutter/material.dart';
import 'package:online_delivery/product.dart' hide LoginScreen; // pizza/product screen
import 'package:online_delivery/signup.dart';  // signup screen
import 'SignIn.dart';                          // login screen
import 'Splash_screen.dart';
import 'cart_screen.dart';                   // splash screen

void main() {
  runApp(FlutterApp());
}

class FlutterApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Flutter Demo",
      theme: ThemeData(primarySwatch: Colors.red),
      home: SplashScreen(), // splash shows first
    );
  }
}

class MyHomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Main Page", style: TextStyle(color: Colors.white)),
      ),
      body: ListView(
        padding: const EdgeInsets.all(12),
        children: [
          Row(
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (_) => SignUpScreen()));
                },
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                child: const Text('SignUp', style: TextStyle(color: Colors.white)),
              ),
              const SizedBox(width: 10),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (_) =>
                      LoginScreen(),));
                },
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                child: const Text('SignIn', style: TextStyle(color: Colors.white)),
              ),
              const Spacer(),
              IconButton(onPressed: ()=> {

                Navigator.push(context, MaterialPageRoute(builder: (context)=>CartScreen())),



              }, icon: const Icon(Icons.add_shopping_cart)),
            ],
          ),
          const SizedBox(height: 10),
          Image.asset('assets/images/main.jpeg'),
          const SizedBox(height: 10),
          const Text("About Us", style: TextStyle(fontSize: 30, color: Colors.red)),
          const SizedBox(height: 12),
          const Text(
            "Our online food delivery app is designed to make eating easier, faster, "
                "and more enjoyable. We bring your favorite meals directly to your "
                "doorstep with just a few taps. Whether you’re craving traditional dishes "
                "or international cuisines, we’ve got you covered. With a user-friendly "
                "interface, secure payment options, and real-time order tracking, we "
                "ensure a smooth and reliable experience.",
            textAlign: TextAlign.justify,
            style: TextStyle(fontSize: 15),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (_) => PizzaScreen ()));
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text("Next", style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}
