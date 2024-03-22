import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:valery/pages/home_screen.dart';
import 'package:valery/pages/login.dart';
import 'package:valery/utils/util.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  //SharedPreferences sp = SharedPreferences.getInstance();

  String name = "", email = "", password = "";
  TextEditingController nombreController = new TextEditingController();
  TextEditingController correoController = new TextEditingController();
  TextEditingController claveController = new TextEditingController();
  late User user;

  final _formkey = GlobalKey<FormState>();

  TextEditingController useremailcontroller = new TextEditingController();
  TextEditingController userpasswordcontroller = new TextEditingController();

  Future<void> loginUser() async {
    final user = await _auth.signInWithEmailAndPassword(
        email: useremailcontroller.text, password: userpasswordcontroller.text);
    if (user != null) {
      Get.to(HomeScreen());
    } else {
      print('error');
    }
  }

  userLogin() async {
    try {
      Get.to(HomeScreen());

      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      //
      // ignore: use_build_context_synchronously
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString("p_email", email);
      prefs.setString("p_clave", password);

      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => HomeScreen(),
        ),
        (route) => false,
      );

      //Navigator.push(
      //  context, MaterialPageRoute(builder: (context) => HomeQW()));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
            "No User Found for that Email",
            style: TextStyle(fontSize: 18.0, color: Colors.black),
          ),
        ));
      } else if (e.code == 'wrong-password') {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text(
          "Wrong Password Provided by User",
          style: TextStyle(fontSize: 18.0, color: Colors.black),
        )));
      }
    }
  }

  registrarUser() async {
    if (password != null) {
      try {
        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
                email: correoController.text, password: claveController.text);

        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            backgroundColor: Colors.redAccent,
            content: Text(
              "El registro fue exitoso",
              style: TextStyle(fontSize: 20.0),
            )));
        // ignore: use_build_context_synchronously
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => HomeScreen()));
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              backgroundColor: Colors.orangeAccent,
              content: Text(
                "Password Provided is too Weak",
                style: TextStyle(fontSize: 18.0),
              )));
        } else if (e.code == "email-already-in-use") {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              backgroundColor: Colors.orangeAccent,
              content: Text(
                "Account Already exists",
                style: TextStyle(fontSize: 18.0),
              )));
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    //
    double jancho = MediaQuery.of(context).size.width;
    double jalto = MediaQuery.of(context).size.height;
    //
    return Scaffold(
      backgroundColor: fondoLogin,
      body: SingleChildScrollView(
        child: Container(
          height: jalto,
          width: jancho,
          child: Form(
            key: _formkey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/imagenes/logoValery.png',
                    width: jancho * 0.45,
                    height: jalto * 0.25,
                    fit: BoxFit.fill),
                Container(
                  height: jalto * 0.60,
                  width: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Text(
                          'ingresa tus datos...',
                          style: TextStyle(
                            fontSize: 25,
                            color: textColor,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Column(
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(vertical: 3.0),
                            margin: EdgeInsets.symmetric(horizontal: 20.0),
                            decoration: BoxDecoration(
                                color: cajaLogin,
                                borderRadius: BorderRadius.circular(16)),
                            child: TextFormField(
                              controller: nombreController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'digíte el nombre';
                                }
                                return null;
                              },
                              decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  prefixIcon: Icon(
                                    Icons.person,
                                    color: Colors.white,
                                  ),
                                  hintText: 'Nombre',
                                  hintStyle: TextStyle(color: Colors.white60)),
                              style:
                                  TextStyle(fontSize: 20, color: Colors.white),
                            ),
                          ),
                          const SizedBox(
                            height: 14.0,
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(vertical: 3.0),
                            margin: EdgeInsets.symmetric(horizontal: 20.0),
                            decoration: BoxDecoration(
                                color: cajaLogin,
                                borderRadius: BorderRadius.circular(16)),
                            child: TextFormField(
                              controller: correoController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'digíte un correo';
                                }
                                return null;
                              },
                              decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  prefixIcon: Icon(
                                    Icons.email,
                                    color: Colors.white,
                                  ),
                                  hintText: 'Correo',
                                  hintStyle: TextStyle(color: Colors.white60)),
                              style:
                                  TextStyle(fontSize: 20, color: Colors.white),
                            ),
                          ),
                          const SizedBox(
                            height: 14.0,
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(vertical: 3.0),
                            margin:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                            decoration: BoxDecoration(
                                color: cajaLogin,
                                borderRadius: BorderRadius.circular(16)),
                            child: TextFormField(
                              controller: claveController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'digíte la clave';
                                }
                                return null;
                              },
                              decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  prefixIcon: Icon(
                                    Icons.key,
                                    color: Colors.white,
                                  ),
                                  hintText: 'Clave',
                                  hintStyle: TextStyle(color: Colors.white60)),
                              style: const TextStyle(
                                  fontSize: 20, color: Colors.white),
                              obscureText: true,
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          //
                          FloatingActionButton.extended(
                            onPressed: () {
                              if (_formkey.currentState!.validate()) {
                                setState(() {
                                  email = useremailcontroller.text;
                                  password = userpasswordcontroller.text;
                                });
                              }
                              registrarUser();
                            },
                            label: const Text('Registrate',
                                style: TextStyle(
                                    fontSize: 22, color: Colors.white)),
                            icon: const Icon(
                              Icons.description_outlined,
                              color: Colors.white,
                              size: 22,
                            ),
                            backgroundColor: botonLogin,
                          ),
                          //
                        ],
                      ),
                      const SizedBox(
                        height: 34,
                      ),
                      Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Si ya estas registrado...',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontStyle: FontStyle.italic,
                                  color: textColor,
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              FloatingActionButton.extended(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => LogIn()));
                                },
                                label: const Text('Login',
                                    style: TextStyle(
                                        fontSize: 16, color: Colors.black)),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
