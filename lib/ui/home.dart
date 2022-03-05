// ignore_for_file: deprecated_member_use

import 'dart:io';
import 'package:flutter/material.dart';
import '../models/movie.dart';
import '../models/questions.dart';
import 'movie_ui/movie_ui.dart';
class MovieListView extends StatelessWidget {

  
final List<Movie> movieList = Movie.getMovies();

  final List movies = [
    "Titanic",
    "Blade Runner",
    "Rambo", 
    "The Avengers",
    "Avatar",
    "I am Legend",
    "300",
    "The Wolf of Wall Street",
    "Interstellar",
    "Game of Thrones",
    "Vikings"  
  ];
  @override
  Widget build(BuildContext context) { 
    return Scaffold(
      appBar: AppBar(
        title: Text("Movies"),
        backgroundColor: Colors.blueGrey.shade900,
      ),
      backgroundColor: Colors.blueGrey.shade900,
      body: ListView.builder(
        itemCount: movieList.length,
        itemBuilder: (BuildContext context, int index) {
          return Stack(children:[
            movieCard(movieList[index], context),
            Positioned(child: movieImage(movieList.elementAt(index).images[0]),
             top: 10.0,
            ),
          ],
          );
      })
      
    );
  }

  TextStyle mainTextStyle() {
    return TextStyle(
            fontSize: 15.0,
            color: Colors.grey
            );
  }

  Widget movieCard(Movie movie, BuildContext context) {
    return InkWell(
      child: Container(
        margin: EdgeInsets.only(left: 60),
        width: MediaQuery.of(context).size.width,
        height: 120.0,
        child: Card(
          color: Colors.black45,
          child: Padding(
            padding: const EdgeInsets.only(top: 8.0, bottom: 8.0, left: 54.0),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [ 
                    Flexible(
                      child: Text(movie.title, style: TextStyle(
                        fontSize: 17.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white
                      )),
                    ),
                    Text("Rating: ${movie.imdbRating} / 10", style: mainTextStyle(),)]),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text("Released: ${movie.released}" , style: mainTextStyle()),
                        Text(movie.runtime, style: mainTextStyle()),
                        Text(movie.stringRated, style: mainTextStyle())
                      ],
                    )
                ],
              ),
            ),
          )
        )

      ),
      onTap: () {
        Navigator.push(context, MaterialPageRoute(
          builder: (context) =>  MovieListViewDetails(movieName: movie.title, 
          movie: movie)));
      },
    );
  }

  Widget movieImage(String imageUrl) {
      return Container(
        width: 100,
        height: 100,
        decoration: BoxDecoration(
          shape: BoxShape.circle, 
          image: DecorationImage(
            image: NetworkImage(imageUrl),
            fit: BoxFit.cover 
          )
        ),
      );
  }
}

class MovieListViewDetails extends StatelessWidget {

  final String movieName;
  final Movie movie;

  const MovieListViewDetails({Key? key, required this.movieName, required this.movie}) : super(key: key); 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Movies"),
        backgroundColor: Colors.blueGrey,
      ),
      body: ListView(children: [
        MovieDetailsThumbnail(thumbnail: movie.images[0]),
        MovieDEtailsHeaderWithPoster(movie: movie),
        HorizontalLine(),
        MovieDetailsCast(movie: movie),
        HorizontalLine(),
        MovieDetailsExtraPosters(posters: movie.images,)
      ],)
      // body: Container(
      //   child: Center(
      //     child: RaisedButton( 
      //       onPressed: () {
      //         Navigator.pop(context);
      //       },
      //       child: Text("Go Back  ${this.movieName}"),
      //       ),
      //   )
      // )
    );
  }
}

class QuizApp extends StatefulWidget {
  const QuizApp({ Key? key }) : super(key: key);

  @override
  _QuizAppState createState() => _QuizAppState();
}

class _QuizAppState extends State<QuizApp> {

  int _currentQuestionIndex = 0;

