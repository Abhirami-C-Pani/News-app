import 'dart:async';
import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:newsapp/constants/Apis.dart';
import 'package:newsapp/screens/detail.dart';
import 'dart:async' show Future, Timer;

class HomeApp extends StatefulWidget {
  @override
  _HomeAppState createState() => _HomeAppState();
}

class _HomeAppState extends State<HomeApp> with SingleTickerProviderStateMixin {
  bool afterTimer = false;
  TabController _tabController;
  VoidCallback onChanged;
  int _tabIndex = 0;
  DateTime today;
  DateTime yesterday;
  String todayString;
  String tomString;
  List articles;
  List source;
  http.Response jsonResponse;
  String api_key = '19ccf4f14a9e42708f8c7729f391e341';
  String urlString = '';
  Future<http.Response> getNewsList(String url) async {
    return http.get(url).then(
      (http.Response response) async {
        final int statusCode = response.statusCode;
        if (statusCode == 200) {
          setState(
            () {
              final jsonResponse = json.decode(response.body);
              print(jsonResponse);
              articles = jsonResponse['articles'];
              setState(() {});
            },
          );
          print("News Card api Successful");
        } else {
          print('News Card api error');
          throw Exception("News Card api error!");
        }
      },
    );
  }

  // void _handleTabChange() {
  //   if (_tabController.indexIsChanging) {
  //     switch (_tabController.index) {
  //       case 0:
  //         setState(() {
  //           getNewsList(
  //               'http://newsapi.org/v2/everything?q=bitcoin&from=$todayString&sortBy=publishedAt&apiKey=$api_key');
  //         });
  //         break;
  //       case 1:
  //         setState(() {
  //           getNewsList(
  //               'http://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=$api_key');
  //         });
  //         break;
  //       case 2:
  //         setState(() {
  //           getNewsList(
  //               'http://newsapi.org/v2/everything?q=apple&from=$tomString&to=$tomString&sortBy=popularity&apiKey=$api_key');
  //         });
  //         break;
  //       case 3:
  //         setState(() {
  //           getNewsList(Apis.techCrunch);
  //         });
  //         break;
  //       case 4:
  //         setState(() {
  //           getNewsList(Apis.wallstreet);
  //         });
  //         break;
  //     }
  //   }
  // }

  @override
  void initState() {
    _tabController = TabController(vsync: this, initialIndex: 0, length: 5);
    // _tabController.addListener(_handleTabChange);
    Timer(Duration(seconds: 3), () {
      setState(() {
        afterTimer = true;
      });
      setState(() {});
    });
    final now = DateTime.now();
    today = DateTime(now.year, now.month, now.day);
    yesterday = DateTime(now.year, now.month, now.day - 1);
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    final String todayFormatted = formatter.format(today);
    final String tomFormatted = formatter.format(yesterday);
    todayString = todayFormatted.toString();
    tomString = tomFormatted.toString();

    onChanged = () {
      setState(() {
        _tabIndex = this._tabController.index;
        print('Index');
        print(_tabController.index);
        if (_tabController.index == 0) {
      
          setState(() {
            getNewsList(
                'http://newsapi.org/v2/everything?q=bitcoin&from=$todayString&sortBy=publishedAt&apiKey=$api_key');
          });
        } else if (_tabController.index == 1) {
          setState(() {
            getNewsList(
                'http://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=$api_key');
          });
        } else if (_tabController.index == 2) {
          setState(() {
            getNewsList(
                'http://newsapi.org/v2/everything?q=apple&from=$tomString&to=$tomString&sortBy=popularity&apiKey=$api_key');
          });
        } else if (_tabController.index == 3) {
          setState(() {
            getNewsList(Apis.techCrunch);
          });
        } else if (_tabController.index == 4) {
          setState(() {
            getNewsList(Apis.wallstreet);
          });
        } else {
          setState(() {
            getNewsList(
                'http://newsapi.org/v2/everything?q=bitcoin&from=$todayString&sortBy=publishedAt&apiKey=$api_key');
          });
        }

      });
    };
    _tabController.addListener(onChanged);
    if (_tabIndex == 0) {
      getNewsList(
          'http://newsapi.org/v2/everything?q=bitcoin&from=$todayString&sortBy=publishedAt&apiKey=$api_key');
    } else if (_tabController.index == 2) {
      getNewsList(
          'http://newsapi.org/v2/everything?q=apple&from=$tomString&to=$tomString&sortBy=popularity&apiKey=$api_key');
    }

    super.initState();
  }

