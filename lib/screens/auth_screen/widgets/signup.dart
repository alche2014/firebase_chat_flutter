import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_chat/providers/auth.dart';
import '../../../consts.dart';


enum AuthMode {
  SignIn,
  SignUp,
  }

class SignupScreen extends StatefulWidget {
  SignupScreen({
    Key key,
  }) : super(key: key);

  @override
  _InputFieldState createState() => _InputFieldState();
}

class _InputFieldState extends State<SignupScreen> {
  GlobalKey<FormState> _formKey;
  AuthMode authMode = AuthMode.SignIn;
  TextEditingController textEditingController;
  FocusNode _usernameFocus;
  FocusNode _emailFocus;

  @override
  void initState() {
    super.initState();
    _formKey = GlobalKey<FormState>();
    _usernameFocus = FocusNode();
    _emailFocus = FocusNode();
    textEditingController = TextEditingController();
  }

  @override
  void dispose() {
    textEditingController.dispose();
    _usernameFocus.dispose();
    _emailFocus.dispose();
    super.dispose();
  }

  

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        _InputForm(
            formKey: _formKey,
            authMode: authMode,
            authData: _authData,
            textEditingController: textEditingController,
            usernameFocus: _usernameFocus,
            emailFocus: _emailFocus),
        SizedBox(height: 20),
        _SubmitButton(
          onPressed: () =>  _signUp(),
          authMode: authMode,
        ),
      ],
    );
  }

  Map<String, String> _authData = {
    'username': '',
    'email': '',
    'password': '',
  };

  void _signUp() async {    
    if (!_formKey.currentState.validate()) return;
    _formKey.currentState.save();

    // try signup
    final res = await Provider.of<Auth>(context, listen: false).signUp(
      _authData['username'],
      _authData['email'],
      _authData['password'],
    );

    // sign up failed
    if (!res) showAlertDialog();
  }

 

  void showAlertDialog() {
    showDialog(
      context: context,
      builder: (_) => _AuthFailedAlert(),
    );
  }
}

class _InputForm extends StatelessWidget {
  const _InputForm({
    Key key,
    @required GlobalKey<FormState> formKey,
    @required this.authMode,
    @required Map<String, String> authData,
    @required this.textEditingController,
    @required FocusNode usernameFocus,
    @required FocusNode emailFocus,
  })  : _formKey = formKey,
        _authData = authData,
        _usernameFocus = usernameFocus,
        _emailFocus = emailFocus,
        super(key: key);

  final GlobalKey<FormState> _formKey;
  final AuthMode authMode;
  final Map<String, String> _authData;
  final TextEditingController textEditingController;
  final FocusNode _usernameFocus;
  final FocusNode _emailFocus;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: Form(
        key: _formKey,
        child: Column(
          children: [
              SizedBox(height: kDefaultPadding * 10),
            AnimatedContainer(
              duration: Duration(milliseconds: 200),
              height: 75 ,
              child: _TextField(
                hintText:  'Username',
                validator: (value) {},
                onSaved: (value) => _authData['username'] = value.trim(),
                controller: textEditingController,
                focusNode: _usernameFocus,
              ),
            ),
            _TextField(
              hintText: 'Email',
              focusNode: _emailFocus,
              onSaved: (value) {
                _authData['email'] = value.trim();
                print('email saved -----> ${_authData['email']}');
              },
              validator: (_) {},
              obscureText: false,
            ),
            _TextField(
              hintText: 'Password',
              onSaved: (value) {              
                _authData['password'] = value.trim();
                print('email saved -----> ${_authData['password']}');
              },
              validator: (_) {},
              obscureText: true,
            ),
          ],
        ),
      ),
    );
  }
}

class _AuthFailedAlert extends StatelessWidget {
  const _AuthFailedAlert({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: kBaseWhiteColor,
      title: Text('Error'),
      content: Text('Invalid email or password!'),
      actions: [
        CupertinoButton(
          child: Container(
            width: 120,
            height: 40,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Theme.of(context).accentColor,
              borderRadius: BorderRadius.circular(25),
            ),
            child: Text(
              'Close',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: kBaseWhiteColor,
              ),
            ),
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ],
    );
  }
}

class _SubmitButton extends StatelessWidget {
  const _SubmitButton({
    Key key,
    @required this.authMode,
    this.onPressed,
  }) : super(key: key);

  final AuthMode authMode;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return CupertinoButton(
      child: Container(
        width: size.width,
        height: 50,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: kPrimaryColor,
          borderRadius: BorderRadius.circular(25),
        ),
        child: Text(
        'Sign Up',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: kBaseWhiteColor,
          ),
        ),
      ),
      onPressed: onPressed,
    );
  }
}

class _TextField extends StatelessWidget {
  
  const _TextField({
    Key key,
    this.hintText,
    this.controller,
    this.focusNode,
    this.onSaved,
    this.validator,
    this.obscureText = false,}) : super(key: key);

  final FocusNode focusNode;
  final TextEditingController controller;
  final bool obscureText;
  final String hintText;
  final Function onSaved;
  final Function validator;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55,
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.only(left: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        border: Border.all(color: Colors.transparent),
        color:kPrimaryColor.withOpacity(0.1)
      ),
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: TextFormField(
        
      focusNode: focusNode,
      controller: controller,
      style: TextStyle(
      fontSize: 16,
      color: Colors.blueGrey,
        ),
        obscureText: obscureText,
        decoration: InputDecoration(
      
        border: InputBorder.none,
        hintText: hintText,
        hintStyle:
        TextStyle(color:Colors.blueGrey[700], fontSize: 16),
        ),
        onSaved: onSaved,
        validator: validator,
      ),
       );
        }
         }