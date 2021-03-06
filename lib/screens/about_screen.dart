import 'package:flu_tic_tac_toe/widgets/headers.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutScreen extends StatefulWidget {
  static const String _id = 'about';
  static String get id => _id;

  @override
  _AboutScreenState createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(0.0),
        child: AppBar(),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 24.0, horizontal: 16.0),
              child: Header(label: 'About Us'),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.symmetric(vertical: 16.0),
                      child: Image.asset(
                        'assets/icons/brand.png',
                        width: MediaQuery.of(context).size.width * 0.5,
                      ),
                    ),
                    Text(
                      'Flu Tic Tac Toe',
                      style: Theme.of(context).textTheme.headline1
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 32.0, vertical: 16.0),
                      child: Text(
                        'Flu Tic Tac Toe is an online game application to '
                        'play tic tac toe together with your friend. This '
                        'application is open source and build using Flutter '
                        'and Firebase.',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodyText2,
                      ),
                    ),
                    Text(
                      'Visit our Project',
                      style: Theme.of(context).textTheme.headline2,
                    ),
                    GestureDetector(
                      onTap: () async {
                        const url = 'https://github.com/ukayaj620/flu-tictactoe';
                        if (await canLaunch(url)) {
                          await launch(
                            url,
                            forceSafariVC: false,
                            forceWebView: false,
                          );
                        } else {
                          throw 'Could not launch $url';
                        }
                      },
                      child: Container(
                        alignment: Alignment.center,
                        child: Image.asset(
                          'assets/vectors/github.png',
                          width: MediaQuery.of(context).size.width * 0.5,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        )
      )
    );
  }
}
