import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:Bibliotheque/screens/register_page.dart';
import 'package:Bibliotheque/screens/home_screen.dart';

class LoginPage extends StatefulWidget {
  final bool? successfulRegistration;

  const LoginPage({Key? key, this.successfulRegistration}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String errorMessage = '';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Container(
          margin: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _header(),
                _inputField(),
                Text(
                  errorMessage,
                  style: TextStyle(color: Colors.red),
                ),
                _signup(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _header() {
    return Column(
      children: [
        const Text(
          "Bienvenue",
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        widget.successfulRegistration == true
            ? Text(
          "Inscription réussie ! Connectez-vous maintenant",
          style: TextStyle(fontSize: 15, color: Colors.green),
        )
            : Text(
          "Entrez vos identifiants pour vous connecter",
          style: TextStyle(fontSize: 15),
        ),
      ],
    );
  }

  Widget _inputField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TextFormField(
          controller: emailController,
          keyboardType: TextInputType.emailAddress,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Veuillez entrer votre adresse e-mail';
            } else if (!RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$').hasMatch(value)) {
              return 'Veuillez entrer une adresse e-mail valide';
            }
            return null;
          },
          decoration: InputDecoration(
            hintText: "Adresse e-mail",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(18),
              borderSide: BorderSide.none,
            ),
            fillColor: Colors.blue.withOpacity(0.1),
            filled: true,
            prefixIcon: const Icon(Icons.person),
          ),
        ),
        const SizedBox(height: 10),
        TextFormField(
          controller: passwordController,
          obscureText: true,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Veuillez entrer votre mot de passe';
            }
            return null;
          },
          decoration: InputDecoration(
            hintText: "Mot de passe",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(18),
              borderSide: BorderSide.none,
            ),
            fillColor: Colors.blue.withOpacity(0.1),
            filled: true,
            prefixIcon: const Icon(Icons.password),
          ),
        ),
        const SizedBox(height: 30),
        ElevatedButton(
          onPressed: () async {
            FocusScope.of(context).unfocus();
            setState(() {
              errorMessage = ''; // Clear previous error messages
            });

            if (_formKey.currentState?.validate() ?? false) {
              try {
                await FirebaseAuth.instance.signInWithEmailAndPassword(
                  email: emailController.text,
                  password: passwordController.text,
                );

                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => HomeScreen()),
                );
              } on FirebaseAuthException {
                setState(() {
                  errorMessage = 'Identifiants invalides. Veuillez réessayer.';
                });
              }
            }
          },
          style: ElevatedButton.styleFrom(
            shape: const StadiumBorder(),
            padding: const EdgeInsets.symmetric(vertical: 16),
            backgroundColor: Colors.blue,
          ),
          child: const Text(
            "Connexion",
            style: TextStyle(fontSize: 20, color: Colors.black),
          ),
        )
      ],
    );
  }

  Widget _signup() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Vous n'avez pas de compte ?"),
        TextButton(
          onPressed: () async {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => SignupPage()),
            );

            // Check if coming from a successful registration
            if (widget.successfulRegistration == true) {
              // If coming from successful registration, pop the login page
              Navigator.of(context).pop();
            }
          },
          child: const Text(
            "Inscrivez-vous",
            style: TextStyle(color: Colors.blue),
          ),
        ),
      ],
    );
  }
}