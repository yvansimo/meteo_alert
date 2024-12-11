import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('Background.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(30),
            child: ListView(
              children: <Widget>[
                Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(30),
                  child: const Text(
                    'Se Connecter',
                    style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.w500,
                        fontSize: 30),
                  )
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  child: TextField(
                    controller: usernameController,
                    decoration: const InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.black,
                          width: 2,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.black, // Bordure quand le champ est en focus (noir)
                          width: 2,
                        ),
                      ),
                      labelText: 'Email',
                      labelStyle: TextStyle(color: Colors.black),
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                  child: TextField(
                    obscureText: true,
                    controller: passwordController,
                    decoration: const InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.black,
                          width: 2,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.black, // Bordure quand le champ est en focus (noir)
                          width: 2,
                        ),
                      ),
                      labelText: 'Password',
                      labelStyle: TextStyle(color: Colors.black),
                    ),
                  ),
                ),
                Container(
                    height: 50,
                    margin: const EdgeInsets.fromLTRB(90, 30, 90, 30),
                    child: ElevatedButton(
                      child: const Text(
                        'Login',
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                      onPressed: () {
                        print(usernameController.text);
                        print(passwordController.text);
                      },
                    )
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Text(
                      'Pas de compte?',
                      style: TextStyle(
                        color: Colors.white
                      ),
                    ),
                    TextButton(
                      child: const Text(
                        'Inscris toi',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                        ),
                      ),
                      onPressed: () {
                        //signup screen
                      },
                    )
                  ],  
                ),
              ],
            ),
          ),
        ],
      ),
      
    );
  }
}