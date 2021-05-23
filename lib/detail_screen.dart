import 'package:flutter/material.dart';
import 'package:wisata_bandung/model/tourism_place.dart';

class FavoriteButton extends StatefulWidget {
  const FavoriteButton({Key key}) : super(key: key);

  @override
  _FavoriteButtonState createState() => _FavoriteButtonState();
}

class _FavoriteButtonState extends State<FavoriteButton> {
  bool isFavorite = false;
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(isFavorite ? Icons.favorite : Icons.favorite_border,
          color: Colors.red),
      onPressed: () {
        setState(() {
          isFavorite = !isFavorite;
        });
      },
    );
  }
}

class DetailScreen extends StatelessWidget {
  final informationTextStyle = TextStyle(fontFamily: 'Oxygen');
  final TourismPlace place;
  DetailScreen({@required this.place});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      if (constraints.maxWidth > 800) {
        return DetailWebPage(place: place);
      } else {
        return DetailMobilePage(
          place: place,
        );
      }
    });
  }
}

class DetailWebPage extends StatefulWidget {
  final TourismPlace place;

  DetailWebPage({this.place});

  @override
  _DetailWebPageState createState() => _DetailWebPageState();
}

class _DetailWebPageState extends State<DetailWebPage> {
  final informationTextStyle = TextStyle(fontFamily: 'Oxygen');

  final _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 64),
        child: Center(
          child: Container(
            width: 1200,
            child: Column(
              children: [
                Text(
                  "Wisata Bandung",
                  style: TextStyle(
                    fontSize: 32,
                    fontFamily: "Staatliches",
                  ),
                ),
                SizedBox(height: 32),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image(
                              image: AssetImage(widget.place.imageAsset),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 32),
                    Expanded(
                      child: Card(
                        child: Container(
                          padding: EdgeInsets.all(16),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Container(
                                child: Text(
                                  widget.place.name,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontFamily: "Staatliches",
                                    fontSize: 30,
                                  ),
                                ),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Icon(Icons.calendar_today),
                                      SizedBox(width: 8.0),
                                      Text(widget.place.openDays),
                                    ],
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Icon(Icons.access_time),
                                      SizedBox(width: 8.0),
                                      Text(widget.place.openTime),
                                    ],
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Icon(Icons.monetization_on),
                                      SizedBox(width: 8.0),
                                      Text(widget.place.ticketPrice),
                                    ],
                                  ),
                                ],
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(vertical: 16.0),
                                child: Text(
                                  widget.place.description,
                                  textAlign: TextAlign.justify,
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    fontFamily: "Oxygen",
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 200.0,
                  child: Scrollbar(
                    isAlwaysShown: true,
                    controller: _scrollController,
                    child: ListView(
                      controller: _scrollController,
                      scrollDirection: Axis.horizontal,
                      children: widget.place.imageUrls.map(
                        (url) {
                          return Padding(
                            padding: EdgeInsets.all(8.0),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.network(url),
                            ),
                          );
                        },
                      ).toList(),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}

class DetailMobilePage extends StatelessWidget {
  final informationTextStyle = TextStyle(fontFamily: 'Oxygen');
  final TourismPlace place;
  DetailMobilePage({this.place});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Stack(
                children: [
                  Image(image: AssetImage(place.imageAsset)),
                  SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.white,
                            child: IconButton(
                              icon: Icon(
                                Icons.arrow_back,
                                color: Colors.black,
                              ),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ),
                          ),
                          FavoriteButton(),
                        ],
                      ),
                    ),
                  )
                ],
              ),
              Container(
                margin: EdgeInsets.only(top: 10.0),
                child: Center(
                  child: Text(
                    place.name,
                    style: TextStyle(
                      fontFamily: "Staatliches",
                      fontSize: 23.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(children: [
                      Icon(Icons.calendar_today),
                      SizedBox(
                        height: 10.0,
                      ),
                      Text(
                        place.openDays,
                        style: informationTextStyle,
                      )
                    ]),
                    Column(children: [
                      Icon(Icons.access_time),
                      SizedBox(
                        height: 10.0,
                      ),
                      Text(
                        place.openTime,
                        style: informationTextStyle,
                      )
                    ]),
                    Column(children: [
                      Icon(Icons.monetization_on),
                      SizedBox(
                        height: 10.0,
                      ),
                      Text(
                        place.ticketPrice,
                        style: informationTextStyle,
                      )
                    ]),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      place.description,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16.0,
                        fontFamily: "Oxygen",
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                height: 150,
                child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: place.imageUrls.map((url) {
                      return Padding(
                          padding: EdgeInsets.all(8.0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.network(url),
                          ));
                    }).toList()),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
