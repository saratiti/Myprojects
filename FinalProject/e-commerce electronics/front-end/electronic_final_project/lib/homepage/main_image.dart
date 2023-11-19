import 'package:carousel_slider/carousel_slider.dart';









import 'package:flutter/material.dart';



class MainImage extends StatefulWidget {
  @override
  _MainImageState createState() => _MainImageState();
}

class _MainImageState extends State<MainImage> {
  List<String> imageList = [
    "https://english.cdn.zeenews.com/sites/default/files/styles/zm_700x400/public/2023/01/20/1143871-twitter-2.jpg",
    "https://i.pinimg.com/originals/e2/ac/85/e2ac8573878a0dc2e30b22b0674ce13c.jpg",
    "https://im.hunt.in/cg/Jamshedpur/City-Guide/household.jpg",
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: MediaQuery.of(context).size.height * 0.2,
          child: CarouselSlider(
            options: CarouselOptions(
              height: MediaQuery.of(context).size.height * 0.2,
              viewportFraction: 1.0,
              enlargeCenterPage: false,
              autoPlay: true,
              autoPlayInterval: Duration(seconds: 3),
            ),
            items: imageList.map((image) {
              return Builder(
                builder: (BuildContext context) {
                  return Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(image),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.bottomRight,
                          colors: [
                            Colors.black.withOpacity(0.8),
                            Colors.black.withOpacity(0.2),
                          ],
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 50.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    "Our New Products",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  Row(
                                    children: <Widget>[
                                      Text(
                                        "VIEW MORE",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      SizedBox(width: 5),
                                      Icon(
                                        Icons.arrow_forward_ios,
                                        color: Colors.white,
                                        size: 15,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            }).toList(),
          ),
        ),
        const SizedBox(height: 8),
    Row(
  mainAxisAlignment: MainAxisAlignment.spaceBetween,
  children: [
    // Padding(
    //   padding: const EdgeInsets.only(left: 8),
    //   child: Text(
    //     'Catalog',
    //     style: TextStyle(
    //       fontSize: 18,
    //       color: ColorConstant.black90001,
    //       fontWeight: FontWeight.bold,
    //     ),
    //     textAlign: TextAlign.start,
    //   ),
    // ),
    // GestureDetector(
    //   onTap: () {
    //     Navigator.push(
    //       context,
    //       MaterialPageRoute(
    //         builder: (context) => CategoryScreen(),
    //       ),
    //     );
    //   },
    //   child: Row(
    //     children: [
    //       Text(
    //         'See All',
    //         style: TextStyle(
    //           fontSize: 14,
    //           color: ColorConstant.amber600,
    //         ),
    //         textAlign: TextAlign.end,
    //       ),
    //       Icon(
    //         Icons.arrow_forward,
    //         color: ColorConstant.amber600,
    //         size: 18,
    //       ),
    //     ],
    //   ),
    // ),
  ],
),


      ],
    );
  }
}
