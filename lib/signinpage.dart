import 'package:flutter/material.dart';
import 'package:quiznep/forgotpassword.dart';
import 'package:quiznep/registerpage.dart';

class Signinpage extends StatefulWidget {
  const Signinpage({super.key});

  @override
  State<Signinpage> createState() => _SigninpageState();
}

class _SigninpageState extends State<Signinpage> {
  late final _email = TextEditingController();
  late final _password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
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
                fontSize: 20,
                color: Color(0XFFEF4A27),
              ),
            ),
          ),
          const SizedBox(
            height: 30,
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
            height: 40,
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
            child: Container(
              height: 37,
              width: 200,
              decoration: BoxDecoration(
                  color: const Color(0XFFEF4A27),
                  borderRadius: BorderRadius.circular(27)),
              child: const Center(child: Text('Login')),
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
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const Registerpage()));
                },
                child: const Text(
                  ' Register',
                  style: TextStyle(color: Color(0XFFEF4A27)),
                ),
              )
            ],
          ),
          // Padding(
          //   padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
          //   child: Container(
          //     height: 30,
          //     width: 500,
          //     decoration: BoxDecoration(
          //         color: Colors.grey.shade300,
          //         borderRadius: BorderRadius.circular(10)),
          //     child: TextFormField(),
          //   ),
          // ),
        ],
      ),
    );
  }
}
