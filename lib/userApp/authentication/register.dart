import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final fullName = TextEditingController();
//hhhhh
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          color: Colors.yellow,
          child: Column(
            children: [
              SvgPicture.asset(
                'assets/signup.svg',
                fit: BoxFit.scaleDown,
              ),
              Container(
                decoration: BoxDecoration(
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(12)),
                child: TextFormField(
                  controller: fullName,
                  decoration: InputDecoration(
                      border: InputBorder.none, hintText: 'Fulll Name'),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
