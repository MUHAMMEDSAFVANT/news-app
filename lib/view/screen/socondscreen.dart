// ... (your imports)

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:pro/model/repository/heading.dart';
import 'package:pro/model/repository/newsheading.dart';
import 'package:pro/view/screen/thirdscreen.dart';
import 'package:url_launcher/url_launcher.dart';

class CarouselSliderExample1 extends StatefulWidget {
  CarouselSliderExample1({Key? key}) : super(key: key);

  @override
  _CarouselSliderExample1State createState() => _CarouselSliderExample1State();
}

class _CarouselSliderExample1State extends State<CarouselSliderExample1> {
  final news _newsHeadline = news();
  late Future<heading> _futureNews;

  @override
  void initState() {
    super.initState();
    _futureNews = _newsHeadline.newsrepositoryapi();
  }

  Future<void> _refreshNews() async {
    await Future.delayed(Duration(seconds: 2));

    setState(() {
      _futureNews = _newsHeadline.newsrepositoryapi();
    });
  }

  @override
  Widget build(BuildContext context) {
    return LiquidPullToRefresh(
      onRefresh: _refreshNews,
      child: FutureBuilder<heading>(
        future: _futureNews,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: ClipOval());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData ||
              snapshot.data?.articles == null ||
              snapshot.data?.articles?.isEmpty == true) {
            return Center(child: Text('No data available.'));
          } else {
            return SingleChildScrollView(
              child: Column(
                children: [
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: snapshot.data?.articles?.length ?? 0,
                    itemBuilder: (context, index) {
                      var article = snapshot.data!.articles![index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  DetailsPage(article: article),
                            ),
                          );
                        },
                        child: Container(
                          margin: EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.grey[200],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Image
                              Container(
                                height: 200,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(12),
                                    topRight: Radius.circular(15),
                                  ),
                                  image: DecorationImage(
                                    image: NetworkImage(
                                        article.urlToImage.toString()),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  article.title.toString(),
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  article.description.toString(),
                                  style: TextStyle(fontSize: 16),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 20),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Container(
                                      padding: EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                        border: Border.all(color: Colors.blue),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Row(
                                        children: [
                                          // Text(
                                          //   "RELASING DATE",style: GoogleFonts.roboto(fontSize: 16,),
                                          // ),
                                          Text(
                                            article.publishedAt.toString(),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Row(
                                    children: [
                                      IconButton(
                                        icon: Icon(
                                          Icons.share,
                                          size: 18,
                                        ),
                                        onPressed: () {
                                          _shareOnWhatsApp(
                                            article.title.toString(),
                                            article.url.toString(),
                                          );
                                        },
                                      ),
                                      IconButton(
                                        icon: Icon(
                                          Icons.chat,
                                          color: Colors.green[400],
                                          size: 16,
                                        ),
                                        onPressed: () {
                                          _openWhatsApp;
                                          child:
                                          Text("Chat on WhatsApp");
                                        },
                                      ),
                                      IconButton(
                                        icon: Icon(
                                          Icons.favorite,
                                          color: Colors.red,
                                          size: 18,
                                        ),
                                        onPressed: () {},
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}

void _shareOnWhatsApp(String title, String url) async {
  String whatsappUrl = "whatsapp://send?text=$title - $url";

  if (await canLaunch(whatsappUrl)) {
    await launch(whatsappUrl);
  } else {
    print("Could not launch WhatsApp");
  }
}

void _openWhatsApp() async {
  String phoneNumber = "7593036553";
  String message = "Hello, I'm interested in your article!";

  String url =
      "https://wa.me/$phoneNumber?text=${Uri.encodeComponent(message)}";

  if (await canLaunch(url)) {
    await launch(url);
  } else {
    print("Could not launch WhatsApp");
  }
}
