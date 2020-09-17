import 'package:flutter/material.dart';

class InputTextField extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String hintText;
  final bool obscureText;
  final TextInputType keyboardType;

  InputTextField(this.icon, this.color,
      {Key key,
      this.hintText,
      this.obscureText = false,
      this.keyboardType = TextInputType.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: inputWidget(icon, color,
          hintText: hintText,
          obscureText: obscureText,
          keyboardType: keyboardType),
    );
  }

  inputWidget(IconData icon, Color color,
      {String hintText,
      bool obscureText = false,
      TextInputType keyboardType = TextInputType.text}) {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.fromLTRB(20, 10, 20, 20),
          child: Icon(
            icon,
            color: color,
          ),
        ),
        Expanded(
          child: Column(
            children: [
              TextField(
                obscureText: obscureText,
                decoration: InputDecoration(
                    border: InputBorder.none, hintText: hintText),
                keyboardType: keyboardType,
              ),
              Divider(),
            ],
          ),
        ),
        SizedBox(
          width: 20,
        )
      ],
    );
  }
}
