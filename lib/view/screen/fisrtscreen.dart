import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pro/model/repository/heading.dart';
import 'package:pro/model/repository/newsheading.dart';
import 'package:pro/view/screen/thirdscreen.dart';

class CarouselSliderExample extends StatelessWidget {
  CarouselSliderExample({Key? key}) : super(key: key);

  final news _newsHeadline = news();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<heading>(
      future: _newsHeadline.newsrepositoryapi(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (!snapshot.hasData ||
            snapshot.data?.articles == null ||
            snapshot.data?.articles?.isEmpty == true) {
          return Text('No data available.');
        } else {
          return Column(
            children: [
              SizedBox(
                width: double.infinity,
                child: CarouselSlider.builder(
                  itemCount: snapshot.data?.articles?.length ?? 0,
                  options: CarouselOptions(
                    height: 200,
                    autoPlay: true,
                    viewportFraction: 0.89,
                    enlargeCenterPage: true,
                    autoPlayCurve: Curves.fastOutSlowIn,
                    pageSnapping: true,
                    autoPlayAnimationDuration: const Duration(seconds: 1),
                  ),
                  itemBuilder: (context, index, pageView) {
                    var article = snapshot.data!.articles![index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DetailsPage(article: article),
                          ),
                        );
                      },
                      child: SizedBox(
                        
                        height: 300,

                        width: 700,

                        
                        child: Stack(
                          
                          
                          children: [
                            ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Stack(
                                  children: [
                                     Image.network(
                                        article.urlToImage ?? '',
                                        fit: BoxFit.cover,
                                      ),
                                    
                                   
                                    SizedBox(height: 30,),
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(10),
                                          child: Text(
                                            article.title ?? 'No Title',style: GoogleFonts.roboto(fontSize: 16,fontWeight: FontWeight.w800,color: Colors.white),
                                            // style: TextStyle(
                                            //   color: Colors.white,
                                            //   fontSize: 16,
                                            //   fontWeight: FontWeight.bold,
                                            // ),
                                            
                                            // textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                  
                                )),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        }
      },
    );
  }
}
