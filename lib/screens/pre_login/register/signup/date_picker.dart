import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DatePickerField extends StatefulWidget {
  final TextEditingController controller;
  DatePickerField({Key key, this.controller}) : super(key: key);

  @override
  DatePickerFieldState createState() => DatePickerFieldState();
}

class DatePickerFieldState extends State<DatePickerField> {
  String _dateTimeToString(DateTime date) {
    List<String> dateSplit = date.toString().split(" ")[0].split("-");
    return "${dateSplit[1]}/${dateSplit[2]}/${dateSplit[0]}";
  }

  void _showPlatformDatePicker() {
    // we can decide later if we want to use the ios picker for both
    if (Theme.of(context).platform == TargetPlatform.iOS) {
      showCupertinoModalPopup(
        context: context,
        builder: (BuildContext context) => SizedBox(
          height: 300,
          child: Container(
            decoration: BoxDecoration(color: Colors.white),
            child: CupertinoDatePicker(
              mode: CupertinoDatePickerMode.date,
              initialDateTime: DateTime.now(),
              maximumDate: DateTime.now(),
              minimumDate: DateTime(1900),
              onDateTimeChanged: (DateTime date) => {
                setState(
                  () {
                    widget.controller.text = _dateTimeToString(date);
                  },
                ),
              },
            ),
          ),
        ),
      );
    } else {
      showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1900),
        lastDate: DateTime.now(),
      ).then((DateTime date) {
        setState(() {
          widget.controller.text = _dateTimeToString(date);
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var _border = OutlineInputBorder(borderRadius: BorderRadius.circular(15.0));
    var _focusedBorder = OutlineInputBorder(
      borderSide: const BorderSide(color: Colors.green),
      borderRadius: BorderRadius.circular(25.0),
    );

    return TextFormField(
      readOnly: true,
      controller: widget.controller,
      decoration: InputDecoration(
        labelText: 'Birthday (MM/DD/YYYY)',
        hintText: "Example: 01/01/1990",
        border: _border,
        focusedBorder: _focusedBorder,
      ),
      onTap: () {
        _showPlatformDatePicker();
      },
    );
  }
}
