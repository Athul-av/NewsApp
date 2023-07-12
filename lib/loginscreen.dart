import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:newsapp/homescreen.dart';
import 'package:newsapp/signup..dart';

class LoginScreen extends StatefulWidget {
 const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  GlobalKey<FormState> formkey = GlobalKey();

  TextEditingController emailcontroller = TextEditingController();

  TextEditingController password = TextEditingController(); 


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,  
      backgroundColor: Colors.white,
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder:(context, snapshot) {
        if (snapshot.hasError) {
          return const  Center(child:Text('something went wrong')); 
        }
        else if (snapshot.hasData) {
          emailcontroller.clear();
          password.clear();
            return const HomeScreen();
          }else{
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
                    key: formkey,
                    child: Column(
                      children: [
                        TextFormField(
                          validator: (value) {  
                            if (value!.isEmpty) {
                              return "enter email";
                            }
                            return null;
                          },
                          controller: emailcontroller,
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
                              return "enter password";
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
                        ElevatedButton(
                          onPressed: ()async {
                            if (formkey.currentState!.validate()) {
                             return await loginfun(context); 
                            }
                            return ; 
                          },
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                  const Color.fromARGB(255, 194, 50, 39))),
                          child: const  Text(
                            'Sign In',
                            style: TextStyle(color: Colors.white),
                          ), 
                        )
                      ],
                    ),
                  ),
                ),
              Row(
                 mainAxisAlignment: MainAxisAlignment.center,  
                children: [
                 const  Text("don't have an account ?"),
                 TextButton(onPressed: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => SignUp())); 
                 }, child:const Text('SignUp',style: TextStyle(color: Color.fromARGB(255, 189, 47, 37)),))
              ],)
              ],
            ))
          ],
        ));
          }
        }, 
      ),
    );
  }

  Future loginfun(context)async{
 
  try {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
    email:emailcontroller.text.trim(), password: password.text.trim());
  } on FirebaseAuthException catch (e) {
    print(e);
  }
}
}
 


