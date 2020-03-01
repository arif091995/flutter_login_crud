import 'package:flutter/material.dart';
import 'package:passwordfield/passwordfield.dart';

class TextPassword extends StatelessWidget {
   // Initially password is obscure
  bool passwordVisible = true;
  Function action;
  Function textInput;
  String textNama;
  String textHint;

  TextPassword({this.passwordVisible, this.action, this.textHint, this.textNama, this.textInput});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          textNama,
          style: TextStyle(
              fontSize: 10, letterSpacing: 0),
        ),
        // PasswordField(
        //   hintText: textHint, hintStyle: TextStyle(color: Colors.grey, fontSize: 15.0,),
        //   errorMessage: 'Password Minimal 7 Karakter',
        // )
        TextFormField(
        maxLines: 1,
        autofocus: false,
        obscureText: passwordVisible,
          decoration: InputDecoration(
              hintText: textHint,
              hintStyle: TextStyle(
                  color: Colors.grey, fontSize: 15.0,),
                  suffixIcon: IconButton(
                    icon: Icon(
                      passwordVisible ? Icons.visibility : Icons.visibility_off,
                      color: Colors.grey,
                    ),
                    onPressed: action,
                  )
              ),
        validator: (value) => value.isEmpty ? 'Cek Lagi' : null,
        onSaved: textInput,
        ),
      ],
    );
  }
}