  @override
  void dispose() {
    _tabController.removeListener(onChanged);
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.grey[50],
            elevation: 0,
            title: Center(
              child: Text(
                'News',
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ),
            bottom: new TabBar(
              onTap: (_tabController) {
                // _handleTabChange();
              },
              controller: _tabController,
              isScrollable: true,
              labelColor: Colors.blue,
              unselectedLabelColor: Colors.grey,
              indicatorColor: Colors.blue,
              tabs: [
                GestureDetector(
                  child: Tab(
                    text: "Bit Coin",
                  ),
                  onTap: () {
                    setState(() {
                      _tabController.index = 0;
                      // _handleTabChange();
                    });
                  },
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _tabController.index = 1;
                      // _handleTabChange();
                    });
                  },
                  child: Tab(
                    text: "Business",
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _tabController.index = 2;
                      // _handleTabChange();
                    });
                  },
                  child: Tab(
                    text: "Apple",
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _tabController.index = 3;
                    });
                  },
                  child: Tab(
                    text: "TechCrunch",
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _tabController.index = 4;
                      // _handleTabChange();
                    });
                  },
                  child: Tab(
                    text: "Wall Street Journal",
                  ),
                ),
              ],
            ),
          ),
          body: (articles != null)
              ? ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  itemCount: articles.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 8),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DetailScreen(
                                (articles[index]['urlToImage'] != null
                                    ? articles[index]['urlToImage']
                                    : ''),
                                (articles[index]['title'] != null
                                    ? articles[index]['title']
                                    : ''),
                                (articles[index]['content'] != null
                                    ? articles[index]['content']
                                    : ''),
                                (articles[index]['url'] != null
                                    ? articles[index]['url']
                                    : ''),
                              ),
                            ),
                          );
                        },
                        child: Container(
                          // elevation: 0.3,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: Colors.black12,
                            ),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              ClipRRect(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  topRight: Radius.circular(10),
                                ),
                                child: Container(
                                  height: 210,
                                  width: MediaQuery.of(context).size.width - 10,
                                  child: (articles[index]['urlToImage'] != null)
                                      ? CachedNetworkImage(
                                          fit: BoxFit.cover,
                                          imageUrl: (articles[index]
                                                      ['urlToImage'] !=
                                                  null)
                                              ? articles[index]['urlToImage']
                                              : '',
                                          placeholder: (context, url) =>
                                              CircularProgressIndicator(),
                                          errorWidget: (context, url, error) =>
                                              Image.asset(
                                            'lib/images/images.png',
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width -
                                                10,
                                            fit: BoxFit.cover,
                                          ),
                                        )
                                      : Image.asset(
                                          'lib/images/images.png',
                                          fit: BoxFit.cover,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width -
                                              10,
                                        ),
                                ),
                              ),
                              // SizedBox(height:10),
                              Padding(
                                padding: const EdgeInsets.all(12),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    ClipRRect(
                                      borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(10),
                                        bottomRight: Radius.circular(10),
                                      ),
                                      child: Container(
                                        // decoration: BoxDecoration(),
                                        child: articles[index]['title'] != null
                                            ? Text(
                                                articles[index]['title'],
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              )
                                            : '',
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 8.0),
                                      child: Text(
                                        articles[index]['description'] != null
                                            ? articles[index]['description']
                                            : '',
                                        style: TextStyle(color: Colors.black54),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 8.0),
                                      child: Text(
                                        articles[index]['publishedAt'] != null
                                            ? articles[index]['publishedAt']
                                            : '',
                                        style: TextStyle(
                                          color: Colors.black54,
                                          fontSize: 9,
                                        ),
                                      ),
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
                )
              : (afterTimer == true)
                  ? Container(
                      child: Center(
                        child: Text('No news from this cateory'),
                      ),
                    )
                  : Container(
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),
        ),
      ),
    );
  }
}
