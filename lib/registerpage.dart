import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:quiznep/signinpage.dart';

class Registerpage extends StatefulWidget {
  const Registerpage({super.key});

  @override
  State<Registerpage> createState() => _RegisterpageState();
}

class _RegisterpageState extends State<Registerpage> {
  late final _email = TextEditingController();
  late final _password = TextEditingController();
  late final _confrimPass = TextEditingController();
  bool passToggle = true;

  @override
  void initState() {
    _email.text;
    _password.text;
    _confrimPass.text;
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 50),
              child: Text(
                'Hey \nRegister Now!',
                style: TextStyle(
                    color: Color(0XFFEF4A27),
                    fontWeight: FontWeight.bold,
                    fontSize: 25),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 200,
                  width: 200,
                  child: Image.asset('assets/image/register.png'),
                ),
              ],
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
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
              child: TextFormField(
                decoration: InputDecoration(
                  labelText: 'Full name',
                  contentPadding: EdgeInsets.all(10),
                  prefixIcon: const Icon(Icons.person_outline),
                  labelStyle: const TextStyle(color: Colors.grey),
                  hintText: 'Enter a full name',
                  hintStyle: const TextStyle(color: Colors.grey),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Color(0XFFEF4A27),
                    ),
                    borderRadius: BorderRadius.circular(20),
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
                controller: _email,
                decoration: InputDecoration(
                  labelText: 'Email',
                  contentPadding: EdgeInsets.all(10),
                  prefixIcon: const Icon(Icons.email_outlined),
                  labelStyle: const TextStyle(color: Colors.grey),
                  hintText: 'Enter a email',
                  hintStyle: const TextStyle(color: Colors.grey),
                  focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Color(0XFFEF4A27),
                      ),
                      borderRadius: BorderRadius.circular(20)),
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
                  labelText: 'Nationality',
                  contentPadding: EdgeInsets.all(10),
                  prefixIcon: const Icon(Icons.flag_circle_outlined),
                  labelStyle: const TextStyle(color: Colors.grey),
                  hintText: 'Enter your nationality',
                  hintStyle: const TextStyle(color: Colors.grey),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Color(0XFFEF4A27),
                    ),
                    borderRadius: BorderRadius.circular(20),
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
                controller: _password,
                obscureText: passToggle,
                decoration: InputDecoration(
                    labelText: 'New Password',
                    contentPadding: const EdgeInsets.all(10),
                    prefixIcon: const Icon(Icons.lock_outline),
                    labelStyle: const TextStyle(color: Colors.grey),
                    hintText: 'Ente a password',
                    hintStyle: const TextStyle(color: Colors.grey),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: const BorderSide(
                        color: Color(0XFFEF4A27),
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Color(0XFFEF4A27),
                      ),
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
                    )),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
              child: TextFormField(
                controller: _confrimPass,
                decoration: InputDecoration(
                    labelText: 'Confirm password',
                    contentPadding: const EdgeInsets.all(10),
                    prefixIcon: const Icon(Icons.lock_outline),
                    labelStyle: const TextStyle(color: Colors.grey),
                    hintText: 'Confirm your password',
                    hintStyle: const TextStyle(color: Colors.grey),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: const BorderSide(
                        color: Color(0XFFEF4A27),
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Color(0XFFEF4A27),
                      ),
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
                    )),
              ),
            ),
            const SizedBox(
              height: 30,
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
                  await Future.delayed(Duration(seconds: 2));
                  Navigator.pop(context);

                  final email = _email.text;
                  final password = _password.text;
                  final confirmPassword = _confrimPass.text.trim();
                  if (password != confirmPassword) {
                    showErrorDialgo(context, 'Passwords do not match');

                    return;
                  }

                  try {
                    UserCredential userCredential = await FirebaseAuth.instance
                        .createUserWithEmailAndPassword(
                            email: email, password: password);
                    User? user = userCredential.user;
                    if (user != null && !user.emailVerified) {
                      await user.sendEmailVerification();
                    }
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Signinpage()));
                  } on FirebaseAuthException catch (e) {
                    Navigator.pop(context);
                    if (e.code == 'email-already-in-use') {
                      showErrorDialgo(context, 'Email already used');
                    } else if (e.code == 'invalid-email') {
                      showErrorDialgo(context, 'Invalid Email');
                    } else if (e.code == 'weak-password') {
                      showErrorDialgo(context, 'Poor password');
                    } else {
                      showErrorDialgo(context, 'Something went wrong');
                      print(e.code);
                    }
                  }

                  //  Navigator.push(
                  //       context,
                  //       MaterialPageRoute(
                  //           builder: (context) => const Verifypage()));
                },
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
      ),
    );
  }
}

Future<void> showErrorDialgo(
  BuildContext context,
  String text,
) {
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text(' Error occured'),
          icon: Icon(Icons.cancel),
          content: Text(
            textAlign: TextAlign.center,
            text,
            style: const TextStyle(color: Colors.red),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text(
                'OK',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF91AD13),
                ),
              ),
            ),
          ],
        );
      });
}