  List questionBank = [
    Question.name("First Question", true),
    Question.name("Second Question", true),
    Question.name("Third Question", false),
    Question.name("Fourth Question", true)
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("True Citizen"),
        centerTitle: true,
        backgroundColor: Colors.blueGrey,
      ),
      backgroundColor: Colors.blueGrey,
      body: Builder(
        builder: (BuildContext context) {
          return Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Center(
                    child: Image.asset("images/newyork.jpg", 
                    width: 250, 
                    height: 180,),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.blueGrey,
                      borderRadius: BorderRadius.circular(8.0),
                      border: Border.all(
                        color: Colors.blueGrey.shade400,
                        style: BorderStyle.solid

                      )
                    ),
                    height: 120.0,
                    child: Center(
                      child: Text(questionBank[_currentQuestionIndex].questionText, style: TextStyle(
                        color: Colors.white,
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold )),
                    )
                    ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    RaisedButton(onPressed: () {
                      return _checkAnswer(true, context);},
                    color: Colors.blueGrey.shade900,
                    child: Text("TRUE", style: TextStyle(
                      color: Colors.green
                    ))
                    ),
                    RaisedButton(onPressed: () {
                      return _checkAnswer(false, context);},
                    color: Colors.blueGrey.shade900,
                    child: Text("FALSE", style: TextStyle(
                      color: Colors.red
                    )),
                    ),
                    RaisedButton(onPressed: () => _nextQuestion(),
                    color: Colors.blueGrey.shade900,
                    child: Icon(Icons.arrow_forward, color: Colors.white)   
                    )
                    
                  ],
                ),
                Spacer(),
              ],
              
            )
          );
        }
      )
    );
  }
  _checkAnswer(bool userChoice, BuildContext context) {
    if(userChoice == questionBank[_currentQuestionIndex].isCorrect) {
      // answer is correct!
      final snackbar = SnackBar(
        content: Row(children: [Text("Correct"), Icon(Icons.check_box)],),
       backgroundColor: Colors.green,
       duration: Duration(milliseconds: 500), );
      Scaffold.of(context).showSnackBar(snackbar);
    }
    else {
      // answer is incorrect.
      final snackbar = SnackBar(
        content: Row(children: [Text("Incorrect. X ")],), 
      backgroundColor: Colors.red,
      duration: Duration(milliseconds: 500));
      Scaffold.of(context).showSnackBar(snackbar);
     
      
    }
     _nextQuestion();
  }

  _nextQuestion() {
    setState(() {
      _currentQuestionIndex = (_currentQuestionIndex + 1) % questionBank.length;  
    });
    
  }
}


class BillSpliter extends StatefulWidget {
  const BillSpliter({Key? key}) : super(key: key);

  @override
  _BillSpliterState createState() => _BillSpliterState();
}

class _BillSpliterState extends State<BillSpliter> {

