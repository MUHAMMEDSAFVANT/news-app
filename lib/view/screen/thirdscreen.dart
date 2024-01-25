import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pro/homepage.dart';
import 'package:pro/model/repository/heading.dart';

class DetailsPage extends StatelessWidget {
  final Articles article;

  DetailsPage({required this.article});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 400,
            pinned: true,
            floating: true,
            flexibleSpace: FlexibleSpaceBar(
              background: ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(35),
                  bottomRight: Radius.circular(25),
                ),
                child: Image.network(
                  article.urlToImage ?? '',
                  filterQuality: FilterQuality.high,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    print("Error loading image: $error");
                    return Placeholder(); // Placeholder widget or any other fallback image
                  },
                ),
              ),
            ),
            leading: Container(
              height: 70,
              width: 80,
              margin: EdgeInsets.only(
                top: 16,
                right: 16,
              ),
              decoration: BoxDecoration(
                color: Colors.black12,
                borderRadius: BorderRadius.circular(8),
              ),
              child: IconButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => homepage()),
                  );
                },
                icon: Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                ),
              ),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 1, top: 16),
                child: IconButton(
                  icon: Icon(
                    Icons.favorite,
                    color: Colors.red,
                  ),
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Article saved!'),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                AnimatedTextKit(
                  animatedTexts: [
                    TyperAnimatedText(
                      article.title ?? 'No Title',
                      textStyle: GoogleFonts.openSans(
                        fontSize: 30,
                        fontWeight: FontWeight.w800,
                      ),
                      textAlign: TextAlign.center,
                      speed: Duration(milliseconds: 100),
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                Text(
                  article.description.toString(),
                  style: GoogleFonts.roboto(
                    fontSize: 25,
                    fontWeight: FontWeight.w400,
                  ),
                  textAlign: TextAlign.justify,
                ),
                SizedBox(
                  height: 1,
                ),
                Text(
                  article.content.toString(),
                  style: GoogleFonts.roboto(
                    fontSize: 25,
                    fontWeight: FontWeight.w400,
                  ),
                  textAlign: TextAlign.justify,
                ),
                SizedBox(
                  height: 16,
                ),
                SizedBox(
                  child: Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.blue),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          children: [
                            Text(
                              "RELEASE DATE",
                              style: GoogleFonts.roboto(fontSize: 16),
                            ),
                            Text(
                              article.publishedAt.toString(),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                SizedBox(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      // Additional widgets or components
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
