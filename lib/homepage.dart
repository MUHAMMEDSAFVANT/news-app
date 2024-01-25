import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pro/main.dart';
import 'package:pro/view/screen/fisrtscreen.dart';
import 'package:pro/view/screen/socondscreen.dart';

class homepage extends StatefulWidget {
  homepage({Key? key}) : super(key: key);

  @override
  State<homepage> createState() => _homepageState();
}

class _homepageState extends State<homepage> {
  Future<void> _refresh() async {
    await Future.delayed(Duration(seconds: 2));
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     
      appBar: AppBar(
        backgroundColor: Colors.white,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20, bottom: 2),
            child: Image.asset(
"lib/images/googlimage.png",              width: 30,
              height: 30,
              fit: BoxFit.cover,
            ),
          ),
        ],
        elevation: 0,
        title: Row(
          children: [
            SizedBox(width: 10),
            Center(
              child: Padding(
                padding: const EdgeInsets.only(left: 70),
                child: Center(
                  child: Text(
                    "NEWS18",
                    style: TextStyle(color: Colors.red[800], fontSize: 40),
                  ),
                ),
              ),
            ),
          ],
        ),
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      body: RefreshIndicator(
        onRefresh: _refresh,
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(),
              Padding(
                padding: const EdgeInsets.only(right: 45),
                child: Padding(
                  padding: const EdgeInsets.all(7),
                  child: Text(
                    "TRENDING NEWS",
                    style: GoogleFonts.aBeeZee(
                      fontSize: 25,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 1,
              ),
              SizedBox(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CarouselSliderExample(),
                  ],
                ),
              ),
              SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: CarouselSliderExample1(),
              ),
            ],
          ),
        ),
      ),
      drawer: MyApp(),
    );
  }
}