  int _tipPercentage = 0;
  int _personCounter = 1;
  double _billAmount = 0;
  Color _purple = Color(0xff6908d6);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            margin:
                EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.1),
            alignment: Alignment.center,
            color: Colors.white24,
            child: ListView(
              scrollDirection: Axis.vertical,
              padding: EdgeInsets.all(20.2),
              children: [
                Container(
                    width: 150,
                    height: 150,
                    decoration: BoxDecoration(
                      color: _purple.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [Text("Total Per Person", style: TextStyle(
                          color: _purple,
                          fontSize: 15,
                          fontWeight: FontWeight.normal
                        )), Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Text("\$ ${calculateTotalPerPerson(_billAmount, _personCounter, _tipPercentage)}", style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 32,
                            color: _purple
                          )),
                        )],
                      ),
                    )),
                Container(
                    margin: EdgeInsets.only(top: 20.0),
                    padding: EdgeInsets.all(12.0),
                    decoration: BoxDecoration(
                        color: Colors.transparent,
                        border: Border.all(
                            color: Colors.blueGrey.shade100,
                            style: BorderStyle.solid),
                        borderRadius: BorderRadius.circular(20.0)),
                    child: Column(
                      children: [
                        TextField(
                          keyboardType:
                              TextInputType.numberWithOptions(decimal: true),
                          style: TextStyle(color: _purple),
                          decoration: InputDecoration(
                              prefixText: "Bill Amount:",
                              prefixIcon: Icon(Icons.monetization_on_rounded)),
                          onChanged: (String value) {
                            try {
                              _billAmount = double.parse(value);
                            } catch (exception) {
                              _billAmount = 0.0;
                            }
                          },
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Split",
                                style: TextStyle(
                                  color: Colors.grey.shade700,
                                )),
                            Row(
                              children: [
                                InkWell(
                                    onTap: () {
                                      setState(() {
                                        if (_personCounter > 1) {
                                          _personCounter--;
                                        } else {}
                                      });
                                    },
                                    child: Container(
                                        width: 40.0,
                                        height: 40.0,
                                        margin: EdgeInsets.all(10.0),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(7.0),
                                            color: _purple.withOpacity(0.1)),
                                        child: Center(
                                          child: Text("-",
                                              style: TextStyle(
                                                  color: _purple,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 17.0)),
                                        ))),
                                Text("$_personCounter",
                                    style: TextStyle(
                                        color: _purple,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 17.0)),
                                InkWell(
                                    onTap: () {
                                      setState(() {
                                        _personCounter++;
                                      });
                                    },
                                    child: Container(
                                        width: 40.0,
                                        height: 40.0,
                                        margin: EdgeInsets.all(10.0),
                                        decoration: BoxDecoration(
                                            color: _purple.withOpacity(0.1),
                                            borderRadius:
                                                BorderRadius.circular(7.0)),
                                        child: Center(
                                          child: Text("+",
                                              style: TextStyle(
                                                  color: _purple,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 17.0)),
                                        ))),
                              ],
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Tip",
                                style: TextStyle(
                                  color: Colors.grey.shade700,
                                )),
                            Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Center(
                                child: Text("\$ ${(calculateTotalTip(_billAmount, _personCounter, _tipPercentage)).toStringAsFixed(2)}", style: TextStyle(
                                  color: _purple,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),),
                              ),
                            )
                          ],
                        ),
                        Column(
                          children: [
                            Text("$_tipPercentage %",
                                style: TextStyle(
                                    color: _purple,
                                    fontSize: 17.0,
                                    fontWeight: FontWeight.bold)),
                            Slider(
                                activeColor: _purple,
                                inactiveColor: Colors.grey,
                                divisions: 20,
                                min: 0,
                                max: 100,
                                value: _tipPercentage.toDouble(),
                                onChanged: (double value) {
                                  setState(() {
                                    _tipPercentage = value.round();
                                  });
                                })
                          ],
                        )
                      ],
                    ))
              ],
            )));
  }

  calculateTotalPerPerson(double billAmount, int splitBy, int tipPercentage ) {
    var totalPerPerson = (calculateTotalTip(_billAmount, _personCounter, tipPercentage) + billAmount) / splitBy;
    return totalPerPerson.toStringAsFixed(2);
  }
  calculateTotalTip(double billAmount, int splitBy, int tipPercentage) {
    double totalTip = 0.0;
    if(billAmount < 0 || billAmount.toString().isEmpty || billAmount == null) {

    }
    else {
      totalTip = (billAmount * _tipPercentage) / 100;
      return totalTip;
    }
  }
}


class Wisdom extends StatefulWidget {
  const Wisdom({Key? key}) : super(key: key);

  @override
  _WisdomState createState() => _WisdomState();
}

class _WisdomState extends State<Wisdom> {
  int _index = 0;
  List quotes = ["Güne iyi başla", "Kahvaltı yap.", "Mutlu ol.", "Gülümse."];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Expanded(
          child: Center(
            child: Container(
                width: 350,
                height: 150,
                margin: EdgeInsets.all(30.0),
                decoration: BoxDecoration(
                    color: Colors.black87,
                    borderRadius: BorderRadius.circular(20.0)),
                child: Center(
                    child: Text(quotes[_index % quotes.length],
                        style: TextStyle(
                            color: Colors.blueGrey,
                            fontStyle: FontStyle.italic,
                            fontSize: 20.5)))),
          ),
        ),
        Divider(
          thickness: 1.2,
        ),
        Padding(
          padding: const EdgeInsets.only(top: 8.0),
          // ignore: deprecated_member_use
          child: FlatButton.icon(
              color: Colors.greenAccent.shade700,
              onPressed: _showQuote,
              icon: Icon(Icons.wb_sunny_rounded),
              label: Text(
                "Inspired me!",
                style: TextStyle(color: Colors.black87, fontSize: 18.5),
              )),
        ),
        Spacer(flex: 2)
      ],
    )));
  }

  void _showQuote() {
    setState(() {
      _index++;
    });
  }
}


