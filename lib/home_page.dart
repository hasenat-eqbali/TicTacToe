
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:tic_tac_toe/custom_dialog.dart';
import 'package:tic_tac_toe/game_button.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<GameButtons> buttonsList;
  var player1;
  var player2;
  var activePlayer;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    buttonsList = doInit();
  }

  List<GameButtons> doInit() {
    player1 = new List();
    player2 = new List();
    activePlayer = 1;
    var gameButtons = <GameButtons>[
      new GameButtons(id: 1),
      new GameButtons(id: 2),
      new GameButtons(id: 3),
      new GameButtons(id: 4),
      new GameButtons(id: 5),
      new GameButtons(id: 6),
      new GameButtons(id: 7),
      new GameButtons(id: 8),
      new GameButtons(id: 9),
    ];
    return gameButtons;
  }

  void playGame(GameButtons gb) {
    setState(() {
      if (activePlayer == 1) {
        gb.text = 'X';
        gb.bg = Colors.red;
        activePlayer = 2;
        player1.add(gb.id);
      } else {
        gb.text = '0';
        gb.bg = Colors.black;
        activePlayer = 1;
        player2.add(gb.id);
      }
      gb.enabaled = false;
     int winner = checkWinner();
     if (winner == -1){
       if  (buttonsList.every((p) => p.text != '' )){
         showDialog(context: context,
         builder: (_) => new CustomDialog('Game Tied!', 'Press the RESET button to start again.', resetGame)
         );
       } else {
         activePlayer == 2 ? autoPlay():null;
       }
     }
    });
  }

  void autoPlay(){
    var emptyCells = new List();
    var list = new List.generate(9, (i) => i+1 );
    for (var cellID in list){
      if (!(player1.contains(cellID) || player2.contains(cellID))){
        emptyCells.add(cellID);
      }
    }
    var r = new Random();
    var randIndex = r.nextInt(emptyCells.length-1);
    var cellID = emptyCells[randIndex];
    var i =  buttonsList.indexWhere((p) => p.id==cellID);
    playGame(buttonsList[i]);
  }

  int checkWinner() {
    var winner = -1;
    if (player1.contains(1) && player1.contains(2) && player1.contains(3)) {
      winner = 1;
    }
    if (player2.contains(1) && player2.contains(2) && player2.contains(3)) {
      winner = 2;
    }
    if (player1.contains(4) && player1.contains(5) && player1.contains(6)) {
      winner = 1;
    }
    if (player2.contains(4) && player2.contains(5) && player2.contains(6)) {
      winner = 2;
    }
    if (player1.contains(7) && player1.contains(8) && player1.contains(9)) {
      winner = 1;
    }
    if (player2.contains(7) && player2.contains(8) && player2.contains(9)) {
      winner = 2;
    }
    if (player1.contains(1) && player1.contains(4) && player1.contains(7)) {
      winner = 1;
    }
    if (player2.contains(1) && player2.contains(4) && player2.contains(7)) {
      winner = 2;
    }
    if (player1.contains(2) && player1.contains(5) && player1.contains(8)) {
      winner = 1;
    }
    if (player2.contains(2) && player2.contains(5) && player2.contains(8)) {
      winner = 2;
    }
    if (player1.contains(3) && player1.contains(6) && player1.contains(9)) {
      winner = 1;
    }
    if (player2.contains(3) && player2.contains(6) && player2.contains(9)) {
      winner = 2;
    }
    if (player1.contains(1) && player1.contains(5) && player1.contains(9)) {
      winner = 1;
    }
    if (player2.contains(1) && player2.contains(5) && player2.contains(9)) {
      winner = 2;
    }
    if (player1.contains(3) && player1.contains(5) && player1.contains(7)) {
      winner = 1;
    }
    if (player2.contains(3) && player2.contains(5) && player2.contains(7)) {
      winner = 2;
    }
    if (winner != -1) {
      if (winner == 1) {
        showDialog(
            context: context,
            builder: (_) => new CustomDialog('Player 1 WON!',
                'Press the RESET button to start again.', resetGame));
      } else {
        showDialog(
            context: context,
            builder: (_) => new CustomDialog('Player 2 WON!',
                'Press the RESET button to start again.', resetGame));
      }
    }
    return winner;
  }
  void resetGame(){
    if (Navigator.canPop(context)) Navigator.pop (context);
    setState(() {
      buttonsList = doInit();
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(title: Center(child: new Text('Tic Tac Toe'))),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
                      child: new GridView.builder(
              padding: const EdgeInsets.all(10.0),
              gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 1.0,
                  crossAxisSpacing: 9.0,
                  mainAxisSpacing: 9.0),
              itemCount: buttonsList.length,
              itemBuilder: (context, i) => new SizedBox(
                width: 100.0,
                height: 100.0,
                child: new RaisedButton(
                  padding: const EdgeInsets.all(8.0),
                  onPressed:
                      buttonsList[i].enabaled ? () => playGame(buttonsList[i]) : null,
                  child: Text(
                    buttonsList[i].text,
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  color: buttonsList[i].bg,
                  disabledColor: buttonsList[i].bg,
                ),
              ),
            ),
          ),
          new RaisedButton(
            onPressed: resetGame,
            child: Text('Reset Game', style: TextStyle(color: Colors.white,fontSize: 20)),
            color: Colors.red,
            padding: EdgeInsets.all(20),
          )
        ],
      ),
    );
  }
}
