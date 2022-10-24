import 'package:flutter/material.dart';

class Crossword extends StatefulWidget {
  Crossword({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _CrosswordState();
}

class _CrosswordState extends State<Crossword> {
  TextEditingController wordController = new TextEditingController();

  List<List<String>> gridState = [
    ['G', 'E', 'E', 'K', 'S', 'F', 'O', 'R', 'G', 'E', 'E', 'K', 'S'],
    ['G', 'E', 'E', 'K', 'S', 'Q', 'U', 'I', 'Z', 'G', 'E', 'E', 'K'],
    ['I', 'D', 'E', 'Q', 'A', 'P', 'R', 'A', 'C', 'T', 'I', 'C', 'E'],
    ['I', 'D', 'E', 'Q', 'A', 'P', 'R', 'A', 'C', 'T', 'I', 'C', 'E'],
    ['I', 'D', 'E', 'Q', 'A', 'P', 'R', 'A', 'C', 'T', 'I', 'C', 'E'],
    ['I', 'D', 'E', 'Q', 'A', 'P', 'R', 'A', 'C', 'T', 'I', 'C', 'E'],
    ['I', 'D', 'E', 'Q', 'A', 'P', 'R', 'A', 'C', 'T', 'I', 'C', 'E'],
  ];

  @override
  void initState() {
    super.initState();
    generateCrossword();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      child: Column(children: [
        Expanded(
          flex: 2,
          child: Container(
              constraints: new BoxConstraints(
                minHeight: size.height * .4,
                maxHeight: size.height * .4,
              ),
              alignment: Alignment.center,
              color: Colors.blueGrey,
              height: size.height,
              width: double.maxFinite,
              padding: EdgeInsets.all(10),
              child: GridView(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: gridState[0].length,
                  ),
                  children: <Widget>[
                    for (int i = 0; i != gridState.length; ++i)
                      for (int j = 0; j != gridState[0].length; ++j)
                        Card(
                          color: Color.fromRGBO(255, 240, 201, 1),
                          child: Center(
                            child: Text(
                              gridState[i][j],
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                        ),
                  ])
              //  GridView.builder(
              //   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              //       crossAxisCount: gridState[0].length),
              //   itemCount: gridState.length * gridState[0].length,
              //   itemBuilder: (BuildContext context, int index) {
              //     return Card(
              //       color: Colors.primaries[index % 10],
              //       child: Center(child: Text('$index')),
              //     );
              //   },
              // ),
              ),
        ),
        Expanded(
            flex: 1,
            child: Container(
              color: Colors.black54,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: TextFormField(
                      controller: wordController,
                      style: TextStyle(color: Colors.white),
                      decoration: const InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              width: 2, color: Colors.white), //<-- SEE HERE
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 3, color: Colors.blueGrey)),
                        iconColor: Colors.white,
                        fillColor: Colors.white,
                        labelText: 'Word to search',
                        labelStyle: TextStyle(color: Colors.white),
                        hintStyle: TextStyle(color: Colors.white),
                        helperStyle: TextStyle(color: Colors.white),
                        floatingLabelStyle: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  ElevatedButton(
                      style: ButtonStyle(
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8.0),
                                      side: BorderSide(color: Colors.grey)))),
                      child: Text('Buscar palabra'),
                      onPressed: () {}),
                  // Text('No repositories'),
                ],
              ),
            ))
      ]),
    );
  }
}

void generateCrossword() {}

/// Fills in any empty spaces in the puzzle with random letters.
// int _buildPuzzle(
//   /// The current state of the puzzle
//   List<List<String>> puzzle,
// ) {
//   for (var i = 0, height = puzzle.length; i < height; i++) {
//     List<String> row = puzzle[i];
//     for (var j = 0, width = row.length; j < width; j++) {
//       if (puzzle[i][j] == '') {
//         puzzle[i][j] = extraLetterGenerator();
//       }
//     }
//   }
//   return extraLettersCount;
// }
