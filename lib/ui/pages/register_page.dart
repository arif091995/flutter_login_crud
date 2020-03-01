import 'package:flutter/material.dart';
import 'package:flutter_login_demo/services/authentication.dart';
import 'package:flutter_login_demo/ui/widget/text_inkwell.dart';
import 'package:flutter_login_demo/ui/widget/text_input.dart';
import 'package:flutter_login_demo/ui/widget/text_password.dart';

class RegisterPage extends StatefulWidget {
  RegisterPage({this.auth, this.loginCallback});

  final BaseAuth auth;
  final VoidCallback loginCallback;

  @override
  State<StatefulWidget> createState() => new _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = new GlobalKey<FormState>();

  String _email;
  String _password;
  String _errorMessage;

  bool _isLoginForm;
  bool _isLoading;
  bool _passwordVisible;
  bool _check = false;

  // Check if form is valid before perform login or signup
  bool validateAndSave() {
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  // Perform login or signup
  void validateAndSubmit() async {
    setState(() {
      _errorMessage = "";
      _isLoading = true;
    });
    if (validateAndSave()) {
      String userId = "";
      try {
        if (_isLoginForm) {
          userId = await widget.auth.signIn(_email, _password);
          print('Signed in: $userId');
        } else {
          userId = await widget.auth.signUp(_email, _password);
          //widget.auth.sendEmailVerification();
          //_showVerifyEmailSentDialog();
          print('Signed up user: $userId');
        }
        setState(() {
          _isLoading = false;
        });

        if (userId.length > 0 && userId != null && _isLoginForm) {
          widget.loginCallback();
        }
      } catch (e) {
        print('Error: $e');
        setState(() {
          _isLoading = false;
          _errorMessage = e.message;
          _formKey.currentState.reset();
        });
      }
    }
  }

  @override
  void initState() {
    _errorMessage = "";
    _isLoading = false;
    _isLoginForm = true;
    _passwordVisible = false;
    _check = false;
    super.initState();
  }

  void resetForm() {
    _formKey.currentState.reset();
    _errorMessage = "";
  }

  void toggleFormMode() {
    resetForm();
    setState(() {
      _isLoginForm = !_isLoginForm;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        backgroundColor: Colors.blueGrey,
        body: Stack(
          children: <Widget>[
            _showForm(),
            _showCircularProgress(),
          ],
        ));
  }

  Widget _showCircularProgress() {
    if (_isLoading) {
      return Center(child: CircularProgressIndicator());
    }
    return Container(
      height: 0.0,
      width: 0.0,
    );
  }

  Widget _showForm() {
    return new Container(
        padding: EdgeInsets.all(16.0),
        child: new Form(
          key: _formKey,
          child: new ListView(
            shrinkWrap: true,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(
                  bottom: 20,
                ),
                child: Text(
                  "Daftar",
                  style: TextStyle(color: Colors.yellow, fontSize: 15.0),
                ),
              ),
              SingleChildScrollView(
                child: Container(
                  child: Column(
                    children: <Widget>[
                      Container(
                        width: 300,
                        height: 400,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black12,
                                  offset: Offset(0.0, 15.0),
                                  blurRadius: 15.0),
                              BoxShadow(
                                  color: Colors.black12,
                                  offset: Offset(0.0, -10.0),
                                  blurRadius: 10.0),
                            ]),
                        child: Padding(
                          padding:
                              EdgeInsets.only(top: 10, left: 20, right: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              TextInput(
                                textNama: 'Nama Lengkap',
                                textHint: 'Nama Lengkap',
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              TextInput(
                                textNama: 'Email',
                                textHint: 'Email',
                                textInputS: (value) =>
                                    _email = value.toString().trim(),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              TextInput(
                                textNama: 'Nomer HP',
                                textHint: 'Nomer HP',
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              TextPassword(
                                passwordVisible: _passwordVisible,
                                textNama: 'Kata Sandi',
                                textHint: 'Kata Sandi',
                                action: () {
                                  setState(() {
                                    _passwordVisible = !_passwordVisible;
                                  });
                                },
                                textInput: (value) =>
                                    _password = value.toString().trim(),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              TextPassword(
                                passwordVisible: _passwordVisible,
                                textNama: 'Ulang Kata Sandi',
                                textHint: 'Ulang Kata Sandi',
                                // action: (){
                                //   setState(() {
                                //     _passwordVisible = !_passwordVisible;
                                //   });
                                // },
                                // textInput: (value) =>
                                //       _password = value.toString().trim(),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20.0),
                        child: Row(
                          children: <Widget>[
                            Checkbox(
                              value: _check,
                              onChanged: (bool value) {
                                setState(() {
                                  _check = value;
                                });
                              },
                            ),
                            Column(
                              children: <Widget>[
                                Container(
                                  child: Row(
                                    children: <Widget>[
                                      Text(
                                        "Saya setuju memahami",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(left: 2),
                                        child: Text(
                                          "Syarat ",
                                          style:
                                              TextStyle(color: Colors.yellow),
                                        ),
                                      ),
                                      Text(
                                        "dan",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  child: Row(
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.only(left: 2),
                                        child: Text(
                                          "Ketentuan ",
                                          style:
                                              TextStyle(color: Colors.yellow),
                                        ),
                                      ),
                                      Text(
                                        "Serta manfaat produk ini",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20.0),
                        child: ButtonSimpan(
                          name: 'Daftar',
                          action: validateAndSubmit,
                        ),
                      ),
                      showErrorMessage(),
                    ],
                  ),
                ),
              )
              // showLogo(),
              // showEmailInput(),
              // showPasswordInput(),
              // showPrimaryButton(),
              // showSecondaryButton(),
              // showErrorMessage(),
            ],
          ),
        ));
  }

  Widget showErrorMessage() {
    if (_errorMessage.length > 0 && _errorMessage != null) {
      return new Text(
        _errorMessage,
        style: TextStyle(
            fontSize: 13.0,
            color: Colors.red,
            height: 1.0,
            fontWeight: FontWeight.w300),
      );
    } else {
      return new Container(
        height: 0.0,
      );
    }
  }

  Widget showLogo() {
    return new Hero(
      tag: 'hero',
      child: Padding(
        padding: EdgeInsets.fromLTRB(0.0, 70.0, 0.0, 0.0),
        child: CircleAvatar(
          backgroundColor: Colors.transparent,
          radius: 48.0,
          child: Image.asset('assets/flutter-icon.png'),
        ),
      ),
    );
  }

  Widget showEmailInput() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 100.0, 0.0, 0.0),
      child: new TextFormField(
        maxLines: 1,
        keyboardType: TextInputType.emailAddress,
        autofocus: false,
        decoration: new InputDecoration(
            hintText: 'Email',
            icon: new Icon(
              Icons.mail,
              color: Colors.grey,
            )),
        validator: (value) => value.isEmpty ? 'Email can\'t be empty' : null,
        onSaved: (value) => _email = value.trim(),
      ),
    );
  }

  Widget showPasswordInput() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 0.0),
      child: new TextFormField(
        maxLines: 1,
        obscureText: true,
        autofocus: false,
        decoration: new InputDecoration(
            hintText: 'Password',
            icon: new Icon(
              Icons.lock,
              color: Colors.grey,
            )),
        validator: (value) => value.isEmpty ? 'Password can\'t be empty' : null,
        onSaved: (value) => _password = value.trim(),
      ),
    );
  }

  Widget showSecondaryButton() {
    return new FlatButton(
        child: new Text(
            _isLoginForm ? 'Create an account' : 'Have an account? Sign in',
            style: new TextStyle(fontSize: 18.0, fontWeight: FontWeight.w300)),
        onPressed: toggleFormMode);
  }

  Widget showPrimaryButton() {
    return new Padding(
        padding: EdgeInsets.fromLTRB(0.0, 45.0, 0.0, 0.0),
        child: SizedBox(
          height: 40.0,
          child: new RaisedButton(
            elevation: 5.0,
            shape: new RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(30.0)),
            color: Colors.blue,
            child: new Text(_isLoginForm ? 'Login' : 'Create account',
                style: new TextStyle(fontSize: 20.0, color: Colors.white)),
            onPressed: validateAndSubmit,
          ),
        ));
  }
}
