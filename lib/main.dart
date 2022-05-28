import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);

  bool oTurn = true;

  // 1st player is O
  List<String> displayElement = ['', '', '', '', '', '', '', '', ''];
  int oScore = 0;
  int xScore = 0;
  int filledBoxes = 0;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:const Text('Tic Tac Toe'),
      ),
      body: Container(
        color: Colors.black,
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            const Center(
              child: Text(
                'TIC TAC TOE',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 26,
                  letterSpacing: 2,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    const Text(
                      "PLAYER 0",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 22,
                      ),
                    ),
                    Text(
                      widget.oScore.toString(),
                      style: const TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Column(
                  children: [
                    const Text(
                      "PLAYER X",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 22,
                      ),
                    ),
                    Text(
                      widget.xScore.toString(),
                      style: const TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 50,
            ),
            Expanded(
              flex: 3,
              child: GridView.builder(
                itemCount: 9,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3),
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      onTouch(index);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.black,
                          border: Border.all(
                            color: const Color(0xFF4deeea),
                            width: 3,
                          ),
                      ),

                      child: Center(
                        child: Text(
                          widget.displayElement[index],
                          style: const TextStyle(
                            fontSize: 30,
                            color:   Color(0xFF4deeea),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                        Colors.blueGrey,
                      ),
                    ),
                    onPressed: () {
                      clearScoreBoard();
                    },
                    child: const Text("Clear Score Board"),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void onTouch(int index) {
    setState(() {
      if (widget.oTurn && widget.displayElement[index] == "") {
        widget.displayElement[index] = "O";
        widget.filledBoxes++;
      } else if (!widget.oTurn && widget.displayElement[index] == "") {
        widget.displayElement[index] = "X";
        widget.filledBoxes++;
      }
      widget.oTurn = !widget.oTurn;
      checkWinner();
    });
  }

  void checkWinner() {
    //diagonal
    if (widget.displayElement[0] == widget.displayElement[4] &&
        widget.displayElement[0] == widget.displayElement[8] &&
        widget.displayElement[0] != "") {
      showWinner(widget.displayElement[0]);
    }
    if (widget.displayElement[2] == widget.displayElement[4] &&
        widget.displayElement[2] == widget.displayElement[6] &&
        widget.displayElement[2] != "") {
      showWinner(widget.displayElement[2]);
    }

    //col
    if (widget.displayElement[0] == widget.displayElement[3] &&
        widget.displayElement[0] == widget.displayElement[6] &&
        widget.displayElement[0] != "") {
      showWinner(widget.displayElement[0]);
    }
    if (widget.displayElement[1] == widget.displayElement[4] &&
        widget.displayElement[1] == widget.displayElement[7] &&
        widget.displayElement[1] != "") {
      showWinner(widget.displayElement[1]);
    }
    if (widget.displayElement[2] == widget.displayElement[5] &&
        widget.displayElement[2] == widget.displayElement[8] &&
        widget.displayElement[2] != "") {
      showWinner(widget.displayElement[2]);
    }

    //row
    if (widget.displayElement[0] == widget.displayElement[1] &&
        widget.displayElement[0] == widget.displayElement[2] &&
        widget.displayElement[0] != "") {
      showWinner(widget.displayElement[0]);
    }
    if (widget.displayElement[3] == widget.displayElement[4] &&
        widget.displayElement[3] == widget.displayElement[5] &&
        widget.displayElement[3] != "") {
      showWinner(widget.displayElement[3]);
    }
    if (widget.displayElement[6] == widget.displayElement[7] &&
        widget.displayElement[6] == widget.displayElement[8] &&
        widget.displayElement[6] != "") {
      showWinner(widget.displayElement[6]);
    }

    if (widget.filledBoxes == 9) {
      showDrawDialog();
    }
  }

  void showWinner(String winner) {
    showDialog(
      barrierDismissible: false,
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Winner Is $winner"),
            actions: [
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                    Colors.amber,
                  ),
                ),
                child: const Text("Play Again"),
                onPressed: () {
                  clearBoard();
                  if(widget.oTurn){
                    widget.oTurn = false;
                  }else{
                    widget.oTurn = true;
                  }
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
    if (winner == 'O') {
      widget.oScore++;
    } else if (winner == 'X') {
      widget.xScore++;
    }
  }

  void showDrawDialog() {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Draw"),
            actions: [
              ElevatedButton(
                child: const Text("Play Again"),
                onPressed: () {
                  clearBoard();
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }

  void clearBoard() {
    setState(() {
      widget.displayElement = ["", "", "", "", "", "", "", "", ""];
      widget.filledBoxes = 0;
      widget.oTurn = true;
    });
  }

  void clearScoreBoard() {
    setState(() {
      widget.oScore = 0;
      widget.xScore = 0;
      widget.displayElement = ["", "", "", "", "", "", "", "", ""];
      widget.filledBoxes = 0;
      widget.oTurn = true;
    });
  }
}
