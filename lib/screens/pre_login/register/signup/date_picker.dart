import 'package:flutter/material.dart';

class DatePickerField extends StatefulWidget {
  final TextEditingController controller;
  DatePickerField({Key key, this.controller}) : super(key: key);

  @override
  DatePickerFieldState createState() => DatePickerFieldState();
}

class DatePickerFieldState extends State<DatePickerField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      readOnly: true,
      controller: widget.controller,
      decoration: InputDecoration(
          labelText: 'Birthday (MM/DD/YYYY)', hintText: "Example: 01/01/1990"),
      onTap: () {
        showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(1900),
          lastDate: DateTime.now(),
        ).then((DateTime date) {
          setState(() {
            List<String> dateSplit = date.toString().split(" ")[0].split("-");
            String dateStr = "${dateSplit[1]}/${dateSplit[2]}/${dateSplit[0]}";
            widget.controller.text = dateStr;
            print(widget.controller.text);
          });
        });
      },
    );
  }
}
