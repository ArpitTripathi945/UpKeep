import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AboutView extends StatelessWidget {
  const AboutView({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
        color: Color.fromARGB(255, 15, 17, 32),
        child: Container(
          padding: EdgeInsets.fromLTRB(15, 50, 15, 20),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(children: <Widget>[
                  IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                        size: 30,
                      )),
                  SizedBox(width: 15),
                  Text(
                    'UpKeep',
                    style: TextStyle(
                        fontSize: 30,
                        fontFamily: GoogleFonts.inter().fontFamily,
                        color: Colors.white,
                        fontWeight: FontWeight.w900),
                  ),
                ]),
                SizedBox(height: 25),
                Text(
                  'About',
                  style: TextStyle(
                      color: Colors.white,
                      fontFamily: GoogleFonts.inter().fontFamily,
                      fontSize: 17,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 4),
                Text(
                    'Hello user! UpKeep is a budgeting app purely build for a person like you who likes to keep track of his expenses, as we say a penny saved is a penny earned. Here you can add your expenses by giving the amount, the tag under which the expense comes. Also you can provide a short note in case you want to remember something about your expense. ',
                    style: TextStyle(
                      color: Colors.white70,
                      fontFamily: GoogleFonts.inter().fontFamily,
                      fontSize: 13,
                    )),
                SizedBox(height: 15),
                Text('What are Tags?',
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: GoogleFonts.inter().fontFamily,
                        fontSize: 17,
                        fontWeight: FontWeight.bold)),
                SizedBox(height: 4),
                Text(
                  'Tags are used to filter your expense and put them under some category like Food, Travel, Rent etc. It helps you to monitor your expenses under particular categories and to get a better understanding in which areas you should save more. ',
                  style: TextStyle(
                    color: Colors.white70,
                    fontFamily: GoogleFonts.inter().fontFamily,
                    fontSize: 13,
                  ),
                ),
                SizedBox(height: 15),
                Text('What is Notes?',
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: GoogleFonts.inter().fontFamily,
                        fontSize: 17,
                        fontWeight: FontWeight.bold)),
                SizedBox(height: 4),
                Text(
                    'Notes as they go by their name they will help you to remember any minute details regarding your expense. ',
                    style: TextStyle(
                      color: Colors.white70,
                      fontFamily: GoogleFonts.inter().fontFamily,
                      fontSize: 13,
                    )),
                SizedBox(height: 30),
                Text(' Enjoy your Journey',
                    style: TextStyle(
                        color: Colors.blueAccent,
                        fontFamily: GoogleFonts.caveat().fontFamily,
                        fontSize: 45,
                        fontWeight: FontWeight.bold)),
                SizedBox(height: 15),
                Text('     with UpKeep!',
                    style: TextStyle(
                        color: Colors.blueAccent,
                        fontFamily: GoogleFonts.caveat().fontFamily,
                        fontSize: 45,
                        fontWeight: FontWeight.bold)),
              ]),
        ));
  }
}
