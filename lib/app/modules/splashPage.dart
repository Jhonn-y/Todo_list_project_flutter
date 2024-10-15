import 'package:flutter/material.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Splash Screen'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(onPressed: (){
                Navigator.of(context).pushNamed('/login');
              }, child: Text('Login'),
            ), 
                SizedBox(height: 10),
            ElevatedButton(onPressed: (){
              Navigator.of(context).pushNamed('/register');
            }, child: Text('Register'),),
          ],
            ),
      ),
    );
  }
}