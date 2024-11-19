import 'package:flutter/material.dart';
import 'package:quiznep/signinpage.dart';

class Registerpage extends StatefulWidget {
  const Registerpage({super.key});

  @override
  State<Registerpage> createState() => _RegisterpageState();
}

class _RegisterpageState extends State<Registerpage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 30, vertical: 50),
            child: Text(
              'Hey \nRegister Now!',
              style: TextStyle(
                  color: Color(0XFFEF4A27),
                  fontWeight: FontWeight.bold,
                  fontSize: 20),
            ),
          ),
          const Center(
            child: Text(
              'Register',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color(0XFFEF4A27),
                  fontSize: 35),
            ),
          ),
          const Center(
            child: Text(
              'Create your account',
              style: TextStyle(color: Color(0XFFEF4A27), fontSize: 13),
            ),
          ),
          const SizedBox(
            height: 60,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
            child: TextFormField(
              decoration: InputDecoration(
                labelText: 'Enter you full name',
                contentPadding: EdgeInsets.all(10),
                prefixIcon: const Icon(Icons.person_outline),
                labelStyle: const TextStyle(color: Colors.grey),
                hintText: 'Full Name',
                hintStyle: const TextStyle(color: Colors.grey),
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color(0XFFEF4A27),
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: Color(0XFFEF4A27),
                  ),
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
            child: TextFormField(
              decoration: InputDecoration(
                labelText: 'Enter your email',
                contentPadding: EdgeInsets.all(10),
                prefixIcon: const Icon(Icons.email_outlined),
                labelStyle: const TextStyle(color: Colors.grey),
                hintText: 'Email',
                hintStyle: const TextStyle(color: Colors.grey),
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color(0XFFEF4A27),
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: Color(0XFFEF4A27),
                  ),
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
            child: TextFormField(
              decoration: InputDecoration(
                labelText: 'Enter your nationality',
                contentPadding: EdgeInsets.all(10),
                prefixIcon: const Icon(Icons.flag_circle_outlined),
                labelStyle: const TextStyle(color: Colors.grey),
                hintText: 'Nationality',
                hintStyle: const TextStyle(color: Colors.grey),
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color(0XFFEF4A27),
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: Color(0XFFEF4A27),
                  ),
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
            child: TextFormField(
              decoration: InputDecoration(
                labelText: 'Enter you new password',
                contentPadding: const EdgeInsets.all(10),
                prefixIcon: const Icon(Icons.lock_outline),
                labelStyle: const TextStyle(color: Colors.grey),
                hintText: 'New Password',
                hintStyle: const TextStyle(color: Colors.grey),
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color(0XFFEF4A27),
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: Color(0XFFEF4A27),
                  ),
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
            child: TextFormField(
              decoration: InputDecoration(
                labelText: 'Confirm your password',
                contentPadding: EdgeInsets.all(10),
                prefixIcon: const Icon(Icons.lock_outline),
                labelStyle: const TextStyle(color: Colors.grey),
                hintText: 'Cofirm Password',
                hintStyle: const TextStyle(color: Colors.grey),
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color(0XFFEF4A27),
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: Color(0XFFEF4A27),
                  ),
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Center(
            child: Container(
              height: 37,
              width: 200,
              decoration: BoxDecoration(
                color: const Color(0XFFEF4A27),
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Center(
                child: Text(
                  'Register',
                  style: TextStyle(color: Colors.black),
                ),
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
                'Already have account?',
                style: TextStyle(color: Colors.grey),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const Signinpage()));
                },
                child: const Text(
                  ' Login',
                  style: TextStyle(color: Color(0XFFEF4A27)),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
