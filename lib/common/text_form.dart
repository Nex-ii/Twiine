import 'package:flutter/material.dart';
import 'package:twiine/colors.dart';
import 'package:twiine/screens/pre_login/register/signup/date_picker.dart';

class TextForm {
  static AppBar backBar(BuildContext context,
      {Function onTap, double appBarHeight = 30}) {
    return AppBar(
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      title: Text(''),
      toolbarHeight: appBarHeight,
      leading: new IconButton(
        icon: new Icon(Icons.arrow_back_ios),
        color: Colors.black,
        onPressed: () => Navigator.pop(context),
      ),
    );
  }

  static Future<void> popUp(BuildContext context, String msg) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Text(msg),
          actions: <Widget>[
            FlatButton(
              child: Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  static Widget textForm(
    List<FormElement> params,
    List<ButtonElement> buttons,
    GlobalKey formKey, {
    String title = "",
    AppBar appBar,
    double rowSpacing = 15,
    double headingSpacing = 20,
    double trailingSpacing = 30,
    OutlineInputBorder displayBorder,
    OutlineInputBorder focusedBorder,
  }) {
    if (displayBorder == null)
      displayBorder =
          OutlineInputBorder(borderRadius: BorderRadius.circular(15.0));
    if (focusedBorder == null)
      focusedBorder = OutlineInputBorder(
        borderSide: BorderSide(color: TwiineColors.red),
        borderRadius: BorderRadius.circular(25.0),
      );

    Column column = new Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        SizedBox(height: headingSpacing),
      ],
    );

    Scaffold scaffold = new Scaffold(
        appBar: appBar,
        body: Container(
          child: Padding(
            padding: EdgeInsets.fromLTRB(30, 30, 30, 0),
            child: SingleChildScrollView(
                child: Form(
              key: formKey,
              child: column,
            )),
          ),
        ));

    // Title Widget
    column.children.add(
      Padding(
        padding: const EdgeInsets.only(bottom: 30.0),
        child: Align(
          alignment: Alignment(-1, -1),
          child: Text(
            title,
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );

    Widget _buildTextField(FormElement element) {
      return TextFormField(
        controller: element._controller,
        decoration: InputDecoration(
          labelText: element._name,
          border: displayBorder,
          focusedBorder: focusedBorder,
        ),
        validator: element._validator == null
            ? (String value) {
                element._controller.text = element._controller.text.trim();
                if (value.isEmpty) {
                  return '${element._name} is Required';
                }
                return null;
              }
            : element._validator,
      );
    }

    bool isValidEmail(String input) {
      if (RegExp(
              r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
          .hasMatch(input)) {
        return true;
      } else {
        return false;
      }
    }

    Widget _buildEmailField(FormElement element) {
      return TextFormField(
        controller: element._controller,
        decoration: InputDecoration(
          labelText: element._name,
          border: displayBorder,
          focusedBorder: focusedBorder,
        ),
        validator: element._validator == null
            ? (String value) {
                element._controller.text = element._controller.text.trim();
                if (value.isEmpty) {
                  return 'Valid Email is Required';
                }
                if (!isValidEmail(value)) {
                  return 'Valid Email Address Required';
                }
                return null;
              }
            : element._validator,
      );
    }

    Widget _buildPasswordField(FormElement element) {
      return TextFormField(
        controller: element._controller,
        decoration: InputDecoration(
          labelText: element._name,
          border: displayBorder,
          focusedBorder: focusedBorder,
        ),
        obscureText: true,
        validator: element._validator,
      );
    }

    Widget _buildDateField(FormElement element) {
      return DatePickerField(controller: element._controller);
    }

    Widget _buildTermsAndServices(FormElement element) {
      return Align(
        alignment: Alignment.center,
        child: Padding(
          padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
          child: InkWell(
            child: Text(element._name, style: TextStyle(color: Colors.grey)),
            onTap: element._onTap,
          ),
        ),
      );
    }

    //text fields
    for (FormElement e in params) {
      switch (e._type) {
        case FormTypes.TEXTFIELD:
          column.children.add(_buildTextField(e));
          break;
        case FormTypes.EMAILFIELD:
          column.children.add(_buildEmailField(e));
          break;
        case FormTypes.PASSWORDFIELD:
          column.children.add(_buildPasswordField(e));
          break;
        case FormTypes.DATEFIELD:
          column.children.add(_buildDateField(e));
          break;
        case FormTypes.INKWELL:
          column.children.add(_buildTermsAndServices(e));
          break;
        default:
          break;
      }
      column.children.add(SizedBox(height: rowSpacing));
    }
    column.children.add(SizedBox(height: trailingSpacing));

    //buttons
    for (ButtonElement b in buttons) {
      column.children.add(
        ButtonTheme(
          minWidth: 300.0,
          height: 50.0,
          buttonColor: TwiineColors.red,
          child: RaisedButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: Text(
              b._name,
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
            onPressed: b._onTap,
          ),
        ),
      );
      column.children.add(SizedBox(height: rowSpacing));
    }

    return scaffold;
  }
}

class FormElement {
  String _name;
  FormTypes _type;
  Function _validator;
  TextEditingController _controller;
  Function _onTap;

  FormElement(String name, FormTypes type,
      {Function validator, TextEditingController controller, Function onTap}) {
    _name = name;
    _type = type;
    _validator = validator;
    _controller = controller;
    _onTap = onTap;
  }
}

enum FormTypes {
  TEXTFIELD,
  EMAILFIELD,
  PASSWORDFIELD,
  DATEFIELD,
  INKWELL,
}

class ButtonElement {
  String _name;
  Function _onTap;

  ButtonElement(String name, Function onTap) {
    _name = name;
    _onTap = onTap;
  }
}
