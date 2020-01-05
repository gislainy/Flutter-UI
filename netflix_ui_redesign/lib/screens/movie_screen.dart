import 'package:flutter/material.dart';
import 'package:netflix_ui_redesign/models/movie_model.dart';
import 'package:netflix_ui_redesign/widgets/circular_clipper.dart';
import 'package:netflix_ui_redesign/widgets/content_scroll.dart';

class MovieScreen extends StatefulWidget {
  final Movie movie;

  const MovieScreen({Key key, this.movie}) : super(key: key);

  @override
  _MovieScreenState createState() => _MovieScreenState();
}

class _MovieScreenState extends State<MovieScreen> {
  Widget _information(String title, String info) {
    return Column(
      children: <Widget>[
        Text(
          title,
          style: TextStyle(color: Colors.black54, fontSize: 16),
        ),
        SizedBox(
          height: 2,
        ),
        Text(
          info,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        children: <Widget>[
          Stack(
            children: <Widget>[
              Container(
                child: Hero(
                  tag: widget.movie.imageUrl,
                  child: ClipShadowPath(
                      clipper: CircularClipper(),
                      shadow: Shadow(blurRadius: 20),
                      child: Image(
                        image: AssetImage(widget.movie.imageUrl),
                        height: 400,
                        fit: BoxFit.cover,
                      )),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  IconButton(
                      padding: EdgeInsets.only(left: 30),
                      onPressed: () => Navigator.pop(context),
                      icon: Icon(Icons.arrow_back),
                      iconSize: 30,
                      color: Colors.black),
                  Image(
                    image: AssetImage('assets/images/netflix_logo.png'),
                    height: 60,
                    width: 150,
                  ),
                  IconButton(
                      padding: EdgeInsets.only(right: 30),
                      onPressed: () => print('Add to Favorites'),
                      icon: Icon(Icons.favorite_border),
                      iconSize: 30,
                      color: Colors.black),
                ],
              ),
              Positioned.fill(
                bottom: 10,
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: RawMaterialButton(
                    padding: EdgeInsets.all(10),
                    elevation: 12,
                    onPressed: () => print('Play Video'),
                    shape: CircleBorder(),
                    fillColor: Colors.white,
                    child: Icon(Icons.play_arrow, size: 60, color: Colors.red),
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                left: 20,
                child: IconButton(
                    onPressed: () => print('Add to My List'),
                    icon: Icon(Icons.add),
                    iconSize: 40,
                    color: Colors.black),
              ),
              Positioned(
                bottom: 0,
                right: 20,
                child: IconButton(
                    onPressed: () => print('Share'),
                    icon: Icon(Icons.share),
                    iconSize: 35,
                    color: Colors.black),
              )
            ],
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 40,
              vertical: 20,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  widget.movie.title.toUpperCase(),
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  widget.movie.categories,
                  style: TextStyle(
                    color: Colors.black54,
                    fontSize: 16,
                  ),
                ),
                SizedBox(
                  height: 12,
                ),
                Text(
                  '⭐ ⭐ ⭐ ⭐',
                  style: TextStyle(fontSize: 25.0),
                ),
                SizedBox(
                  height: 25,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    _information('Year', widget.movie.year.toString()),
                    _information('Country', widget.movie.country.toString()),
                    _information('Legth', '${widget.movie.length} min'),
                  ],
                ),
                SizedBox(
                  height: 25,
                ),
                Container(
                    height: 120,
                    child: SingleChildScrollView(
                        child: Text(
                      widget.movie.description,
                      style: TextStyle(color: Colors.black54),
                    ))),
              ],
            ),
          ),
          ContentScroll(
            images: widget.movie.screenshots,
            title: 'Screenshots',
            imageHeight: 200,
            imageWidth: 250,
          )
        ],
      ),
    );
  }
}
