import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:netflix_ui_redesign/models/movie_model.dart';
import 'package:netflix_ui_redesign/screens/movie_screen.dart';
import 'package:netflix_ui_redesign/widgets/content_scroll.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 1, viewportFraction: 0.8);
  }

  Widget _movieSelector(int index) {
    return AnimatedBuilder(
      animation: _pageController,
      builder: (context, widget) {
        double value = 1;
        if (_pageController.position.haveDimensions) {
          value = _pageController.page - index;
          value = (1 - (value.abs() * 0.3) + 0.06).clamp(0.0, 1.0);
        }

        return Center(
          child: SizedBox(
            height: Curves.easeInOut.transform(value) * 270,
            width: Curves.easeInOut.transform(value) * 400,
            child: widget,
          ),
        );
      },
      child: GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (_) => MovieScreen(movie: movies[index])));
        },
        child: Stack(
          children: <Widget>[
            Center(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black54,
                          offset: Offset(0.0, 4.0),
                          blurRadius: 10)
                    ]),
                child: Center(
                  child: Hero(
                    tag: movies[index].imageUrl,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image(
                        image: AssetImage(movies[index].imageUrl),
                        height: 220,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              left: 30,
              bottom: 40,
              child: Container(
                width: 250,
                child: Text(
                  movies[index].title.toUpperCase(),
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        title: Image(
          image: AssetImage('assets/images/netflix_logo.png'),
          fit: BoxFit.cover,
          height: 50,
        ),
        centerTitle: true,
        leading: IconButton(
          padding: EdgeInsets.only(left: 30),
          onPressed: () => print('Menu'),
          icon: Icon(Icons.menu),
          iconSize: 30,
          color: Colors.black,
        ),
        actions: <Widget>[
          IconButton(
            padding: EdgeInsets.only(right: 30),
            onPressed: () => print('Menu'),
            icon: Icon(Icons.search),
            iconSize: 30,
            color: Colors.black,
          ),
        ],
      ),
      body: ListView(
        children: <Widget>[
          Container(
            height: 280,
            width: double.infinity,
            child: PageView.builder(
              controller: _pageController,
              itemCount: movies.length,
              itemBuilder: (context, index) {
                return _movieSelector(index);
              },
            ),
          ),
          Container(
            height: 96,
            child: ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 30),
              scrollDirection: Axis.horizontal,
              itemCount: labels.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: EdgeInsets.all(10),
                  width: 160,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Color(0xFFD45253),
                            Color(0xff9e1f28),
                          ]),
                      boxShadow: [
                        BoxShadow(
                            color: Color(0xFF9E1F28),
                            offset: Offset(0.0, 2.0),
                            blurRadius: 6)
                      ]),
                  child: Center(
                    child: Text(
                      labels[index].toUpperCase(),
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.8),
                    ),
                  ),
                );
              },
            ),
          ),
          SizedBox(
            height: 20,
          ),
          ContentScroll(
            images: myList,
            title: 'My List',
            imageHeight: 250,
            imageWidth: 150,
          ),
          SizedBox(
            height: 10,
          ),
          ContentScroll(
            images: popular,
            title: 'Popular',
            imageHeight: 250,
            imageWidth: 150,
          ),
        ],
      ),
    );
  }
}
