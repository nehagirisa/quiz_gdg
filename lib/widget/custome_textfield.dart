import 'package:flutter/material.dart';



class CustomeTextField extends StatelessWidget {
  CustomeTextField({
    required this.hintText,
    required this.contoller, 

  });
  final String hintText;
  final TextEditingController contoller;

  @override
  Widget build(BuildContext context) {
    return 
    Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
          
               decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
              child: TextField(
                style: TextStyle(color: Colors.black),
                controller: contoller,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: hintText,
                  contentPadding: EdgeInsets.only(top: 10, left: 10),
                ),
              ),
            ),
          );
  }
}




