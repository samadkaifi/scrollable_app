import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ScrollApp extends StatefulWidget {
  @override
  _ScrollAppState createState() => _ScrollAppState();
}

class _ScrollAppState extends State<ScrollApp> {
  var data;

  Future<Map> getList() async {
    final response = await http.get(
        Uri.parse(
            "http://website-bucket-12234.s3-website-us-east-1.amazonaws.com/api.json"),
        headers: <String, String>{
          'Content-Type': 'application/json',
        });

    if (response.statusCode == 200) {
      data = jsonDecode(response.body);
      print('Data from MovieList: ' + data["data"].toString());
      print(data["data"]["components"].length);

      return data;
    } else {
      throw Exception("Unable to load Images");
    }
  }

  Future? pictures;

  @override
  void initState() {
    pictures = getList();
    super.initState();
  }

  ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height;
    final deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: FutureBuilder(
        future: pictures,
        builder: (ctx, snapshot) => snapshot.connectionState ==
                ConnectionState.waiting
            ? Center(
                child: CircularProgressIndicator(
                  backgroundColor: Colors.white,
                  valueColor:
                      new AlwaysStoppedAnimation<Color>(Colors.blueGrey),
                ),
              )
            : SafeArea(
                child: Container(
                  height: deviceHeight,
                  width: deviceWidth,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  margin: EdgeInsets.all(deviceWidth * 0.01),
                  child: Scrollbar(

                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Container(
                            margin: EdgeInsets.symmetric(vertical: deviceWidth*.02),
                            width: deviceWidth * .3,
                            height: 7.5,
                            decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Column(
                              children: [
                                Container(
                                  height: deviceHeight * .9,
                                  width: deviceWidth,
                                  padding: EdgeInsets.all(deviceWidth * .05),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.vertical(
                                        top: Radius.circular(30)),
                                    image: DecorationImage(
                                      image: NetworkImage(
                                          data["data"]["coverUrl"].toString()),
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        data["data"]["title"].toString(),
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  // width: deviceWidth,
                                  // height: deviceWidth * .45,
                                  decoration: BoxDecoration(
                                    color: Color(0XFFfff8da),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          data["data"]['components'][1]["title"].toString(),
                                          style: TextStyle(
                                              color: Colors.black54,
                                              fontSize: 21),
                                        ),
                                        Text(
                                          data["data"]['components'][1]["desc"].toString(),
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 6,
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w200,
                                          ),
                                        ),
                                        SizedBox(
                                          height: deviceWidth * .02,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: deviceWidth * 0.03,
                                ),
                                Container(
                                  alignment: Alignment.bottomCenter,
                                  height: deviceHeight * 0.4,
                                  width: deviceWidth * 0.9,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(30),
                                    image: DecorationImage(
                                        image: NetworkImage(
                                            data["data"]["components"][0]["url"].toString()),
                                        fit: BoxFit.fill),
                                  ),
                                ),
                                Container(
                                  // width: deviceWidth,
                                  // height: deviceWidth * .45,
                                  decoration: BoxDecoration(
                                    color: Color(0XFFfff8da),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          data["data"]['components'][3]["title"].toString(),
                                          style: TextStyle(
                                              color: Colors.black54,
                                              fontSize: 18),
                                        ),
                                        Text(
                                          data["data"]['components'][3]["desc"].toString(),
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 6,
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w200,
                                          ),
                                        ),
                                        SizedBox(
                                          height: deviceWidth * .02,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: deviceWidth * 0.03,
                                ),
                                Container(
                                  alignment: Alignment.bottomCenter,
                                  height: deviceHeight * 0.4,
                                  width: deviceWidth * 0.9,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(30),
                                    image: DecorationImage(
                                        image: NetworkImage(
                                            data["data"]["components"][2]["url"].toString()),
                                        fit: BoxFit.fill),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
      ),
    );
  }
}
