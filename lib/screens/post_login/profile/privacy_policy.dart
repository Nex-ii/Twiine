import 'package:flutter/material.dart';

class PrivacyPolicy extends StatefulWidget {
  @override
  _PrivacyPolicyState createState() => _PrivacyPolicyState();
}

class _PrivacyPolicyState extends State<PrivacyPolicy> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        title: Text('Privacy Policy'),
    ),
    body: SingleChildScrollView(
    child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisSize: MainAxisSize.max,
    children: <Widget>[
      _createParagraph(
          "",
          """Protecting your private information is our priority. This Statement of Privacy applies to twiine.com
and Nex-ii LLC and governs data collection and usage. For the purposes of this Privacy Policy,
unless otherwise noted, all references to Nex-ii LLC include twiine.com, Nex-ii, Twiine,
twiine.com and twiine.co. The Nex-ii website is a Information about product site. By using the
Nex-ii website, you consent to the data practices described in this statement."""
      ),
      _createParagraph(
          'Collection of your Personal Information',
          """In order to better provide you with products and services offered on our Site, Nex-ii may collect
personally identifiable information, such as your:

    - First and Last Name
    - Mailing Address
    - E-mail Address
    - Phone Number

If you purchase Nex-ii's products and services, we collect billing and credit card information. This
information is used to complete the purchase transaction.

Nex-ii may also collect anonymous demographic information, which is not unique to you, such as
your:

    - Age
    - Gender

We do not collect any personal information about you unless you voluntarily provide it to us.
However, you may be required to provide certain personal information to us when you elect to use
certain products or services available on the Site. These may include: (a) registering for an account
on our Site; (b) entering a sweepstakes or contest sponsored by us or one of our partners; (c)
signing up for special offers from selected third parties; (d) sending us an email message; (e)
submitting your credit card or other payment information when ordering and purchasing products
and services on our Site. To wit, we will use your information for, but not limited to,
communicating with you in relation to services and/or products you have requested from us. We
also may gather additional personal or non-personal information in the future."""
      ),
      _createParagraph(
          'Use of your Personal Information',
          """Nex-ii collects and uses your personal information to operate its website(s) and deliver the
services you have requested.

Nex-ii may also use your personally identifiable information to inform you of other products or
services available from Nex-ii and its affiliates."""
      ),
      _createParagraph(
          'Sharing Information with Third Parties',
          """Nex-ii does not sell, rent or lease its customer lists to third parties.

Nex-ii may share data with trusted partners to help perform statistical analysis, send you email or
postal mail, provide customer support, or arrange for deliveries. All such third parties are
prohibited from using your personal information except to provide these services to Nex-ii, and
they are required to maintain the confidentiality of your information.

Nex-ii may disclose your personal information, without notice, if required to do so by law or in the
good faith belief that such action is necessary to: (a) conform to the edicts of the law or comply
with legal process served on Nex-ii or the site; (b) protect and defend the rights or property of
Nex-ii; and/or (c) act under exigent circumstances to protect the personal safety of users of Nex-ii,
or the public."""
      ),
      _createParagraph(
          'Automatically Collected Information',
          """Information about your computer hardware and software may be automatically collected by Nex-
ii. This information can include: your IP address, browser type, domain names, access times and
referring website addresses. This information is used for the operation of the service, to maintain
quality of the service, and to provide general statistics regarding use of the Nex-ii website."""
      ),
      _createParagraph(
          'Use of Cookies',
          """The Nex-ii website may use "cookies" to help you personalize your online experience. A cookie is
a text file that is placed on your hard disk by a web page server. Cookies cannot be used to run
programs or deliver viruses to your computer. Cookies are uniquely assigned to you, and can only
be read by a web server in the domain that issued the cookie to you.

One of the primary purposes of cookies is to provide a convenience feature to save you time. The
purpose of a cookie is to tell the Web server that you have returned to a specific page. For
example, if you personalize Nex-ii pages, or register with Nex-ii site or services, a cookie helps
Nex-ii to recall your specific information on subsequent visits. This simplifies the process of
recording your personal information, such as billing addresses, shipping addresses, and so on.
When you return to the same Nex-ii website, the information you previously provided can be
retrieved, so you can easily use the Nex-ii features that you customized.

You have the ability to accept or decline cookies. Most Web browsers automatically accept
cookies, but you can usually modify your browser setting to decline cookies if you prefer. If you
choose to decline cookies, you may not be able to fully experience the interactive features of the
Nex-ii services or websites you visit."""
      ),
      _createParagraph(
          'Links',
          """This website contains links to other sites. Please be aware that we are not responsible for the
content or privacy practices of such other sites. We encourage our users to be aware when they
leave our site and to read the privacy statements of any other site that collects personally
identifiable information."""
      ),
      _createParagraph(
          'Security of your Personal Information',
          """Nex-ii secures your personal information from unauthorized access, use, or disclosure. Nex-ii uses
the following methods for this purpose:

    - SSL Protocol

When personal information (such as a credit card number) is transmitted to other websites, it is
protected through the use of encryption, such as the Secure Sockets Layer (SSL) protocol.

We strive to take appropriate security measures to protect against unauthorized access to or
alteration of your personal information. Unfortunately, no data transmission over the Internet or any
wireless network can be guaranteed to be 100% secure. As a result, while we strive to protect
your personal information, you acknowledge that: (a) there are security and privacy limitations
inherent to the Internet which are beyond our control; and (b) security, integrity, and privacy of any
and all information and data exchanged between you and us through this Site cannot be
guaranteed."""
      ),
      _createParagraph(
          'Right to Deletion',
          """Subject to certain exceptions set out below, on receipt of a verifiable request from you, we will:

    • Delete your personal information from our records; and
    • Direct any service providers to delete your personal information from their records.

Please note that we may not be able to comply with requests to delete your personal information if
it is necessary to:

    • Complete the transaction for which the personal information was collected, fulfill the
    terms of a written warranty or product recall conducted in accordance with federal
    law, provide a good or service requested by you, or reasonably anticipated within the
    context of our ongoing business relationship with you, or otherwise perform a contract
    between you and us;
    • Detect security incidents, protect against malicious, deceptive, fraudulent, or illegal
    activity; or prosecute those responsible for that activity;
    • Debug to identify and repair errors that impair existing intended functionality;
    • Exercise free speech, ensure the right of another consumer to exercise his or her right
    of free speech, or exercise another right provided for by law;
    • Comply with the California Electronic Communications Privacy Act;
    • Engage in public or peer-reviewed scientific, historical, or statistical research in the
    public interest that adheres to all other applicable ethics and privacy laws, when our
    deletion of the information is likely to render impossible or seriously impair the
    achievement of such research, provided we have obtained your informed consent;
    • Enable solely internal uses that are reasonably aligned with your expectations based on
    your relationship with us;
    • Comply with an existing legal obligation; or
    • Otherwise use your personal information, internally, in a lawful manner that is
    compatible with the context in which you provided the information."""
      ),
      _createParagraph(
          'Children Under Thirteen',
          """Nex-ii does not knowingly collect personally identifiable information from children under the age of
thirteen. If you are under the age of thirteen, you must ask your parent or guardian for permission
to use this website."""
      ),
      _createParagraph(
          'Disconnecting your Nex-ii Account from Third Party Websites',
          """You will be able to connect your Nex-ii account to third party accounts. BY CONNECTING
YOUR NEX-II ACCOUNT TO YOUR THIRD PARTY ACCOUNT, YOU
ACKNOWLEDGE AND AGREE THAT YOU ARE CONSENTING TO THE
CONTINUOUS RELEASE OF INFORMATION ABOUT YOU TO OTHERS (IN
ACCORDANCE WITH YOUR PRIVACY SETTINGS ON THOSE THIRD PARTY SITES).
IF YOU DO NOT WANT INFORMATION ABOUT YOU, INCLUDING PERSONALLY
IDENTIFYING INFORMATION, TO BE SHARED IN THIS MANNER, DO NOT USE
THIS FEATURE. You may disconnect your account from a third party account at any time. My
Account Page"""
      ),
      _createParagraph(
          'E-mail Communications',
          """From time to time, Nex-ii may contact you via email for the purpose of providing announcements,
promotional offers, alerts, confirmations, surveys, and/or other general communication.

If you would like to stop receiving marketing or promotional communications via email from Nex-
ii, you may opt out of such communications by clicking on Unsubscribe button."""
      ),
      _createParagraph(
          'Changes to this Statement',
          """Nex-ii reserves the right to change this Privacy Policy from time to time. We will notify you about
significant changes in the way we treat personal information by sending a notice to the primary
email address specified in your account, by placing a prominent notice on our site, and/or by
updating any privacy information on this page. Your continued use of the Site and/or Services
available through this Site after such modifications will constitute your: (a) acknowledgment of the
modified Privacy Policy; and (b) agreement to abide and be bound by that Policy."""
      ),
      _createParagraph(
          'Contact Information',
          """Nex-ii welcomes your questions or comments regarding this Statement of Privacy. If you believe
that Nex-ii has not adhered to this Statement, please contact Nex-ii at:

Nex-ii LLC
82 Ray
Irvine, California 92618

Email Address:
support@twiine.co

Telephone number:
(626)375-5110

Effective as of August 12, 2020"""
      )
    ],),
    )

    );
  }
}

Widget _createParagraph(String title, String body) {
  RichText temp = RichText(
    text: new TextSpan(
      style: TextStyle(
        fontSize: 14.0,
        color: Colors.black,
      ),
      children: <TextSpan>[
        new TextSpan(text: "\n" + title + "\n", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        new TextSpan(text: body,)
      ],
    ),
  );
  return temp;
}