class BizCard extends StatelessWidget {
  const BizCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("BizCard")),
        backgroundColor: Colors.grey,
        body: Container(
            alignment: Alignment.topCenter,
            margin: EdgeInsets.fromLTRB(1, 50, 1, 150),
            child: Stack(
              alignment: Alignment.topCenter,
              children: <Widget>[_getCard(), _getAvatar()],
            )));
  }

  Container _getCard() {
    return Container(
        width: 350,
        height: 250,
        margin: EdgeInsets.all(50),
        decoration: BoxDecoration(
            color: Colors.deepPurpleAccent,
            borderRadius: BorderRadius.circular(14.5)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("Emir Balkan \n\n",
                style: TextStyle(
                    fontSize: 15.5,
                    color: Colors.amber,
                    fontWeight: FontWeight.w500)),
            Text("Sabancı University\n"),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.attach_email),
                Text("balkanemir@sabanciuniv.edu")
              ],
            )
          ],
        ));
  }

  Container _getAvatar() {
    return Container(
        width: 100,
        height: 100,
        decoration: BoxDecoration(
            color: Colors.blueAccent,
            borderRadius: BorderRadius.all(Radius.circular(50.0)),
            border: Border.all(color: Colors.deepPurpleAccent, width: 1.2),
            image: DecorationImage(
                image: NetworkImage("https://picsum.photos/300/300"),
                fit: BoxFit.cover)));
  }
}

class ScaffoldExample extends StatelessWidget {
  const ScaffoldExample({Key? key}) : super(key: key);

  tappedButton() {
    return debugPrint("Butten Tapped.");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Scaffold"),
        centerTitle: true,
        backgroundColor: Colors.amberAccent.shade700,
        actions: <Widget>[
          IconButton(
              onPressed: () => debugPrint("Account Opened."),
              icon: Icon(Icons.account_circle_outlined)),
          IconButton(
              onPressed: tappedButton, icon: Icon(Icons.add_circle_outline))
        ],
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () => debugPrint("Hello"),
          backgroundColor: Colors.greenAccent,
          child: Icon(Icons.call_missed)),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.account_balance_wallet_outlined),
              label: "Wallet"),
          BottomNavigationBarItem(
              icon: Icon(Icons.agriculture), label: "My Farm"),
          BottomNavigationBarItem(
              icon: Icon(Icons.add_circle), label: "Add Area"),
          //BottomNavigationBarItem(icon: Icon(Icons.access_alarms), title: Text("Timer")),
        ],
        onTap: (int index) => debugPrint("Tapped item: $index"),
      ),
      backgroundColor: Colors.grey,
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CustomButton()
            // InkWell(
            //     child: Text(
            //   "Click me!",
            //   style: TextStyle(fontSize: 23),
            // ),
            // onTap: () => debugPrint("Tapped...")

            //)
          ],
        ),
      ),
    );
  }
}


class CustomButton extends StatelessWidget {
  const CustomButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          final snackBar = SnackBar(
            content: Text("Hello Again"),
            backgroundColor: Colors.green,
          );
          Scaffold.of(context).showSnackBar(snackBar);
        },
        child: Container(
            padding: EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              color: Colors.blueGrey,
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Text("Button")));
  }
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
        color: Colors.blue,
        child: Center(
          child: Text("Hello World!",
              textDirection: TextDirection.ltr,
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 50,
                  fontStyle: FontStyle.italic,
                  color: Colors.deepPurpleAccent)),
        ));
  }
}
