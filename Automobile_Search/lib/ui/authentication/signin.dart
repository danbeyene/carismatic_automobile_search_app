import 'package:carismatic/constants/constant.dart';
import 'package:carismatic/constants/global_style.dart';
import 'forgot_password.dart';
import 'package:carismatic/ui/home.dart';
import 'signup.dart';
import 'package:flutter/material.dart';

class SigninPage extends StatefulWidget {
  const SigninPage({Key? key}) : super(key: key);

  @override
  _SigninPageState createState() => _SigninPageState();
}

class _SigninPageState extends State<SigninPage> {
  final TextEditingController _etEmail = TextEditingController();
  bool _obscureText = true;
  IconData _iconVisible = Icons.visibility_off;

  void _toggleObscureText() {
    setState(() {
      _obscureText = !_obscureText;
      if (_obscureText == true) {
        _iconVisible = Icons.visibility_off;
      } else {
        _iconVisible = Icons.visibility;
      }
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _etEmail.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(
          padding: const EdgeInsets.fromLTRB(30, 120, 30, 30),
          children: <Widget>[
            Center(
                child: Image.asset('assets/logo.jpeg',
                    height: 140)),
            const SizedBox(
              height: 80,
            ),
            const Text('Sign In', style: GlobalStyle.authTitle),
            TextFormField(
              keyboardType: TextInputType.emailAddress,
              controller: _etEmail,
              style: const TextStyle(color: CHARCOAL),
              onChanged: (textValue) {
                setState(() {});
              },
              decoration: const InputDecoration(
                focusedBorder: UnderlineInputBorder(
                    borderSide:
                    BorderSide(color: PRIMARY_COLOR, width: 2.0)),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFFCCCCCC)),
                ),
                labelText: 'Email',
                labelStyle: TextStyle(color: BLACK_GREY),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            TextField(
              obscureText: _obscureText,
              style: const TextStyle(color: CHARCOAL),
              decoration: InputDecoration(
                focusedBorder: const UnderlineInputBorder(
                    borderSide:
                    BorderSide(color: PRIMARY_COLOR, width: 2.0)),
                enabledBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFFCCCCCC)),
                ),
                labelText: 'Password',
                labelStyle: const TextStyle(color: BLACK_GREY),
                suffixIcon: IconButton(
                    icon: Icon(_iconVisible, color: Colors.grey[400], size: 20),
                    onPressed: () {
                      _toggleObscureText();
                    }),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Align(
                alignment: Alignment.centerRight,
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const ForgotPasswordPage()));
                    FocusScope.of(context).unfocus();
                  },
                  child: const Text(
                    'Forgot Password?',
                    style: TextStyle(color: PRIMARY_COLOR, fontSize: 13),
                  ),
                )),
            const SizedBox(
              height: 40,
            ),
            Container(
              child: TextButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.resolveWith<Color>(
                        (Set<MaterialState> states) => PRIMARY_COLOR,
                  ),
                  overlayColor: MaterialStateProperty.all(Colors.transparent),
                  shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(3.0),
                      )
                  ),
                ),
                onPressed: () {
                  //Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => HomePage()), (Route<dynamic> route) => false);
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const HomePage()));
                  FocusScope.of(context).unfocus();
                },
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 5.0),
                  child: Text(
                    'Login',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                )
            ),
            ),
            const SizedBox(
              height: 40,
            ),
            // const Center(
            //   child: Text(
            //     'Or sign in with',
            //     style: GlobalStyle.authSignWith,
            //   ),
            // ),
            // const SizedBox(
            //   height: 20,
            // ),
            // Container(
            //   margin: const EdgeInsets.fromLTRB(20, 0, 20, 0),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //     children: <Widget>[
            //       GestureDetector(
            //         onTap: (){
            //           //Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => HomePage()), (Route<dynamic> route) => false);
            //           Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const HomePage()));
            //           Fluttertoast.showToast(
            //               msg: 'Sign in with Google',
            //               toastLength: Toast.LENGTH_LONG);
            //         },
            //         child: const Image(
            //           image: AssetImage("assets/google.png"), width: 40,),
            //       ),
            //       GestureDetector(
            //         onTap: (){
            //           //Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => HomePage()), (Route<dynamic> route) => false);
            //           Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const HomePage()));
            //           Fluttertoast.showToast(
            //               msg: 'Sign in with Facebook',
            //               toastLength: Toast.LENGTH_LONG);
            //         },
            //         child: const Image(
            //           image: AssetImage("assets/facebook.png"), width: 40,),
            //       ),
            //       GestureDetector(
            //         onTap: (){
            //           //Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => HomePage()), (Route<dynamic> route) => false);
            //           Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const HomePage()));
            //           Fluttertoast.showToast(
            //               msg: 'Sign in with Twitter',
            //               toastLength: Toast.LENGTH_LONG);
            //         },
            //         child: const Image(
            //           image: AssetImage("assets/twitter.png"), width: 40,),
            //       )
            //     ],
            //   ),
            // ),

            Center(
              child: GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const SignupPage()));
                  FocusScope.of(context).unfocus();
                },
                child: Wrap(
                  children: const [
                    Text(
                      'No account yet? ',
                      style: GlobalStyle.authBottom1,
                    ),
                    Text(
                      'Create one',
                      style: GlobalStyle.authBottom2,
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Center(
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const <Widget>[
                    GlobalStyle.iconBack,
                    Text(
                      ' Back',
                      style: GlobalStyle.back,
                    )
                  ],
                ),
              ),
            ),
          ],
        ));
  }
}
