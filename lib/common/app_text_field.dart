import 'package:flutter/material.dart';

class AppTextField extends StatefulWidget {

  final Widget child;
  final String Function(String) validator;
  final String Function(String) onSaved;
  final String Function(String) onChanged;
  final String labelText;
  final String hintText;
  final bool obscureText;
  final TextInputType keyboardType;

  AppTextField({
    Key key,
    @required this.child,
    this.validator,
    this.onSaved,
    this.onChanged,
    @required this.labelText,
    this.hintText,
    this.obscureText,
    this.keyboardType,

  }) :super(key: key);

  _AppTextField createState() => _AppTextField();
}

class _AppTextField extends State<AppTextField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
          labelText: widget.labelText,
          hintText: widget.hintText ?? '',
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(15.0)),
          focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.green),
              borderRadius: BorderRadius.circular(25.0)
          )
      ),
      validator: widget.validator ?? (String value) {
        if (value.isEmpty) {
          return widget.labelText + ' is Required';
        }
        return null;
      },
      onSaved: widget.onSaved ?? null,
      onChanged: widget.onChanged ?? null,
      obscureText: widget.obscureText ?? false,
      keyboardType: widget.keyboardType ?? null,
    );
  }
}