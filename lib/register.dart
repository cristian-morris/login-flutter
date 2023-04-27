import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login/components/text.dart';

class MyRegister extends StatefulWidget {
  final Function()? onTap;
 const  MyRegister({super.key, required this.onTap});


  @override
  _MyRegisterState createState() => _MyRegisterState();
}

class _MyRegisterState extends State<MyRegister> {

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmController = TextEditingController();
  // sign user in method
  void signUserup() async {
    
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
       );


try {
  if (passwordController.text == confirmController.text) {
    await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: emailController.text, 
      password: passwordController.text
      );
  }else {
errormesage("error la contrasela no coincide");
  }

      Navigator.pop(context);
} on FirebaseAuthException catch (e) {
Navigator.pop(context);

 errormesage(e.code);
}
    
  }

void errormesage(String message) {
  showDialog(
  context: context, 
  builder: (context) {
    return  AlertDialog(
      title: Text(message),
    );
  },
  );
}

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/register.png'), fit: BoxFit.cover),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: Stack(
          children: [
            Container(
              padding: EdgeInsets.only(left: 35, top: 30),
              child: Text(
                'Crear cuenta',
                style: TextStyle(color: Colors.black, fontSize: 33),
              ),
            ),
            SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.28),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 35, right: 35),
                      child: Column(
                        children: [
                         MyTextField(
                  controller: emailController,
                  hintText: 'Username',
                  obscureText: false,
                ),
                          SizedBox(
                            height: 30,
                          ),
                          MyTextField(
                  controller: passwordController,
                  hintText: 'Password',
                  obscureText: true,
                ),
                          SizedBox(
                            height: 30,
                          ),
                          MyTextField(
                  controller: confirmController,
                  hintText: 'confirm Password',
                  obscureText: true,
                ),
                          SizedBox(
                            height: 40,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Crear cuenta',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 27,
                                    fontWeight: FontWeight.w700),
                              ),
                              CircleAvatar(
                                radius: 30,
                                backgroundColor: Color(0xff4c505b),
                                child: IconButton(
                                    color: Colors.white,
                                    onPressed: () {
                                      signUserup();
                                    },
                                    icon: Icon(
                                      Icons.arrow_forward,
                                    )),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 40,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                      onTap: widget.onTap,
                      child: const Text(
                        'Login',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
