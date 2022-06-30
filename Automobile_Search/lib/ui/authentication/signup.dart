import 'package:carismatic/ui/home.dart';
import 'package:flutter/material.dart';
import 'package:carismatic/constants/constant.dart';
import 'package:carismatic/constants/global_style.dart';

class SignupPage extends StatefulWidget {
  final bool fromList;

  const SignupPage({Key? key, this.fromList = false}) : super(key: key);

  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final TextEditingController _etEmail = TextEditingController();
  final TextEditingController _etName = TextEditingController();
  final TextEditingController _etNumber = TextEditingController();
  DateTime _selectedDate = DateTime.now(), initialDate = DateTime.now();
  TextEditingController _etDate = TextEditingController();
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
    _etDate = TextEditingController(text: _selectedDate.toLocal().toString().split(' ')[0]);
    super.initState();
  }

  @override
  void dispose() {
    _etEmail.dispose();
    _etName.dispose();
    _etNumber.dispose();
    _etDate.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: WillPopScope(
          onWillPop: (){
            FocusScope.of(context).unfocus();
            return Future.value(true);
          },
          child: ListView(
            padding: const EdgeInsets.fromLTRB(30, 120, 30, 30),
            children: <Widget>[
              Center(
                  child: Image.asset('assets/logo.jpeg',
                      height: 140)),
              const SizedBox(
                height: 40,
              ),
              const Text('Sign Up', style: GlobalStyle.authTitle),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                keyboardType: TextInputType.text,
                controller: _etName,
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
                  labelText: 'First Name',
                  labelStyle: TextStyle(color: BLACK_GREY),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                keyboardType: TextInputType.text,
                controller: _etName,
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
                  labelText: 'Last Name',
                  labelStyle: TextStyle(color: BLACK_GREY),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                keyboardType: TextInputType.text,
                controller: _etName,
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
                  labelText: 'Username',
                  labelStyle: TextStyle(color: BLACK_GREY),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
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
                height: 10,
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                controller: _etNumber,
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
                  labelText: 'Phone number',
                  labelStyle: TextStyle(color: BLACK_GREY),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 8),
                child: TextField(
                  controller: _etDate,
                  readOnly: true,
                  onTap: () {
                    _selectDate(context);
                  },
                  maxLines: 1,
                  cursorColor: Colors.grey[600],
                  style: const TextStyle(color: CHARCOAL),
                  decoration: const InputDecoration(
                    isDense: true,
                    suffixIcon: Icon(Icons.date_range, color: Colors.pinkAccent),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFFCCCCCC)),
                    ),
                    focusedBorder: UnderlineInputBorder(
                        borderSide:
                        BorderSide(color: PRIMARY_COLOR, width: 2.0)),
                    labelText: 'Date of Birth',
                    labelStyle: TextStyle(fontSize: 22 ,color: BLACK_GREY),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
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
                height: 40,
              ),

              TextButton(
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
                    if(widget.fromList){
                      Navigator.pop(context);
                    }
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const HomePage()));
                  },
                  child: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 5.0),
                    child: Text(
                      'Register',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                  )
              ),
              const SizedBox(
                height: 30,
              ),
              Center(
                child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                    FocusScope.of(context).unfocus();
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const <Widget>[
                      GlobalStyle.iconBack,
                      Text(
                        ' Back to login',
                        style: GlobalStyle.back,
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(1900),
      lastDate: DateTime(2025),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: Colors.pinkAccent,
            colorScheme: const ColorScheme.light(primary: Colors.pinkAccent, secondary: Colors.pinkAccent),
            buttonTheme: const ButtonThemeData(textTheme: ButtonTextTheme.primary),
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        _etDate = TextEditingController(
            text: _selectedDate.toLocal().toString().split(' ')[0]);
      });
    }
  }
}
