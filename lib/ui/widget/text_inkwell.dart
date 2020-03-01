import 'package:flutter/material.dart';

class ButtonSimpan extends StatelessWidget {
  Function action;
  String name;

  ButtonSimpan({this.action, this.name});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: action,
      child: Container(
        width: 300,
        height: 50,
      decoration: BoxDecoration(
        color: Colors.orange,
//          gradient:  LinearGradient(colors: [
//            Color(0xFF17ead9),
//            Color(0xFF6078ea)
//          ]),
        borderRadius: BorderRadius.circular(6.0),
        boxShadow: [
          BoxShadow(
              color: Color(0xFF6078ea).withOpacity(.3),
              offset: Offset(0.0, 8.0),
              blurRadius: 8.0)
        ]
      ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            child: Center(
              child: Text(name,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      letterSpacing: 1.0)),

            ),
          ),
        ),
      ),
    );
  }
}
