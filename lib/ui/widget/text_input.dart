import 'package:flutter/material.dart';

class TextInput extends StatelessWidget {
   String textNama;
   String textHint;
   Function textInputS;

  TextInput({this.textNama, this.textHint,this.textInputS });

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
        TextFormField(
        maxLines: 1,
        autofocus: false,
          decoration: InputDecoration(
              hintText: textHint,
              hintStyle: TextStyle(
                  color: Colors.grey, fontSize: 15.0,)),
        validator: (value) => value.isEmpty ? 'Cek Lagi' : null,
        onSaved: textInputS,
        ),
      ],
    );
  }
}
