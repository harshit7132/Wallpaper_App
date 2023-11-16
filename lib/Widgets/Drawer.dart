// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var AccImgAdd =
        "https://www.superprof.co.in/images/teachers/teacher-home-the-basic-purpose-education-develop-society-gain-knowledge-give-knowledge.jpg";
    return Drawer(
      backgroundColor: const Color.fromARGB(255, 21, 2, 44),
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(left: size.width * 0.02),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                  radius: size.width * 0.1,
                  backgroundImage: NetworkImage(AccImgAdd)),
              SizedBox(height: size.height * 0.01),
              Text(
                'Vishesh',
                style: TextStyle(
                  // fontFamily: GoogleFonts.poppins().fontFamily,
                  color: Colors.white,
                  fontSize: size.width * 0.05,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2,
                ),
              ),
              Text(
                'VisheshPanghal12@gmail.com',
                style: TextStyle(
                  // fontFamily: GoogleFonts.poppins().fontFamily,
                  color: Colors.grey.shade400,
                  fontSize: size.width * 0.03,
                ),
              ),
              const Divider(
                thickness: 1,
                color: Colors.grey,
              ),
              SizedBox(height: size.height * 0.05),
              DrawerListWidget(
                icn: Icons.home,
                title: 'Home',
              ),
              SizedBox(height: size.height * 0.02),
              DrawerListWidget(
                icn: Icons.favorite,
                title: 'Favourite',
              ),
              SizedBox(height: size.height * 0.02),
              DrawerListWidget(
                icn: Icons.category,
                title: 'Category',
              ),
              SizedBox(height: size.height * 0.02),
              DrawerListWidget(
                icn: Icons.assistant,
                title: 'Genrate an Image',
              ),
              SizedBox(height: size.height * 0.02),
              DrawerListWidget(
                icn: Icons.settings,
                title: 'Settings',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DrawerListWidget extends StatelessWidget {
  String title;
  IconData icn;
  DrawerListWidget({
    Key? key,
    required this.title,
    required this.icn,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Icon(
          icn,
          color: Colors.white,
          size: size.width * 0.06,
        ),
        SizedBox(width: size.width * 0.1),
        Text(
          title.toUpperCase(),
          style: TextStyle(
            // fontFamily: GoogleFonts.poppins().fontFamily,
            color: Colors.white,
            fontSize: size.width * 0.05,
          ),
        ),
      ],
    );
  }
}
