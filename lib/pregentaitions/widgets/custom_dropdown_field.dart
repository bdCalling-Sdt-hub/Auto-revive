import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomDropdown extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final Widget suffixIcon;

  CustomDropdown({
    required this.controller,
    required this.hintText,
    required this.suffixIcon,
  });

  @override
  _CustomDropdownState createState() => _CustomDropdownState();
}

class _CustomDropdownState extends State<CustomDropdown> {
  String? selectedOption;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      decoration: InputDecoration(
        hintText: widget.hintText,
        suffixIcon: PopupMenuButton<String>(
          icon: widget.suffixIcon,
          onSelected: (String value) {
            setState(() {
              selectedOption = value;
              widget.controller.text = value;
            });
          },
          itemBuilder: (BuildContext context) {
            return ['In Shop', 'On Site'].map((String option) {
              return PopupMenuItem<String>(
                value: option,
                child: Text(option),
              );
            }).toList();
          },
        ),
      ),
      readOnly: true,
    );
  }
}
