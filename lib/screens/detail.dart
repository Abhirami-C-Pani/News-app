import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:cached_network_image/cached_network_image.dart';

class DetailScreen extends StatefulWidget {
  final String image;
  final String title;
  final String details;
  final String urlString;
  DetailScreen(this.image, this.title, this.details, this.urlString);
  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  String imageString;
  String url;
  @override
  void initState() {
    super.initState();
    imageString = this.widget.image;
    url = this.widget.urlString;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: Stack(
          children: <Widget>[
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height / 2.82,
                    // height: 210,
                    child: (imageString != null || imageString.isNotEmpty)
                        ? CachedNetworkImage(
                            fit: BoxFit.cover,
                            imageUrl: imageString,
                            placeholder: (context, imageString) =>
                                CircularProgressIndicator(),
                            errorWidget: (context, imageString, error) =>
                                Image.asset(
                              'lib/images/images.png',
                              fit: BoxFit.cover,
                              width: MediaQuery.of(context).size.width,
                            ),
                          )
                        : Image.asset(
                            'lib/images/images.png',
                            fit: BoxFit.cover,
                            width: MediaQuery.of(context).size.width,
                          ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 17, right: 17, top: 24, bottom: 17),
                    child: Text(
                      this.widget.title,
                      style: TextStyle(
                        fontSize: 20,
                        height: 1.3,
                        color: Colors.black87,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 17, right: 17),
                    child: Text(
                      this.widget.details,
                      style: TextStyle(
                        color: Colors.black87,
                        fontSize: 17,
                        height: 1.5,
                        fontWeight: FontWeight.w300,
                        wordSpacing: 1,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 0,
              child: GestureDetector(
                onTap: () async {
                  if (url != null) {
                    if (await canLaunch(url)) {
                      await launch(
                        url,
                      );
                    } else {
                      throw 'Could not launch $url';
                    }
                  }
                },
                child: ClipRRect(
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 50,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(this.widget.image),
                        // onError: AssetImage(assetName),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: 65,
                        alignment: Alignment.center,
                        color: Colors.black.withOpacity(.6),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              'VIEW ON SITE',
                              style: TextStyle(
                                color: Colors.white,
                                // fontWeight: FontWeight.w500,
                                fontSize: 14,
                                letterSpacing: 1,
                              ),
                            ),
                            SizedBox(width: 5),
                            Icon(
                              Icons.launch,
                              size: 16,
                              color: Colors.white,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
