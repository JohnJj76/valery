import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:valery/pages/home_screen.dart';
import 'package:valery/pages/register.dart';
import 'package:valery/utils/util.dart';

class LogIn extends StatefulWidget {
  const LogIn({super.key});

  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  //SharedPreferences sp = SharedPreferences.getInstance();
  late User user;
  String email = "", password = "";

  final _formkey = GlobalKey<FormState>();

  TextEditingController useremailcontroller = new TextEditingController();
  TextEditingController userpasswordcontroller = new TextEditingController();

  Future<void> loginUser() async {
    final user = await _auth.signInWithEmailAndPassword(
        email: useremailcontroller.text, password: userpasswordcontroller.text);
    if (user != null) {
      // lets save user with shared prefrences

      /*setState(() async {
        sp.setString('email', email.toString());
        sp.setString('password', password.toString());
        sp.setBool('isLogin', true);
      });*/

      ///print(user.user!.uid);

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
                    width: jancho * 0.50,
                    height: jalto * 0.30,
                    fit: BoxFit.fill),
                Container(
                  height: jalto * 0.55,
                  width: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Text(
                          'ingresa tus credenciales...',
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
                              controller: useremailcontroller,
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
                              controller: userpasswordcontroller,
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
                            height: 30,
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
                              //userLogin();
                              loginUser();
                            },
                            label: const Text('Logiarse',
                                style: TextStyle(
                                    fontSize: 22, color: Colors.white)),
                            icon: const Icon(
                              Icons.thumb_up,
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
                                'Si no estas registrado...',
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
                                          builder: (context) => Register()));
                                },
                                label: const Text('Registrate',
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

      /**/
    );

    /*return Scaffold(
      backgroundColor: Color.fromRGBO(193, 117, 255, 1),
      body: SingleChildScrollView(
        child: Container(
          child: Form(
            key: _formkey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 50,
                ),
                Image.asset(
                  "assets/images/LogotEROS.png",
                  width: c_acho,
                  height: c_alto / 3,
                  fit: BoxFit.contain,
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 20.0),
                  child: Text(
                    "Bienvenido",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 27,
                        fontFamily: 'Pacifico'),
                  ),
                ),
                const SizedBox(
                  height: 30.0,
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 3.0),
                  margin: EdgeInsets.symmetric(horizontal: 20.0),
                  decoration: BoxDecoration(
                      color: Color(0xFF4c59a5),
                      borderRadius: BorderRadius.circular(22)),
                  child: TextFormField(
                    controller: useremailcontroller,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Digíte el correo';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        prefixIcon: Icon(
                          Icons.email,
                          color: Colors.white,
                        ),
                        hintText: 'Correo',
                        hintStyle: TextStyle(color: Colors.white60)),
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                SizedBox(
                  height: 30.0,
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 3.0),
                  margin: EdgeInsets.symmetric(horizontal: 20.0),
                  decoration: BoxDecoration(
                      color: Color(0xFF4c59a5),
                      borderRadius: BorderRadius.circular(22)),
                  child: TextFormField(
                    controller: userpasswordcontroller,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Digíte la clave';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        prefixIcon: Icon(
                          Icons.password,
                          color: Colors.white,
                        ),
                        hintText: 'Clave',
                        hintStyle: TextStyle(color: Colors.white60)),
                    style: TextStyle(color: Colors.white),
                    obscureText: true,
                  ),
                ),
                SizedBox(
                  height: 15.0,
                ),
                GestureDetector(
                  onTap: () {
                    /*Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ForgotPassword()));*/
                  },
                  child: Container(
                    padding: EdgeInsets.only(right: 24.0),
                    alignment: Alignment.bottomRight,
                    child: Text(
                      "¿ Recordar la clave ?",
                      style: TextStyle(color: Colors.white, fontSize: 18.0),
                    ),
                  ),
                ),
                SizedBox(
                  height: 30.0,
                ),
                GestureDetector(
                  onTap: () {
                    if (_formkey.currentState!.validate()) {
                      setState(() {
                        email = useremailcontroller.text;
                        password = userpasswordcontroller.text;
                      });
                    }
                    userLogin();
                  },
                  child: Center(
                    child: Container(
                      width: 150,
                      height: 55,
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: Color(0xFFf95f3b),
                          borderRadius: BorderRadius.circular(30)),
                      child: Center(
                          child: Text(
                        "Login",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold),
                      )),
                    ),
                  ),
                ),
                SizedBox(
                  height: 40.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Si no estar registrado",
                      style: TextStyle(color: Colors.white, fontSize: 17),
                    ),
                    SizedBox(
                      width: 5.0,
                    ),
                    GestureDetector(
                        onTap: () {
                          /*Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SignUp()));*/
                        },
                        child: Text(
                          " Registrate",
                          style: TextStyle(
                              color: Color(0xFFf95f3b),
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold),
                        ))
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );*/
  }
}
