import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:twiine/auth.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  var _imageURL =
      'https://firebasestorage.googleapis.com/v0/b/twiine.appspot.com/o/ImageStorage%2FProfilePicture?alt=media&token=9958176c-3b7f-457f-935c-04ff166ffe15';

  Container _buildDivider() {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 8.0,
      ),
      width: double.infinity,
      height: 1.0,
      color: Colors.grey.shade400,
    );
  }

  Widget createCardElement(CardElement element) {
    return ListTile(
      leading: element._icon,
      title: Text(element._text),
      trailing: Icon(Icons.keyboard_arrow_right),
      onTap: element._onTap,
    );
  }

  Widget createCardColumn(List<CardElement> elements) {
    Column col = new Column(
      children: <Widget>[],
    );
    for (int i = 0; i < elements.length; i++) {
      col.children.add(createCardElement(elements[i]));
      if (i == elements.length - 1) continue;
      _buildDivider();
    }
    return col;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Settings',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Stack(
        children: <Widget>[
          SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Card(
                  elevation: 8.0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0)),
                  color: Colors.red,
                  child: ListTile(
                      onTap: () {
                        //TODO: On Tap
                      },
                      title: Text(
                        "UserName Here",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      leading: CircleAvatar(
                        radius: 20, //Increase to have color ring around profile
                        backgroundColor: Colors.brown,
                        child: ClipOval(
                          child: SizedBox(
                            width: 40.0,
                            height: 40.0,
                            child: (_imageURL != null)
                                ? Image.network(_imageURL, fit: BoxFit.fill)
                                : Image.network(
                                    'https://avatars0.githubusercontent.com/u/8981287?s=460&u=4bf37a144d65af7f4d6aa1616fd734f83b566fac&v=4',
                                    fit: BoxFit.fill,
                                  ),
                          ),
                        ),
                      ),
                      trailing: Icon(Icons.edit, color: Colors.white)),
                ),
                const SizedBox(height: 10.0),
                Card(
                  elevation: 4.0,
                  margin: const EdgeInsets.all(16.0),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0)),
                  child: createCardColumn([
                    CardElement(
                        "Change Password",
                        Icon(
                          Icons.lock_outline,
                          color: Colors.red,
                        ),
                        () { Navigator.pushNamed(context, '/changePassword');}),
                    CardElement(
                        "Change Language",
                        Icon(
                          FontAwesomeIcons.language,
                          color: Colors.red,
                        ),
                        () {}),
                    CardElement(
                        "Change Location",
                        Icon(
                          Icons.location_on,
                          color: Colors.red,
                        ),
                        () {}),
                    CardElement(
                        "Link Accounts",
                        Icon(
                          FontAwesomeIcons.link,
                          color: Colors.red,
                        ),
                        () {}),
                    CardElement(
                        "Log Out",
                        Icon(
                          FontAwesomeIcons.signOutAlt,
                          color: Colors.red,
                        ),
                        _logOut),
                  ]),
                ),
                const SizedBox(height: 20.0),
                Text(
                  "Notification Settings",
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                SwitchListTile(
                  dense: true,
                  activeColor: Colors.red,
                  contentPadding: const EdgeInsets.all(0),
                  value: true,
                  title: Text("Receive Notifications"),
                  onChanged: (val) {},
                ),
                SwitchListTile(
                  dense: true,
                  activeColor: Colors.red,
                  contentPadding: const EdgeInsets.all(0),
                  value: true,
                  title: Text("Receive Newsletter"),
                  onChanged: null,
                ),
                SwitchListTile(
                  dense: true,
                  activeColor: Colors.red,
                  contentPadding: const EdgeInsets.all(0),
                  value: true,
                  title: Text("Receive Offers"),
                  onChanged: (val) {},
                ),
                SwitchListTile(
                  dense: true,
                  activeColor: Colors.red,
                  contentPadding: const EdgeInsets.all(0),
                  value: true,
                  title: Text("Receive App Updates"),
                  onChanged: null,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  _logOut() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool("hasLoggedIn", false);
    Navigator.pushNamedAndRemoveUntil(context, '/landing', (route) => false);
  }
}

class CardElement {
  String _text;
  Icon _icon;
  Function _onTap;

  CardElement(String text, Icon icon, Function onTap) {
    _text = text;
    _icon = icon;
    _onTap = onTap;
  }
}
