import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:quiznep/forgotpassword.dart';
import 'package:quiznep/registerpage.dart';
import 'package:quiznep/welcompage.dart';

class Signinpage extends StatefulWidget {
  const Signinpage({super.key});

  @override
  State<Signinpage> createState() => _SigninpageState();
}

class _SigninpageState extends State<Signinpage> {
  late final TextEditingController _email;
  late final TextEditingController _password;
  bool passToggle = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(
                vertical: 50,
                horizontal: 30,
              ),
              child: Text(
                'Hey\nLogin Now!',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                  color: Color(0XFFEF4A27),
                ),
              ),
            ),
            Center(
              child: Container(
                height: 250,
                width: 300,
                child: Image.asset('assets/image/signin.png'),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Center(
              child: Text(
                'Welcome Back',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                  color: Color(0XFFEF4A27),
                ),
              ),
            ),
            const Center(
              child: Text(
                'Login to your account',
                style: TextStyle(
                  color: Color(0XFFEF4A27),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 30,
                vertical: 30,
              ),
              child: TextFormField(
                controller: _email,
                decoration: InputDecoration(
                    hintText: 'Enter a email Address',
                    labelText: 'Email Address',
                    labelStyle: const TextStyle(color: Colors.grey),
                    hintStyle: const TextStyle(color: Colors.grey),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                    focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Color(0XFFEF4A27),
                        ),
                        borderRadius: BorderRadius.circular(20)),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.orange),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    prefixIcon: const Icon(Icons.mail_outline)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 30,
              ),
              child: TextFormField(
                controller: _password,
                obscureText: passToggle,
                decoration: InputDecoration(
                    hintText: 'Enter a password',
                    labelText: 'Password',
                    labelStyle: const TextStyle(color: Colors.grey),
                    hintStyle: const TextStyle(color: Colors.grey),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                    focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Color(0XFFEF4A27),
                        ),
                        borderRadius: BorderRadius.circular(20)),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.orange),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    suffix: InkWell(
                      onTap: () {
                        setState(() {
                          passToggle = !passToggle;
                        });
                      },
                      child: Icon(
                          passToggle ? Icons.visibility_off : Icons.visibility),
                    ),
                    prefixIcon: const Icon(Icons.lock_outline)),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 55),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Forgotpassword()));
                    },
                    child: const Text('Forgot Password?'),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 40,
            ),
            Center(
              child: InkWell(
                onTap: () async {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return const Center(
                          child: const CircularProgressIndicator(
                            color: Color(0XFFEF4A27),
                          ),
                        );
                      });

                  final email = _email.text;
                  final password = _password.text;

                  try {
                    UserCredential userCredential = await FirebaseAuth.instance
                        .signInWithEmailAndPassword(
                            email: email, password: password);

                    User? user = userCredential.user;
                    if (user != null && !user.emailVerified) {}
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Welcompage()));
                  } on FirebaseAuthException catch (e) {
                    Navigator.of(context).pop();
                    if (e.code == 'invalid-email') {
                      showErrorDialgo(context, 'Invalid Email ');
                    } else if (e.code == 'wrong-password') {
                      showErrorDialgo(context, 'passowrd invalid');
                    } else if (e.code == 'invalid-credential') {
                      showErrorDialgo(
                          context, 'invalid credential check password');
                    } else {
                      print(e.code);
                      showErrorDialgo(context, 'Something went wrong');
                    }
                  }
                },
                child: Container(
                  height: 37,
                  width: 200,
                  decoration: BoxDecoration(
                      color: const Color(0XFFEF4A27),
                      borderRadius: BorderRadius.circular(27)),
                  child: const Center(child: Text('Login')),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Don't have account?",
                  style: TextStyle(color: Colors.grey),
                ),
                InkWell(
                  onTap: () async {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Registerpage()));
                  },
                  child: const Text(
                    ' Register',
                    style: TextStyle(color: Color(0XFFEF4A27)),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
