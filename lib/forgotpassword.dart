import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:quiznep/signinpage.dart';

class Forgotpassword extends StatefulWidget {
  const Forgotpassword({super.key});

  @override
  State<Forgotpassword> createState() => _ForgotpasswordState();
}

class _ForgotpasswordState extends State<Forgotpassword> {
  late final _email = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 50, horizontal: 30),
            child: Text(
              'Forgot Password!',
              style: TextStyle(
                  color: Color(0XFFEF4A27),
                  fontSize: 25,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Center(
            child: Container(
              height: 200,
              width: 300,
              child: const Image(
                image: AssetImage(
                  'assets/image/forgot.png',
                ),
              ),
            ),
          ),
          const Center(
            child: Text(
              'Forgot Password ',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 27,
                  color: Color(0XFFEF4A27)),
            ),
          ),
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Send email to recover password',
                style: TextStyle(color: Color(0XFFEF4A27), fontSize: 12),
              ),
            ],
          ),
          const SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: TextFormField(
              controller: _email,
              decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.email_outlined),
                  labelText: 'Email ',
                  hintText: 'Enter a email ',
                  labelStyle: const TextStyle(color: Colors.grey),
                  hintStyle: const TextStyle(color: Colors.grey),
                  contentPadding: const EdgeInsets.all(10),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Color(0XFFEF4A27),
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Color(0XFFEF4A27),
                      ),
                      borderRadius: BorderRadius.circular(20))),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 60),
            child: Center(
              child: Column(
                children: [
                  InkWell(
                    onTap: () async {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return const Center(
                              child: CircularProgressIndicator(
                                color: Color(0XFFEF4A27),
                              ),
                            );
                          });
                      await Future.delayed(Duration(seconds: 2));
                      Navigator.pop(context);

                      final email = _email.text;
                      FirebaseAuth.instance
                          .sendPasswordResetEmail(email: email);

                      Navigator.pop(context);
                    },
                    child: Container(
                      height: 37,
                      width: 130,
                      decoration: BoxDecoration(
                          color: const Color(0XFFEF4A27),
                          borderRadius: BorderRadius.circular(17)),
                      child: const Center(
                        child: Text(
                          'Send ',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Signinpage()));
                      },
                      child: Text('Back to Login?'))
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
