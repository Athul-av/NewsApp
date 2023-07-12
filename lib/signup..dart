import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:newsapp/homescreen.dart';

class SignUp extends StatefulWidget {
   SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();

}

  GlobalKey<FormState> formkeyy = GlobalKey();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirm = TextEditingController();

class _SignUpState extends State<SignUp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return HomeScreen(); 
          }
          else{
            return SafeArea(
                child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.only(top: 30),
                  child: SizedBox(
                    height: 150,
                    width: double.infinity,
                    child: Image(
                        image: AssetImage('assets/news.jpg'), fit: BoxFit.cover),
                  ),
                ),
                Flexible( 
                    child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(45, 50, 45, 30),
                      child: Form(
                        key: formkeyy,
                        child: Column(
                          children: [
                            TextFormField(
                              validator: (value) {  
                                if (value!.isEmpty) {
                                  return "enter email";
                                }
                                return null;
                              },
                              controller: email,
                              autovalidateMode: AutovalidateMode.onUserInteraction,
                              keyboardType: TextInputType.emailAddress,
                              cursorColor: const Color.fromARGB(255, 101, 101, 101),
                              cursorWidth: 1,
                              decoration: InputDecoration(
                                labelText: 'Email',
                                labelStyle:const TextStyle(fontSize: 14),
                                filled: true,
                                fillColor:const Color.fromARGB(255, 215, 215, 215),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    borderSide: BorderSide.none),
                              ),
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            TextFormField(
                              controller: password,
                              autovalidateMode: AutovalidateMode.onUserInteraction,
                              keyboardType: TextInputType.emailAddress,
                              cursorColor: const Color.fromARGB(255, 101, 101, 101),
                              cursorWidth: 1,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "password should have 6 characters";
                                } 
                                return null;
                              },
                              decoration: InputDecoration(
                                labelText: 'Password',
                                labelStyle:const TextStyle(fontSize: 14),
                                filled: true,
                                fillColor: const Color.fromARGB(255, 215, 215, 215),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    borderSide: BorderSide.none),
                              ),
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            TextFormField(
                              controller: confirm,
                              autovalidateMode: AutovalidateMode.onUserInteraction,
                              keyboardType: TextInputType.emailAddress,
                              cursorColor: const Color.fromARGB(255, 101, 101, 101),
                              cursorWidth: 1,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "re-enter password";
                                }else if(value != password.text){
                                  return "password is not matching";
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                labelText: 're-Password',
                                labelStyle:const TextStyle(fontSize: 14),
                                filled: true,
                                fillColor: const Color.fromARGB(255, 215, 215, 215),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    borderSide: BorderSide.none),
                              ),
                            ),
                           const SizedBox(
                              height: 30,
                            ),
                            ElevatedButton(
                              onPressed: ()async {
                                if (formkeyy.currentState!.validate()) {
                                     await signup();  
                                }
                                return ; 
                              },
                              style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                      const Color.fromARGB(255, 194, 50, 39))),
                              child: const  Text(
                                'SignUp',
                                style: TextStyle(color: Colors.white),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                 
                  ],
                ))
              ],
            ));
          } 
        }
      ) 
    );
  }


  Future signup()async{
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email.text.trim(), password: password.text.trim());
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => HomeScreen() )); 
    } catch (e) {
      log(e.toString()); 
     return const SnackBar(content:Text('error') ,);
    }
  }
} 